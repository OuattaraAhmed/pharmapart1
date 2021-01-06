import 'package:flutter/material.dart';
import 'package:pharma/widgets/grid_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Bienvenu,',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Expanded(
            child: GridScreen(),
          )
        ],
      ),
    );
  }
}
