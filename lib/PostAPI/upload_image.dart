import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  var success = "No Data";

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {
        
      });
    } else {
      print("No Image Selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");

    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = "Praveen Sundriyal";

    var multipart = http.MultipartFile("image", stream, length);

    request.files.add(multipart);

    var response = await request.send();

    if(response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Image Uploaded");
      success = "Image Uploaded";
    } else {
      setState(() {
        showSpinner = false;
      });
      print("Upload Failed");
      success = "Upload Failed";
    }


  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Upload Image")),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null
                    ? Center(
                        child: Text("Pick Image"),
                      )
                    : Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.file(
                          File(image!.path).absolute,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ),
            ),

            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                uploadImage();
              },
              child: Text("Upload"),
            ),

            SizedBox(height: 20,),
            
            Text("$success", style: TextStyle(fontSize: 24),),
          ],
        ),
      ),
    );
  }
}
