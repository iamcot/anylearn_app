import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocaleIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocaleIcon();
}

class _LocaleIcon extends State<LocaleIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5.0),
      child: InkWell(
        child: _flagFromLocale(context.locale.toString()),
        onTap: () {},
      ),
    );
  }

  Widget _flagFromLocale(String locale) {
    try {
      return CircleAvatar(
        radius: 12,
        child: ClipRRect(
          child: Image.asset(
            "assets/icons/" + locale + ".png",
            fit: BoxFit.cover,
            height: 24,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
      );
    } catch (e) {
      return Text(locale);
    }
  }
}
