from flask import Flask
from flask_restful import Resource, Api

import routes

app = Flask(__name__)
api = Api(app)

class KindleNoticeBoard(Resource):
    def get(self):
        return routes.knb()

api.add_resource(KindleNoticeBoard, '/knb')

if __name__ == '__main__':
    app.run()
