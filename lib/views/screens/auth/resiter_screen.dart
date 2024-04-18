import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_shop_app/Controllers/auth_controller.dart';
import 'package:uber_shop_app/views/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // const RegisterScreen({super.key});
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  late String email;

  late String fullName;

  late String password;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  captureImage() async {
    Uint8List im = _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  // Register User
  registerUser() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        String res = await _authController.createNewUser(
            email, fullName, password, _image!);
        setState(() {
          _isLoading = false;
        });
        if (res == 'success') {
          setState(() {
            _isLoading = false;
          });
          Get.to(LoginScreen());
          Get.snackbar(
            'Register Success',
            'You are registered successfully',
            backgroundColor: Colors.pink,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(15),
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
          );
        } else {
          Get.snackbar(
            'Register Failed',
            res.toString(),
            backgroundColor: Colors.pink,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(15),
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
          );
        }
      } else {
        Get.snackbar(
          'Form Validation Failed',
          'Please check the form again',
          backgroundColor: Colors.pink,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(15),
          icon: Icon(
            Icons.message,
            color: Colors.white,
          ),
        );
      }
    } else {
      Get.snackbar(
        'Image Not Selected',
        'Please select an image',
        backgroundColor: Colors.pink,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(15),
        icon: Icon(
          Icons.message,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resiter Account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      _image == null
                          ? CircleAvatar(
                              radius: 65,
                              child: Icon(
                                Icons.person,
                                size: 70,
                              ),
                            )
                          : CircleAvatar(
                              radius: 65,
                              backgroundImage: MemoryImage(_image!),
                            ),
                      Positioned(
                        top: 15,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            selectGalleryImage();
                          },
                          icon: Icon(
                            CupertinoIcons.photo,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Email Address Must Not Be Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      prefixIcon: Icon(Icons.email, color: Colors.pink),
                      // border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Full Name Must Not Be Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your Full Name',
                      prefixIcon: Icon(Icons.person, color: Colors.pink),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Password Must Not Be Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock, color: Colors.pink),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      // if (_formKey.currentState!.validate()) {
                      //   _authController.createNewUser(email, fullName, password, _image!);
                      //   print('success...');
                      // } else {
                      //   print('invalid...');
                      // }
                      registerUser();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Resiter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account?',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
