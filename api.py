from flask import Flask, request, render_template
from flask_restful import reqparse, Api, Resource
import subprocess, json, csv

app = Flask(__name__)
api = Api(app)

@app.route('/')
def index():
    return render_template("index.htm")

class Result(Resource):
    def post(self):
        #p = subprocess.Popen('Rscript test.R', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        #out, err = p.communicate()
        json_data = request.get_json(force=True)

        with open('user-data.csv', 'wb') as data_file:
        	w = csv.DictWriter(data_file, json_data.keys())
        	w.writeheader()
        	w.writerow(json_data)
        
        return {"result": json.dumps(json_data)}, 201

api.add_resource(Result, '/result')


if __name__ == '__main__':
    app.run(debug=True)