import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Tela Inicial'),
        actions: <Widget>[
          FlatButton(
            child: Row (
              children: <Widget> [
                Text ('Login  '),
                Icon (Icons.person)
              ],
            ),
            padding: EdgeInsets.fromLTRB(0,0,25,0),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
      body: Center (
        child: Text(
          'Bem vindo doador', style: TextStyle (
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        ),
      ),
    );
  }
}
