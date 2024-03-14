import 'package:flutter/material.dart';
import 'package:uber_shop_app/Controllers/auth_controller.dart';
import 'package:uber_shop_app/views/screens/auth/login_screen.dart';

class ResiterScreen extends StatelessWidget {
  // const ResiterScreen({super.key});
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String fullName;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Form(
          key: _formKey,
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
              CircleAvatar(
                radius: 65,
                child : Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Please Email Address Must Not Be Empty';
                  }else{
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
                  if(value!.isEmpty) {
                    return 'Please Full Name Must Not Be Empty';
                  }else{
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
                  if(value!.isEmpty) {
                    return 'Please Password Must Not Be Empty';
                  }else{
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
                  if(_formKey.currentState!.validate()) {
                    _authController.createNewUser(email, fullName, password);
                    print('success...');
                  }else{
                    print('invalid...');
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
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
              TextButton (
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  LoginScreen(),
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
    );
  }
}
