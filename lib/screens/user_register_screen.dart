import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './user_login_screen.dart';
import '../model/http_exception.dart';
import '../provider/auth.dart';

class UserRegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<UserRegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
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
                  child: Text('Register'),
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
                  Text('Already have a account?'),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Login instead',
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(UserLoginScreen.routeName);
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
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData['name'],
        _authData['password'],
      );
      await _showErrorDialog('Success!', 'Please log in with your credentials');
      Navigator.of(context).pop();
    } on HttpException catch (e) {
      print(e);
      var _errormessage = 'Registration failed!';
      if (e.toString().contains('SERVER_ERROR')) {
        _errormessage = 'Please enter all fields';
      }
      _showErrorDialog('Error', _errormessage);
    } catch (e) {
      print(e);
      _showErrorDialog('Error', 'Registration failed! Please try again later.');
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
