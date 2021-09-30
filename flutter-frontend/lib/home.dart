import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? selectedImage;

  String message = "";
  String carNo = "";
  String carModelNo = "";
  String ownerName = "";
  String ownerPhoneNo = "";
  String ownerLocation = "";
  String registrationDate = "";

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  uploadImage() async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "http://ec2-3-108-205-140.ap-south-1.compute.amazonaws.com:5000/uploader"),
    );
    final headers = {"content-type": "multipart/form-data"};
    if (selectedImage == null) {
      message =
          'Please Select the Vehical Image first & then click on - "Show Details"';
      carNo = "";
    } else {
      request.files.add(http.MultipartFile(
        "image",
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last,
      ));
      request.headers.addAll(headers);
      final response = await request.send();
      http.Response res = await http.Response.fromStream(response);

      if (res.body == "Number Not Found") {
        message = "OOps, The Uploaded image has no Vehical Number";
        carNo = "";
      } else if (res.body == "Data Not Found") {
        message = "No Record found for the Selected Vehical Number";
        carNo = "";
      } else {
        message = "";
        final jsonResponse = jsonDecode(res.body);
        carNo = jsonResponse["Car Number"];
        carModelNo = jsonResponse["Car Model Number"];
        ownerName = jsonResponse["Owner Name"];
        ownerPhoneNo = jsonResponse["Owner Phone Number"];
        ownerLocation = jsonResponse["Owner Location"];
        registrationDate = jsonResponse["Registration Date"];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double padding = width * 0.09;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehical Information App"),
      ),
      body: Container(
        color: Colors.yellowAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage == null
                ? Padding(
                    padding: EdgeInsets.all(padding),
                    child: SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/Welcome to VehicalInfo App.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: width * 0.85,
                      height: height * 0.35,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(padding),
                    child: SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: width * 0.85,
                      height: height * 0.35,
                    ),
                  ),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.cyan),
              ),
              onPressed: uploadImage,
              icon: const Icon(
                Icons.article_outlined,
                color: Colors.black,
              ),
              label: const Text(
                "Show Details",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            message == "" && carNo == ""
                ? Padding(
                    padding: EdgeInsets.all(padding),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(padding * 0.6),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Vehical Information will be displayed here...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      width: width * 0.85,
                      height: height * 0.28,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        message != "" && carNo == ""
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(padding * 0.6),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      message,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.pink,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                width: width * 0.85,
                                height: height * 0.28,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange,
                                ),
                                width: width * 0.85,
                                height: height * 0.28,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(padding * 0.5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.all(padding * 0.2),
                                          child: Text(
                                            "Vehical Number : " + carNo,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Vehical Model : " + carModelNo,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.all(padding * 0.2),
                                          child: Text(
                                            "Owners Name : " + ownerName,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Owners Phone Number : " +
                                              ownerPhoneNo,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.all(padding * 0.2),
                                          child: Text(
                                            "Owners Location : " +
                                                ownerLocation,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Vehical Registration Date : " +
                                              registrationDate,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: const Icon(
            Icons.add_photo_alternate_outlined,
          )),
    );
  }
}
