import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

import './provider/auth.dart';
import './screens/home_screen.dart';
import './screens/user_login_screen.dart';
import './screens/user_register_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            accentColor: Colors.blue,
          ),
          home: UserLoginScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(auth.userName),
            // UserLoginScreen.routeName: (ctx) => UserLoginScreen(),
            UserRegisterScreen.routeName: (ctx) => UserRegisterScreen(),
          },
        ),
      ),
    );
  }
}
