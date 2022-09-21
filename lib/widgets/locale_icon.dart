import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocaleIcon();
}

class _LocaleIcon extends State<LocaleIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: TextButton(
        child: Text(context.locale.toString()),
        onPressed: () {},
      ),
    );
  }
}
