import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final String image, name;
  final Color color;

  ServiceItem(this.image, this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(15),
          child: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset(image),
          ),
        ),
        Text(name),
      ],
    );
  }
}
