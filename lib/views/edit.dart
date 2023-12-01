
import 'dart:io';
//test
import 'package:flutter/material.dart';
import 'package:noteapp/controller/link.dart'; 
import 'package:get/get.dart';
import 'package:noteapp/controller/image.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  get pickImageFromGallery => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16,32,16,0),
        child: Column(
          children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backHome(context),      
                ElevatedButton(
                  onPressed: () {
                    Get.find<ImagePickerController>().pickImageFromGallery();
                  },
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade800), 
                    elevation: MaterialStateProperty.all<double>(8.0),
                  ),
                ),
                checkButton(),
              ],
            ),
            Column(
              children: <Widget>[
                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 30)
                ),
                ),
                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Something Here...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16)
                  ),
                ),
                
                Obx(
                  () {
                    final uploadedImages = Get.find<ImagePickerController>().uploadedImages;
                    return Column(
                      children: uploadedImages.map((imagePath) {
                        return Stack(
                          children: [
                            Image.file(File(imagePath)),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: ClipOval(
                                child: SizedBox(
                                  
                                  width: 40,
                                  height: 40,
                                  child: Material(
                                    elevation: 0.0,
                                    color: Colors.grey.shade400.withOpacity(0.4),
                                  child: FloatingActionButton(
                                    onPressed:(){
                                      Get.find<ImagePickerController>().removeImage(imagePath);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    elevation: 0.0,
                                    backgroundColor: Colors.transparent,
                                    ),
                                  )
                                )
                              )
                            )
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ]
            ),
],
        ),
      ),
    );
  }
}