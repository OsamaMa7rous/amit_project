import 'package:amit_project/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<Widget> alertDialogFunc(
    {required BuildContext context, required String error}) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("message"),
          content: Text(error),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
              textColor: Colors.white,
              color: Colors.red[600],
              child: const Text("Ok"),
            )
          ],
        );
      }).catchError((error) {
    throw error;
  });
}

Future<Widget> alertLogOutFunc(
    {required BuildContext context, required Size size}) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("SignOut"),
          content: Text(
            "Are You Sure You Want To SignOut?",
            style: TextStyle(color: Colors.grey, fontSize: size.height * .03),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
              textColor: Colors.white,
              color: Colors.red[600],
              child: const Text("No"),
            ),
            SizedBox(),
            MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              textColor: Colors.white,
              color: Colors.red[600],
              child: const Text("Yes"),
            ),
          ],
        );
      }).catchError((error) {
    throw error;
  });
}
