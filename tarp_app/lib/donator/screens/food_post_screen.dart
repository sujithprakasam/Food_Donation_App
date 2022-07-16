import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tarp_app/donator/resources/donator_auth_methods.dart';
import 'package:tarp_app/donator/resources/donator_firestore_method.dart';
import 'package:tarp_app/donator/responsive/donator_screen_layout.dart';
import 'package:tarp_app/donator/screens/food_screen.dart';
import 'package:tarp_app/donator/utils.dart';
import 'package:tarp_app/textinputfield.dart';

class AddFoodPostScreen extends StatefulWidget {
  const AddFoodPostScreen({Key? key}) : super(key: key);

  @override
  _AddFoodPostScreenState createState() => _AddFoodPostScreenState();
}

class _AddFoodPostScreenState extends State<AddFoodPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _lcityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  bool isLoading = false;
  bool isL = false;
  Uint8List? _image;

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickimage(ImageSource.camera);
                  setState(() {
                    _image = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickimage(ImageSource.gallery);
                  setState(() {
                    _image = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage() async {
    setState(() {
      isLoading = true;
      isL = true;
    });
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String res = await DonatorFireStoreMethods().uploadFoodPost(
          _titleController.text,
          _descriptionController.text,
          _timeController.text,
          _addressController.text,
          _lcityController.text,
          _pincodeController.text,
          _image!,
          uid);
      if (res == "success") {
        setState(() {
          isLoading = false;
          isL = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
        Navigator.pop(context);
        ;
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
        isL = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 50),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Flexible(
                //   child: Container(),
                //   flex: 3,
                // ),
                const SizedBox(
                  height: 44,
                ),
                Center(
                  child: Text(
                    'Enter the details of the Food',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(_image!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Container(
                                height: 150,
                                width: 150,
                              ),
                            )
                          : Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn.icon-icons.com/icons2/564/PNG/512/Add_Image_icon-icons.com_54218.png'),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                  onTap: () => _selectImage(context),
                ),
                const SizedBox(
                  height: 34,
                ),
                TextFieldInput(
                  hintText: 'Title',
                  textInputType: TextInputType.text,
                  textEditingController: _titleController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Description',
                  textInputType: TextInputType.text,
                  textEditingController: _descriptionController,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Time at which the food is Cooked',
                  textInputType: TextInputType.text,
                  textEditingController: _timeController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your Address',
                  textInputType: TextInputType.text,
                  textEditingController: _addressController,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your Locality(Ex. Guindy, Chennai)',
                  textInputType: TextInputType.text,
                  textEditingController: _lcityController,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your pincode',
                  textInputType: TextInputType.number,
                  textEditingController: _pincodeController,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  child: Container(
                    child: isL
                        ? CircularProgressIndicator()
                        : const Text(
                            'Add Post',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontSize: 14,
                            ),
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Color.fromARGB(255, 19, 102, 209),
                    ),
                  ),
                  onTap: isL ? () {} : () => postImage(),
                ),

                // Flexible(
                //   child: Container(),
                //   flex: 6,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
