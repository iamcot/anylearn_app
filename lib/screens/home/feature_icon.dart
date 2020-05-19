import 'package:flutter/material.dart';

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final double iconSize;

  const FeatureIcon({Key key, this.icon, this.title, this.route, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: iconSize ?? 24.0,
            color: Colors.black87,
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 10.0, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}
