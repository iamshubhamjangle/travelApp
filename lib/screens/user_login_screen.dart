import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_design_app/screens/home_screen.dart';

import '../model/http_exception.dart';
import '../provider/auth.dart';

import './user_register_screen.dart';

class UserLoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<UserLoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<String, String> _authData = {
    'name': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 235, 238, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(227, 235, 238, 1),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Travel Guru',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            // FlatButton(
            //   textColor: Colors.blue,
            //   child: Text('Forgot Password'),
            //   onPressed: () {
            //     //forgot password screen
            //   },
            // ),
            SizedBox(
              height: 30,
            ),

            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed: () {
                    _authData['name'] = nameController.text;
                    print(_authData['name']);
                    _authData['password'] = passwordController.text;
                    print(_authData['password']);
                    _submit();
                  },
                )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Does not have account?'),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Register',
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(UserRegisterScreen.routeName);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    try {
      await Provider.of<Auth>(context, listen: false).signIn(
        _authData['name'],
        _authData['password'],
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on HttpException catch (e) {
      print(e);
      var _errormessage = 'Login failed! Please try again later';
      if (e.toString().contains('USER_NOT_FOUND')) {
        _errormessage = 'This account is not registered';
      }
      if (e.toString().contains('WRONG_PASSWORD')) {
        _errormessage = 'Incorrect password';
      }
      await _showErrorDialog('Error', _errormessage);
    } catch (e) {
      print(e);
      await _showErrorDialog('Error', 'Login failed! Please try again later.');
    }
  }

  Future<void> _showErrorDialog(String title, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
