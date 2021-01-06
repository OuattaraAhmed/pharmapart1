import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pharma/screens/pharm_screen.dart';

class VilleScreen extends StatelessWidget {
  static const routeName = '/ville-screen';

  Future<List> getData() async {
    final res = await http.get("http://bad-event.com/pharma/getVille.php");
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.hasError) {
            print("Erreur");
          }
          if (ss.hasData) {
            return Items(list: ss.data);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;

  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  fillColor: Colors.indigo,
                  labelText: 'Rechercher'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 400,
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                    child: Container(
                  child: ListTile(
                    title: Text(list[i]['nom']),
                    trailing: Container(
                      height: 30,
                      width: 85,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Consulter',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PharmScreen.routeName,
                        arguments: {
                          'id': list[i]['id'],
                          'nom': list[i]['nom'],
                        },
                      );
                    },
                  ),
                ));
              },
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
