import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:yoripe/components/my_text_button.dart';
import 'package:yoripe/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String title = "Sign In";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool showErrorMsg = false;
  String errorMsg = "";

  void _showResetPasswordPage() {
    Navigator.pushNamed(context, '/resetpasswordpage');
  }

  void _showRegisterPage() {
    Navigator.pushNamed(context, '/registerpage');
  }

  void _showErrorMsg({String msg = 'Something went wrong'}) {
    setState(() {
      showErrorMsg = true;
      errorMsg = msg;
    });
  }

  void _hideEddorMsg() {
    setState(() {
      this.showErrorMsg = false;
      this.errorMsg = "";
    });
  }

  void _signInUserWithEmailPassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
      _hideEddorMsg();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        Navigator.pop(context);
        _showErrorMsg(msg: 'Wrong email or password');
      } else {
        _showErrorMsg();
      }
    }
  }

  void _signInWithUserGoogle() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(title,
                  style: TextStyle(
                    fontSize: 24,
                  )),
              SizedBox(
                height: 30,
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                    Spacer(),
                    GestureDetector(
                      onTap: _showResetPasswordPage,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
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
                  onTap: _signInUserWithEmailPassword, text: "Sign In"),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SignInButton(
                Buttons.Google,
                text: 'Sign in with Google',
                onPressed: _signInWithUserGoogle,
              ),
              SizedBox(
                height: 30,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: GestureDetector(
                  onTap: _showRegisterPage,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
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
