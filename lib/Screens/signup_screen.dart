import 'package:amit_project/Screens/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  IconData icon = Icons.visibility_off_sharp;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.width * .05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              const Image(
                image: AssetImage("assets/FirstScreen/amit.png"),
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: size.height * .00,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your name';
                          }
                          return null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .035,
                      ),
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
                          try {
                            if (_formKey.currentState!.validate()) {
                              var result = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                              if (result.user != null) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(result.user!.uid)
                                    .set({
                                  'name': nameController.text,
                                  'email': result.user!.email.toString(),
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
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
                          width: size.height * .32,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * .06),
                            color: Colors.red[700],
                          ),
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * .06),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      MaterialButton(
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: Column(
                          children: [
                            const Text("Have an Account?"),
                            SizedBox(
                              height: size.height * .001,
                            ),
                            const Text(
                              "Go Login",
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
