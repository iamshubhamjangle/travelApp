import 'package:flutter/material.dart';
import 'package:travel_design_app/constants.dart';

class Stories extends StatelessWidget {
  final String url;

  Stories(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: kDefaultPaddin - 5),
      child: SizedBox(
        width: 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    //);
  }
}
