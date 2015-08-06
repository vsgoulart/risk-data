from flask import Flask, request, render_template
from flask_restful import reqparse, Api, Resource
import subprocess

app = Flask(__name__)
api = Api(app)

@app.route('/')
def index():
    return render_template("index.htm")

class Result(Resource):
    def post(self):
        p = subprocess.Popen('Rscript test.R', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = p.communicate()
        return {"result": out}, 201

api.add_resource(Result, '/result')


if __name__ == '__main__':
    app.run(debug=True)