from flask import Flask, request, render_template
from flask_restful import reqparse, Api, Resource
from subprocess import Popen, PIPE, STDOUT
import json, csv

app = Flask(__name__)
api = Api(app)

@app.route('/')
def index():
    return render_template("index.htm")

class Result(Resource):
    def post(self):
        """with open('user-data.csv', 'wb') as data_file:
        	w = csv.DictWriter(data_file, json_data.keys())
        	w.writeheader()
        	w.writerow(json_data)"""

        json_data = request.get_json(force=True)
        p = Popen('Rscript test.R', stdout=PIPE, stderr=PIPE, stdin=PIPE)
        out, err = p.communicate(input = json.dumps(json_data))
        
        return {"data": json.dumps(json_data), "result": out}, 201

api.add_resource(Result, '/result')


if __name__ == '__main__':
    app.run(debug=True)