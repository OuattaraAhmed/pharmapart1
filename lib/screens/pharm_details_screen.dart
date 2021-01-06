import 'package:flutter/material.dart';
import 'package:pharma/screens/map_screen.dart';

class PharmDetailsScreen extends StatelessWidget {
  static const routeName = '/pharm-details';
  @override
  Widget build(BuildContext context) {
    final pharmArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final pharmId = pharmArgs['id'];
    final pharmName = pharmArgs['nom'];
    final pharmResp = pharmArgs['responsable'];
    final pharmTel = pharmArgs['tel'];
    final pharmLat = pharmArgs['lati'];
    final pharmLong = pharmArgs['longi'];
    return Scaffold(
      appBar: AppBar(
        title: Text(pharmName),
        actions: [
          IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                print(pharmLat);
                Navigator.pushNamed(
                  context,
                  MapScreen.nameRoute,
                  arguments: {
                    'lati': pharmLat,
                    'longi': pharmLong,
                  },
                );
              }),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                ),
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                pharmName,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Informations Pharmacie',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 11, 11),
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              pharmTel,
                              style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                    ),
                    Text(
                      'Responsable',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        pharmResp,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
