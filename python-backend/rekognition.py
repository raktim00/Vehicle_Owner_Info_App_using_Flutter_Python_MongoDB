from mongodb import find_details
import boto3, re

def number_regex(number_list):
    if number_list != []:
        for i in number_list:
            number = re.search("^[A-Z]{2}[0-9]{1,2}[A-Z|a-z|0-9]{1,2}[0-9]{1,4}$", i)
            number = number.group()
        try:
            return(find_details(number))
        except AttributeError:
            pass
    else:
        return "Number Not Found"

def detect_vehical_information(photo):
    client=boto3.client('rekognition')
    response = client.detect_text(Image={'Bytes': photo.read()})
    n = []
    for label in response['TextDetections']:
        x = ("".join(label['DetectedText'].split()))
        if len(x) == 10:
            n.append(x)
    return number_regex(n)