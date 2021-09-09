import pymongo
from pymongo import collection

if __name__ == "__main__" :
    client = pymongo.MongoClient("mongodb://localhost:27017/")
    db = client["RTO"]
    collection = db["IndianVehicalInformation"]
    # data = [
    #     {'CarNo': "MH20DV2363", "Name": "Raktim0", "Number": 450, "Remarks" : "Best"},
    #     {'CarNo': "HR51BV3737", "Name": "Raktim1", "Number": 451, "Remarks" : "Avg"}
    # ]
    # collection.insert_many(data)
    collection.insert_one({'CarNo': "MH20DV2363", "Name": "Raktim0", "Number": 450, "Remarks" : "Best"})