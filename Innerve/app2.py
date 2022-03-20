import numpy as np
import streamlit as st
from keras.models import load_model
import cv2

def app():
    model = load_model('p.h5')
    CLASS_NAMES = ['Early_Blight', 'Healthy', 'Late_Blight']
    st.title("Potato Plant  Disease Detection")
    st.markdown("Upload an image of the plant leaf")


    plant_image = st.file_uploader("Choose an image...", type="jpg")
    submit = st.button('Predict')

    if submit:


        if plant_image is not None:

        # Convert the file to an opencv image.
            file_bytes = np.asarray(bytearray(plant_image.read()), dtype=np.uint8)
            opencv_image = cv2.imdecode(file_bytes, 1)



        # Displaying the image
            st.image(opencv_image, channels="BGR")
            st.write(opencv_image.shape)
        #Resizing the image
            opencv_image = cv2.resize(opencv_image, (150,150))
        #Convert image to 4 Dimension
            opencv_image.shape = (1,150,150,3)
        #Make Prediction
            Y_pred = model.predict(opencv_image)
            result = CLASS_NAMES[np.argmax(Y_pred)]
            st.title(result)