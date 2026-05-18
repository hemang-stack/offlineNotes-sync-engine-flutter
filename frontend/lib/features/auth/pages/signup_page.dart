import 'package:flutter/material.dart';
import 'package:frontend/features/auth/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(builder: (context) => const SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUpUser() {
    if (formKey.currentState!.validate()) {
      //store the user data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sign Up.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name field cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.trim().contains('@')) {
                    return "Email field is Invalid!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Set Password"),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length <= 6) {
                    return "Password field is invalid!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUpUser,
                child: Text(
                  'SIGN UP',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
