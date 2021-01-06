import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharma/screens/pharm_details_screen.dart';

class PharmScreen extends StatelessWidget {
  static const routeName = '/pharm-screen';
  @override
  Widget build(BuildContext context) {
    final villeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final villeId = villeArgs['id'];
    final villeName = villeArgs['nom'];

    Future<List> getPharm() async {
      final res = await http
          .get("http://bad-event.com/pharma/getPharm.php?id=$villeId");
      return json.decode(res.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(villeName),
      ),
      body: FutureBuilder<List>(
        future: getPharm(),
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
            height: 600,
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                    child: Container(
                  child: ListTile(
                    title: Text(list[i]['nom']),
                    subtitle: Text(list[i]['tel']),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PharmDetailsScreen.routeName,
                        arguments: {
                          'id': list[i]['id'],
                          'nom': list[i]['nom'],
                          'responsable': list[i]['responsable'],
                          'tel': list[i]['tel'],
                          'lati': list[i]['lati'],
                          'longi': list[i]['longi'],
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
