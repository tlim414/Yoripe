import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoripe/components/my_text_button.dart';
import 'package:yoripe/components/my_text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final emailController = TextEditingController();

  bool showErrorMsg = false;
  bool showResetMsg = false;
  String errorMsg = "";

  void _showResetMsg() {
    setState(() {
      this.showResetMsg = true;
    });
  }

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

  void _resetPassword() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      Navigator.pop(context);
      _showResetMsg();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Navigator.pop(context);
      _showErrorMsg();
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
              Text('Reset your password',
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
                    Visibility(
                      visible: showResetMsg,
                      child: Text(
                        'Reset link sent to your email!',
                        style: TextStyle(
                          color: Colors.grey.shade500,
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
                onTap: _resetPassword,
                text: "Reset",
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
