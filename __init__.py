#!flask/bin/python
from flask import Flask, request, render_template
from flask_restful import reqparse, Api, Resource
from subprocess import Popen, PIPE, STDOUT
import json, os, re

app = Flask(__name__)
api = Api(app)

@app.route('/')
def index():
    return render_template("index.htm")

class Result(Resource):
    def post(self):
        json_data = request.get_json(force=True)
        
        path = os.path.join(os.getcwd(), 'run.models.v3.R')
        print path
        p = Popen('Rscript ' + path, stdout=PIPE, stderr=PIPE, stdin=PIPE, shell=True)
        out, err = p.communicate(input = json.dumps(json_data) + "\n")

        out = re.search('(a-dm-(true|false))|error', out).group(0)
        
        return {"data": json.dumps(json_data), "result": out.decode('latin-1').encode("utf-8"), "err": err.decode('latin-1').encode("utf-8")}, 201

class Fields(Resource):
    def get(self):
        path = os.path.join(os.getcwd(), 'fields.json')
        fieldsJSON = open(path).read()
        return {"data": fieldsJSON}, 200

api.add_resource(Result, '/result')
api.add_resource(Fields, '/fields')


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
