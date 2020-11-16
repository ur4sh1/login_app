import 'package:flutter/material.dart';
import 'package:login_app/screens/home_screen.dart';
import '../models/authentication.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {

  static const routeName = '/cadastrar';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey <FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  Map<String,String> _authData ={
    'emal': '',
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
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }catch(error){
      var errorMessage = 'Erro ao cadastrar';
      _showErrorDialog(errorMessage);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text ('Cadastrar Novo Doador'),
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
      body: Stack (
        children: <Widget> [
          Container (
            decoration: BoxDecoration (
              gradient: LinearGradient(
                colors: [
                  Colors.white10,
                  Colors.white,
                ],
              ),
            ),
          ),
          Center(
            child: Card (
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container (
                height: 400,
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
                            controller: _passwordController,
                            validator: (value){
                              if (value.isEmpty || value.length<=4){
                                return 'Senha Inválida';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            }
                        ),

                        TextFormField(
                            decoration: InputDecoration(labelText: 'Confirme a senha'),
                            obscureText: true,
                            validator: (value){
                              if (value.isEmpty || value != _passwordController.text){
                                return 'Senha Inválida';
                              }
                              return null;
                            },
                            onSaved: (value) {

                            }
                        ),


                        SizedBox(
                          height:30,
                        ),
                        RaisedButton(
                          child: Text('Cadastrar'),
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
