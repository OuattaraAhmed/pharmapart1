import 'package:flutter/material.dart';
import 'package:pharma/screens/login/login_screen.dart';
import 'package:pharma/widgets/auth_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  static String theUSer;
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String _userName;
  Future<int> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Username', null);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<String> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('Username');
    ProfilScreen.theUSer = '$_userName';
  }

  @override
  void initState() {
    _getUserName();
    print(ProfilScreen.theUSer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('Deconnexion'),
                    onPressed: () {
                      _logout();
                    },
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
