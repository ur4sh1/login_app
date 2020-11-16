import 'package:flutter/material.dart';
import 'package:login_app/screens/signup_creen.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {

  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey <FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': ''
  };
  void _showErrorDialog (String msg){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text ('Erro ao Logar'),
        content: Text(msg),
        actions: [
          FlatButton(
            child: Text('Voltar'),
            onPressed: (){
              Navigator.of(ctx).pop();
            }
          )
        ],
      )
    );
  }

  Future <void> _submit() async{
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }catch (error){
      var errorMessage = 'Email ou Senha inválido';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text ('Login'),
        actions: <Widget>[
          FlatButton(
            child: Row (
              children: <Widget> [
                Text ('Novo Doador  '),
                Icon (Icons.person_add)
              ],
            ),
            padding: EdgeInsets.fromLTRB(0,0,25,0),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
            },
          ),
        ],
      ),
      body: Stack (
        children: <Widget> [
          Container (
            decoration: BoxDecoration (
              gradient: LinearGradient(
                begin: const Alignment(0.0, -1.0),
                end: const Alignment(0.0, 0.5),
                colors: [
                  const Color(0xFFF4F4F4),
                  const Color(0xFFEDEDED),
                ],
              ),
            ),
          ),

            Container(
              alignment: Alignment.topCenter,
              child: SizedBox (
                width:128,
                height:128,
                child: Image.asset("assets/logo.png"),
              ),
            ),

            Center (
            child: Card (
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container (
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Email Inválido';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _authData['email'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Senha'),
                          obscureText: true,
                          validator: (value){
                            if (value.isEmpty || value.length<=5){
                              return 'Senha Inválida';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;

                          }
                        ),
                        SizedBox(
                         height:30,
                        ),
                        RaisedButton(
                          child: Text('Entrar'),
                          onPressed: (){
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    ),
          ],
      ),
    );

  }
}


