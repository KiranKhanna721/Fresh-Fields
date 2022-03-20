import numpy as np
import streamlit as st
from keras.models import load_model
import app
import app2
PAGES = {
    "Rice Plant Disease": app ,
    "Potato Plant Disease": app2 
}
st.sidebar.title('Fresh Fields')
selection = st.sidebar.radio("Go to", list(PAGES.keys()))
page = PAGES[selection]
page.app()