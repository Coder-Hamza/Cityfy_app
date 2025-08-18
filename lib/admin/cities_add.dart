import 'dart:typed_data';

import 'package:cityguide_app/admin/services/cities_services.dart';
import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/core/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CitiesAdd extends StatefulWidget {
  const CitiesAdd({super.key});

  @override
  State<CitiesAdd> createState() => _CitiesAddState();
}

class _CitiesAddState extends State<CitiesAdd> {
  Uint8List? image;
  String? imagename;

  TextEditingController citynameController = TextEditingController();
  TextEditingController citydescController = TextEditingController();

  ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = await pickedImage.readAsBytes();
      imagename = pickedImage.name;
      setState(() {});
    }
  }

  CitiesServices citiesServices = CitiesServices();

  final _cityname = FocusNode();
  final _citydesc = FocusNode();

  @override
  void dispose() {
    _cityname.dispose();
    _citydesc.dispose();
    citynameController.dispose();
    citydescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Cities"),
        backgroundColor: Appcolors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // <-- fix yaha
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 180,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upload Image",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.upload, size: 80),
                          ],
                        )
                      : Image.memory(image!, fit: BoxFit.cover),
                ),
              ),
              20.verticalSpace,
              TextField(
                controller: citynameController,
                focusNode: _cityname,
                decoration: InputDecoration(
                  hintText: "City Name",
                  border: OutlineInputBorder(),
                ),
              ),
              15.verticalSpace,
              TextField(
                controller: citydescController,
                focusNode: _citydesc,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "City Description",
                  border: OutlineInputBorder(),
                ),
              ),
              20.verticalSpace,
              CustomButton(
                onPressed: () {
                  if (image == null ||
                      citynameController.text.isEmpty ||
                      citydescController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("All fields are required")),
                    );
                    return;
                  } else {
                    citiesServices.addCity(
                      image!,
                      imagename!,
                      citynameController.text,
                      citydescController.text,
                    );
                  }

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/citiesPage',
                    (routes) => false,
                  );

                  /// fields clear + image clear
                  FocusScope.of(context).unfocus();
                  citynameController.clear();
                  citydescController.clear();

                  setState(() {
                    image = null;
                    imagename = null;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("City Added Successfully"),
                      backgroundColor: Appcolors.primaryColor,
                    ),
                  );
                },
                text: "Add City",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
