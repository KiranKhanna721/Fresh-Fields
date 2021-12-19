from flask import Flask, request, jsonify, render_template
import numpy as np
import pickle
import os
from config import Config
app = Flask(__name__)
app.config.from_object(Config)
model = pickle.load(open('model.pkl', 'rb'))
model1 = pickle.load(open('model1.pkl', 'rb'))
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
    return render_template('/crop.html',predict=None)

@app.route('/predict1', methods=["GET", "POST"])
def predict1():
    if request.method == "POST":
        l=[]
        Temperature = int(request.form["Temperature"])
        l.append(Temperature)
        Humidity = int(request.form["Humidity"])
        l.append(Humidity)
        Moisture = int(request.form["Moisture"])
        l.append(Moisture)
        SoilType = int(request.form["SoilType"])
        l.append(SoilType)
        CropType = int(request.form["CropType"])
        l.append(CropType)
        Nitrogen = int(request.form["Nitrogen"])
        l.append(Nitrogen)
        Phosphorus = int(request.form["Phosphorus"])
        l.append(Phosphorus)
        Potassium = int(request.form["Potassium"])
        l.append(Potassium)
        arr = np.array([l])
        
        prediction = model1.predict(arr)
        out=""
        if prediction == 0:
            out = "10-26-26"
        elif prediction ==1:
            out = "14-35-14"
        elif prediction == 2:
            out="17-17-17"
        elif prediction == 3:
            out = "20-20"
        elif prediction == 4:
            out = "28-28"
        elif prediction == 5:
            out = "DAP"
        else:
            out = "Urea"
        return render_template('/fer.html',predict1='Fertilizer that should be used is : {}'.format(out))
    return render_template("/fer.html",predict1=None)


if __name__ == '__main__':
    app.run()
