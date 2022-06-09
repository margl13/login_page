import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/reusable_widgets/reusable_widgets.dart';
import 'package:login_page/screens/home_screen.dart';
import 'package:login_page/screens/signUp_screen.dart';
import 'package:login_page/utils/color.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringColor("CB2893"),
              hexStringColor("9546C4"),
              hexStringColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                    child: Column(
                      children: <Widget>[
                        logoWidget("assets/images/img_45427.png"),
                        const SizedBox(
                          height: 30,
                        ),
                        reusableTextFields("Enter UserName",
                            Icons.person_outline, false, _emailTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFields("Enter Password", Icons.lock_outline,
                            true, _passwordTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        signInSignUpButton(context, true, () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                        }),
                        signUpOption()
                      ],
                    )))));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
