from flask import Flask, request, jsonify, render_template
import pandas as pd
import numpy as np
import pickle

app = Flask(__name__)
model = pickle.load(open('model.pkl', 'rb'))
@app.route('/')
def index():
    return render_template('/index.html')
@app.route('/predict', methods=["GET", "POST"])
def predict():
    if request.method == "POST":
        l=[]
        Nitrogen = int(request.form["Nitrogen"])
        l.append(Nitrogen)
        Phosphorus = int(request.form["Phosphorus"])
        l.append(Phosphorus)
        Potassium = int(request.form["Potassium"])
        l.append(Potassium)
        Temperature = int(request.form["Temperature"])
        l.append(Temperature)
        Humidity = int(request.form["Humidity"])
        l.append(Humidity)
        PH = int(request.form["PH"])
        l.append(PH)
        Rainfall = int(request.form["Rainfall"])
        l.append(Rainfall)
        arr = np.array([l])
        prediction = model.predict(arr)
        #output = round(prediction[0], 2)
        return render_template('/crop.html',predict='Crop that should be grown {}'.format(prediction))
    return render_template("/crop.html",predict=None)




if __name__ == '__main__':
    app.run()