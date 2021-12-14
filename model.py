import pickle
import pandas as pd
import numpy as np
from sklearn.metrics import classification_report
from sklearn import metrics
from sklearn import tree
from config import Config
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier

crop = pd.read_csv('Crop_recommendation.csv')
features = crop[['N', 'P','K','temperature', 'humidity', 'ph', 'rainfall']]
target = crop['label']
x_train, x_test, y_train, y_test = train_test_split(features,target,test_size = 0.2,random_state =2)
knn = KNeighborsClassifier()
knn.fit(x_train,y_train)
predicted_values = knn.predict(x_test)
x = metrics.accuracy_score(y_test, predicted_values)
print("KNN Accuracy is: ", x)
pickle.dump(knn, open('model.pkl','wb'))