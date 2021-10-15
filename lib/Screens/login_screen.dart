import 'package:amit_project/Screens/custom_widget.dart';
import 'package:amit_project/Screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottm_navigtion_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  IconData icon = Icons.visibility_off_sharp;
  bool x = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   height: size.height*.29,
              //   width: size.width*.7,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/FirstScreen/amit.png')
              //     )
              //
              //   ),
              // ),
              SizedBox(
                height: size.height * .1,
              ),
              const Image(
                image: AssetImage("assets/FirstScreen/amit.png"),
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: size.height * .06,
              ),

              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your email';
                          }
                          return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .035,
                      ),
                      TextFormField(
                        obscureText: obscureText,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: obscureText
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.visibility_off_sharp)),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .055,
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            x = true;
                          });

                          try {
                            if (_formKey.currentState!.validate()) {
                              var result = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                              if (result.user != null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigtionScreen(),
                                    ),
                                    (route) => false);
                              }
                            }
                          } catch (e) {
                            alertDialogFunc(
                                context: context, error: e.toString());
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height * .05,
                          width: size.width * .45,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * .05),
                            color: Colors.red[700],
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .001,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            'Go SignUp',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
