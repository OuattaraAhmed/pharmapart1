import 'package:flutter/material.dart';
import 'package:pharma/widgets/auth_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              height: 100,
              child: Image.asset('assets/images/panel.png'),
            ),
            AuthForm(),
          ],
        ),
      ),
    );
  }
}
