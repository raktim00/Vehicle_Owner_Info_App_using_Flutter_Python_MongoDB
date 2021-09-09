from rekognition import detect_vehical_information
from flask import Flask, request

app = Flask("rtoapp")

@app.route('/uploader', methods = ['GET', 'POST'])
def upload_file1():
    if request.method == 'POST':
        uploaded_file = request.files['file']
        if uploaded_file.filename != '':
            return detect_vehical_information(uploaded_file)

if __name__ == "__main__":
    app.run(host='0.0.0.0')