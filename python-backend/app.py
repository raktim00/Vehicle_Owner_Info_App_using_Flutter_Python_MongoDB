from rekognition import detect_vehical_information
from flask import Flask, request

app = Flask(__name__)

@app.route('/uploader', methods=['POST'])
def upload():
    if (request.method == 'POST'):
        uploaded_file = request.files['image']
        if uploaded_file.filename != '':
           return detect_vehical_information(uploaded_file)
        else:
           return 'No Image Uploaded'

if __name__ == "__main__":
    app.run(host='0.0.0.0')
