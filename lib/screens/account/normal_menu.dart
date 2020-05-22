import 'package:flutter/material.dart';

class AccountNormalMenu extends StatelessWidget {
  final String title;
  final String route;
  final IconData leadingIcon;
  final Widget trailing;
  final Widget subContent;
  final VoidCallback routeFunction;
  final String routeFunctionMsg;
  final Color leadingColor;
  final Color trailingColor;
  final Color titleColor;

  const AccountNormalMenu(
      {Key key,
      this.title,
      this.route,
      this.leadingIcon,
      this.trailing,
      this.subContent,
      this.routeFunction,
      this.routeFunctionMsg,
      this.leadingColor,
      this.trailingColor,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(
          title,
          style: TextStyle(color: titleColor ?? Colors.black),
        ),
        subtitle: subContent ?? null,
        onTap: () {
          if (routeFunction != null) {
            routeFunction();
            // Scaffold.of(context).showSnackBar(new SnackBar(
            //   content: Text(routeFunctionMsg),
            //   duration: new Duration(seconds: 2),
            // ));
          } else {
            Navigator.of(context).pushNamed(route);
          }
        },
        leading: Icon(
          leadingIcon,
          color: leadingColor ?? Colors.grey[600],
          size: 32.0,
        ),
        trailing: trailing,
      ),
      Divider(height: 0.0),
    ]);
  }
}
