import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharma/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharma/screens/tabs_screen.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final userNameController = TextEditingController();
  final repSecreteController = TextEditingController();
  final passWordController = TextEditingController();

  String _userName = '';
  String message = '';
  String dataUser;
  int session;

  String _selectedType;
  List _accountType = ['Standard', 'Premium'];

  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;

  void _trySubmit() {
    //
    FocusScope.of(context).unfocus();

    final isValid = _formkey.currentState.validate();
  }

  @override
  void initState() {
    super.initState();
  }

  void _addUser() {
    var url = "http://bad-event.com/pharma/addUsers.php";
    http.post(url, body: {
      "userName": userNameController.text,
      "repScrete": repSecreteController.text,
      "passWord": passWordController.text,
    });
  }

  Future<String> _login() async {
    final response =
        await http.post('http://bad-event.com/pharma/loginUsers.php', body: {
      "userName": userNameController.text,
      "passWord": passWordController.text,
    });

    dataUser = response.body;
    print(dataUser);

    if (dataUser != 'false') {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TabsScreen(),
          ),
        );
        setState(() {
          _userName = dataUser;
          print(_userName);
          _getUserName();
        });
      });
    } else {
      setState(() {
        message = 'Connexion echouée';
      });
    }
    return dataUser;
  }

  // ignore: missing_return
  Future<int> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Username', _userName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                _isLogin ? 'Connexion' : 'Inscription',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              Center(
                child: Card(
                  elevation: 10,
                  color: Theme.of(context).canvasColor,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: userNameController,
                              key: ValueKey('userName'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 4) {
                                  return 'Nom trop court';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Identifiant'),
                            ),
                            if (!_isLogin)
                              TextFormField(
                                controller: repSecreteController,
                                key: ValueKey('userResMdp'),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return 'Veuillez entre au moins lettres';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Reponse sécrète'),
                              ),
                            TextFormField(
                              controller: passWordController,
                              key: ValueKey('userPassWord'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 7) {
                                  return 'Mot de passe trop court';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                              ),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // if (!_isLogin)
                            //   DropdownButton(
                            //     isExpanded: true,
                            //     items: _accountType.map((value) {
                            //       return DropdownMenuItem(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //     value: _selectedType,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         _selectedType = value;
                            //       });
                            //     },
                            //   ),
                            Text(
                              message,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child:
                                  Text(_isLogin ? 'Connexion' : 'Inscription'),
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  !_isLogin ? _addUser() : _login();
                                  setState(() {
                                    userNameController.clear();
                                    repSecreteController.clear();
                                    passWordController.clear();
                                  });
                                }
                              },
                            ),
                            FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              child: Text(_isLogin
                                  ? 'Créer un compte'
                                  : 'Déjà un compte ?'),
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_isLogin)
                FlatButton(
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}
