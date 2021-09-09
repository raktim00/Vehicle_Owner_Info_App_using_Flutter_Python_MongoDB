import pymongo

def find_details(vehical_number):
    client = pymongo.MongoClient("mongodb://localhost:27017/")
    db = client["RTO"]
    collection = db["IndianVehicalInformation"]
    info = collection.find_one({'CarNo': vehical_number},{'_id':0})
    if info == None:
        return ("Data Not Found")
    else:
        return(info)