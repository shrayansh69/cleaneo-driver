import 'dart:io';

import 'package:cleaneo_driver_app/Global/global.dart';
import 'package:cleaneo_driver_app/Screens/Driver_Onboarding/VehDetails.dart';
import 'package:cleaneo_driver_app/Screens/Driver_Onboarding/uploadAdhaar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class UploadPAN extends StatefulWidget {
  const UploadPAN({Key? key}) : super(key: key);

  @override
  State<UploadPAN> createState() => _UploadPANState();
}

class _UploadPANState extends State<UploadPAN> {
  TextEditingController panController = TextEditingController();
  XFile? _image1;
  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff006acb),
        ),
        child: Column(
          children: [
            SizedBox(height: mQuery.size.height * 0.034),
            Padding(
              padding: const EdgeInsets.only(
                  top: 45, left: 16, right: 16, bottom: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: mQuery.size.width * 0.045,
                  ),
                  const Text(
                    "Upload PAN Card",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'SatoshiBold',
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: const Offset(
                          0, 0), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: mQuery.size.width * 0.9,
                              child: const Text(
                                "Take a picture of the front and back side of your document in a HORIZONTAL position.",
                                style: TextStyle(fontFamily: 'SatoshiMedium'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.03,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          width: double.infinity,
                          height: mQuery.size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 0), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                pan = value;
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                pan = value;
                              });
                            },
                            cursorColor: Colors.grey,
                            controller: panController,
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Enter PAN Card Number",
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'SatoshiBold',
                                  color: Color(0xffABAFB1)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.05,
                        ),
                        buildImageContainer(
                            mQuery, _image1, 1), // First Image Container
                        SizedBox(
                          height: mQuery.size.height * 0.3,
                        ),
                        Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (pan.isNotEmpty && panDetails1 != null) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return VehDetails();
                                  }));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Please fill all the details'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(16.0),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: mQuery.size.height * 0.06,
                                decoration: BoxDecoration(
                                    color: const Color(0xff29b2fe),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'SatoshiBold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mQuery.size.height * 0.01,
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImageContainer(
      MediaQueryData mQuery, XFile? imageFile, int index) {
    return GestureDetector(
      onTap: () async {
        final imageSource = await showModalBottomSheet<ImageSource>(
          backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text(
                      'Camera',
                      style: TextStyle(
                        fontFamily: 'SatoshiMedium',
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text(
                      'Gallery',
                      style: TextStyle(
                        fontFamily: 'SatoshiMedium',
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  ),
                ],
              ),
            );
          },
        );
        if (imageSource != null) {
          final XFile? pickedImage =
              await _imagePicker.pickImage(source: imageSource);

          setState(() {
            if (index == 1) {
              _image1 = pickedImage;
              panDetails1 = _image1;
            }
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: mQuery.size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: imageFile != null
              ? DecorationImage(
                  image: FileImage(File(imageFile.path)),
                  fit: BoxFit.cover,
                )
              : null, // Null if imageFile is null
        ),
        child: imageFile == null
            ? SvgPicture.asset(
                "assets/adhaarpicker.svg",
                height: mQuery.size.height * 0.2,
              )
            : null, // No child if imageFile is not null
      ),
    );
  }
}
