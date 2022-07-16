import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarp_app/donator/utils.dart';
import 'package:tarp_app/ngo/resources/ngo_auth_methods.dart';
import 'package:tarp_app/ngo/screens/login_screen.dart';
import 'package:tarp_app/ngo/screens/ngo_screen_layout.dart';
import 'package:tarp_app/textinputfield.dart';

class NgoSignUpScreen extends StatefulWidget {
  const NgoSignUpScreen({Key? key}) : super(key: key);

  @override
  _NgoSignUpScreenState createState() => _NgoSignUpScreenState();
}

class _NgoSignUpScreenState extends State<NgoSignUpScreen> {
  final TextEditingController _ngonameController = TextEditingController();
  final TextEditingController _ngoregController = TextEditingController();
  final TextEditingController _ngoidController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _headnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _ngonameController.dispose();
    _ngoregController.dispose();
    _ngoidController.dispose();
    _panController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _headnameController.dispose();
    _addressController.dispose();
    _locationController.dispose();
    _pincodeController.dispose();
  }

  void NsignUpUser() async {
    String res = await NAuthMethods().NsignUpUser(
      ngoname: _ngonameController.text,
      ngoregno: _ngoregController.text,
      uniqueid: _ngoidController.text,
      pannumber: _panController.text,
      file: _image!,
      city: _cityController.text,
      state: _stateController.text,
      nameofhead: _headnameController.text,
      address: _addressController.text,
      location: _locationController.text,
      pincode: _pincodeController.text,
      email: _emailController.text,
      mobilenumber: _phoneNumberController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NgoScreenLayout(),
        ),
      );
    }
    showSnackBar(context, res);
  }

  selectImage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 44,
                ),
                Container(
                  child: Text(
                    'NGO Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.red,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            backgroundColor: Colors.red,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 54,
                ),
                TextFieldInput(
                  hintText: 'Enter NGO Name',
                  textInputType: TextInputType.text,
                  textEditingController: _ngonameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter NGO REG NO.',
                  textInputType: TextInputType.text,
                  textEditingController: _ngoregController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter Unique Id of NGO',
                  textInputType: TextInputType.text,
                  textEditingController: _ngoidController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter PAN number of NGO',
                  textInputType: TextInputType.text,
                  textEditingController: _panController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter City of registration',
                  textInputType: TextInputType.text,
                  textEditingController: _cityController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter State of registration',
                  textInputType: TextInputType.text,
                  textEditingController: _stateController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Name of head of NGO',
                  textInputType: TextInputType.text,
                  textEditingController: _headnameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter Address of NGO Office',
                  textInputType: TextInputType.text,
                  textEditingController: _addressController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter location(Ex. Chennai, Tamilnadu)',
                  textInputType: TextInputType.text,
                  textEditingController: _locationController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter Pincode',
                  textInputType: TextInputType.number,
                  textEditingController: _pincodeController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter Email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter Phone Number',
                  textInputType: TextInputType.number,
                  textEditingController: _phoneNumberController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  child: Container(
                    child: const Text(
                      'Sign Up',
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
                  onTap: NsignUpUser,
                ),
                const SizedBox(
                  height: 12,
                ),
                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                const SizedBox(
                  height: 34,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        'Already have an account?',
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NgoLoginScreen(),
                        ),
                      ),
                      child: Container(
                        child: const Text(
                          ' Login.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
