import 'dart:io';

import 'package:app/models/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? pickedImage;

  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.green.shade50
                      : Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),

                // height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Chọn ảnh từ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? MyColors.darkGreen
                                    : Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.green.shade200
                                  : Colors.white60, // Background color
                              foregroundColor: Colors.white, // Text color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Button border radius
                              ),
                            ),
                            onPressed: () {
                              pickImageFun(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text("Máy ảnh"),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.green.shade200
                                  : Colors.white60, // Background color
                              foregroundColor: Colors.white, // Text color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Button border radius
                              ),
                            ),
                            onPressed: () {
                              pickImageFun(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.image),
                            label: const Text("Thư viện"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  pickImageFun(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) {
        Navigator.pop(context);
        return;
      }
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
      Get.back();
      Navigator.pop(context);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: pickedImage != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        child: Image.file(
                          pickedImage!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        child: Image.asset(
                          "assets/pretty.jpg",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Positioned(
                top: -5,
                right: -10,
                child: InkWell(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: Image.asset(
                    "assets/plusicon.png",
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
