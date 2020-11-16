import 'package:flutter/material.dart';
import 'package:login_app/screens/signup_creen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'models/authentication.dart';


void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider.value(value: Authentication())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login App',
        theme: ThemeData (
          primaryColor: Colors.red,
        ),
        home: LoginScreen(),
        routes:{
          SignupScreen.routeName: (ctx) => SignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}