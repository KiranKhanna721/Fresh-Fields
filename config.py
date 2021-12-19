import os
basedir = os.path.abspath(os.path.dirname(__file__))
class Config(object):
  SECRET_KEY = os.environ.get('SECRET_KEY') or 'modzy modelops are incredibles'
  DEBUG =  os.environ.get('FLASK_DEBUG') or 0
