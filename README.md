# 🌾 Fresh Fields

An AI toolkit for farmers that brings together four helpers: crop recommendation, fertilizer recommendation, plant-disease detection from leaf photos, and a conversational farming assistant that can chat or take phone calls.

## ✨ Features

| Tool | What it does | Built with |
|---|---|---|
| **Crop recommendation** | Suggests which of 22 crops to grow from soil nutrients (N, P, K), temperature, humidity, pH and rainfall | Flask, scikit-learn (K-Nearest Neighbors) |
| **Fertilizer recommendation** | Recommends one of 7 fertilizers (Urea, DAP, 10-26-26, 14-35-14, 17-17-17, 20-20, 28-28) from weather, soil moisture, soil type, crop type and nutrient levels | Flask, scikit-learn (Random Forest tuned with GridSearchCV) |
| **Plant-disease detection** | Classifies an uploaded leaf photo as corn common rust, potato early blight or tomato bacterial spot | Streamlit, Keras CNN, OpenCV |
| **Farming voice assistant** | Talks with farmers about the difficulties they face, whether they need technical or financial help, and walks through basic farming steps | Dasha.AI (DSL + Node.js SDK) |

## 📁 Project structure

```
Fresh-Fields/
├── app.py                      # Flask web app: crop & fertilizer recommendation
├── model.py                    # Trains the crop model (KNN) → model.pkl
├── mode1.py                    # Trains the fertilizer model (Random Forest) → model1.pkl
├── Crop_recommendation.csv     # 2,200 rows, 22 crops
├── Fertilizer Prediction.csv   # 99 rows, 7 fertilizers
├── config.py                   # Flask config (SECRET_KEY, FLASK_DEBUG from env)
├── templates/ · static/        # Web pages and styles
├── Procfile                    # gunicorn entry point for deployment
├── Innerve/                    # Streamlit plant-disease detection app
│   ├── app1.py                 # Entry point with sidebar navigation
│   ├── app.py · app2.py        # Disease detection pages
│   └── plant_disease.h5        # Trained Keras model
└── farming/                    # Dasha.AI conversational assistant
    ├── index.js
    └── app/main.dsl            # Conversation flow
```

## 🚀 Getting started

### 1. Crop & fertilizer recommendation (Flask)

```bash
pip install -r requirements.txt
python app.py
```

Open http://127.0.0.1:5000. To retrain the models, run `python model.py` (crop) and `python mode1.py` (fertilizer).

The fertilizer form expects soil type and crop type as numbers, using the same encoding as training:

| Soil type | Code | | Crop type | Code |
|---|---|---|---|---|
| Black | 0 | | Barley | 0 |
| Clayey | 1 | | Cotton | 1 |
| Loamy | 2 | | Ground Nuts | 2 |
| Red | 3 | | Maize | 3 |
| Sandy | 4 | | Millets | 4 |
| | | | Oil seeds | 5 |
| | | | Paddy | 6 |
| | | | Pulses | 7 |
| | | | Sugarcane | 8 |
| | | | Tobacco | 9 |
| | | | Wheat | 10 |

### 2. Plant-disease detection (Streamlit)

```bash
cd Innerve
pip install -r requirements.txt
streamlit run app1.py
```

Upload a `.jpg` leaf photo and click **Predict**.

### 3. Farming voice assistant (Dasha.AI)

```bash
cd farming
npm install
npx dasha account login     # create or log into a Dasha account
npm start chat              # text chat in the terminal
npm start <phone number>    # or receive a phone call
```

Conversation transcripts are written to `farming/log.txt`.

## ⚠️ Known issues

- The **Potato Plant Disease** page (`Innerve/app2.py`) loads `p.h5`, which isn't in the repo, so only the first disease page works.
- The first disease page is labelled "Rice Plant Disease" in the sidebar, but its model classifies corn, potato and tomato leaves.
- The fertilizer dataset orders its columns Nitrogen, **Potassium, Phosphorous**, while the web form sends Nitrogen, **Phosphorus, Potassium**, so those two inputs are swapped at prediction time.

## 🛠️ Tech stack

Python · Flask · scikit-learn · pandas · NumPy · Streamlit · Keras / TensorFlow · OpenCV · Node.js · Dasha.AI · gunicorn

## 📄 License

See [LICENSE](LICENSE).
