import pymongo
from pymongo import collection

if __name__ == "__main__" :
    client = pymongo.MongoClient("mongodb://localhost:27017/")
    db = client["VehicalDB"]
    collection = db["IndianVehicalInformation"]
    # data = [
    #     {"Car Number": "MH20DV2363", "Owner Name": "Raktim Midya", "Owner Phone Number": "8888899999", "Owner Location": "Nagpur, Maharastra", "Car Model Number": "SKODA SUPERB", "Registration Date": "25th Sept, 2020"},
    #     {"Car Number": "HR51BV3737", "Owner Name": "Aditya Raj", "Owner Phone Number": "7777766666", "Owner Location": "Gurugram, Haryana", "Car Model Number": "MARUTI SWIFT", "Registration Date": "5th Jan, 2019"}
    # ]
    # collection.insert_many(data)
    collection.insert_one({"Car Number": "MH20DV2363", "Owner Name": "Raktim Midya", "Owner Phone Number": "8888899999", "Owner Location": "Nagpur, Maharastra", "Car Model Number": "SKODA SUPERB", "Registration Date": "25th Sept, 2020"})
    # collection.insert_one({"Car Number": "HR51BV3737", "Owner Name": "Aditya Raj", "Owner Phone Number": "7777766666", "Owner Location": "Gurugram, Haryana", "Car Model Number": "MARUTI SWIFT", "Registration Date": "5th Jan, 2019"})
