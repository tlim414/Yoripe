import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoripe/components/my_text_button.dart';
import 'package:yoripe/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  bool showErrorMsg = false;
  String errorMsg = "";

  void _showErrorMsg({String msg = 'Something went wrong'}) {
    setState(() {
      this.showErrorMsg = true;
      this.errorMsg = msg;
    });
  }

  void _hideErrorMsg() {
    setState(() {
      this.showErrorMsg = false;
      this.errorMsg = "";
    });
  }

  void _signUpUserEmailPassword() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // TODO: Store name associated with email

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        Navigator.pop(context);
        Navigator.pop(context);
        _hideErrorMsg();
      } else {
        _showErrorMsg(msg: 'Passwords don\'t match');
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        _showErrorMsg(msg: 'User already exists');
      }
      else {
        _showErrorMsg();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text('Create an account',
                  style: TextStyle(
                    fontSize: 24,
                  )),
              SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: firstNameController,
                hintText: 'First Name',
                obscureText: false,
              ),
              SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: lastNameController,
                hintText: 'Last Name',
                obscureText: false,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: showErrorMsg,
                      child: Text(
                        errorMsg,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MyTextButton(
                onTap: _signUpUserEmailPassword,
                text: "Sign Up",
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
