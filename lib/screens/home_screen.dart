import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/serviceItem.dart';
import '../widget/stories.dart';

import '../provider/auth.dart';
import '../model/service.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  final List<Service> _serviceList = [
    Service('assets/images/plane.png', 'Plane', Colors.lightGreen),
    Service('assets/images/train.png', 'Train', Colors.purple),
    Service('assets/images/bus.png', 'Bus', Colors.deepOrange),
    Service('assets/images/ship.png', 'Ship', Colors.cyan),
    Service('assets/images/plane.png', 'Plane', Colors.lightGreen),
    Service('assets/images/train.png', 'Train', Colors.purple),
    Service('assets/images/bus.png', 'Bus', Colors.deepOrange),
    Service('assets/images/ship.png', 'Ship', Colors.cyan),
  ];

  final List<String> _stories = [
    'https://cdn.pixabay.com/photo/2017/08/08/13/12/belfry-2611371__340.jpg',
    'https://cdn.pixabay.com/photo/2020/05/25/15/54/windmill-5219199__340.jpg',
    'https://cdn.pixabay.com/photo/2014/01/07/20/18/hawaii-240161__340.jpg',
    'https://cdn.pixabay.com/photo/2016/06/21/22/09/paris-1472087__340.jpg',
  ];

  final String userName;
  HomeScreen(this.userName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      backgroundColor: Color.fromRGBO(227, 235, 238, 1),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(227, 235, 238, 1),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Image.asset('assets/images/menu.png'),
          iconSize: 18.0,
          onPressed: () {},
        ),
      ),
      actions: <Widget>[
        IconButton(
            icon: Image.asset('assets/images/user.png'),
            onPressed: () {
              // Navigator.of(context).pushNamed(UserLoginScreen.routeName),
            }),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey $userName!',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Where would you like to go?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Let\'s go to...',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Book Tickets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _serviceList
                  .map((e) => ServiceItem(e.imageUrl, e.serviceName, e.bgColor))
                  .toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            width: double.infinity,
            child: Text(
              'See Travel Stories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: kDefaultPaddin / 2),
            height: 300,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: _stories.map((e) => Stories(e)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
