import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LocaleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocaleScreen();
  final locale = Locale("vi", "en");
}

class _LocaleScreen extends State<LocaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn ngôn ngữ").tr(),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: _flagFromLocale("vi"),
                title: Text("Tiếng Việt"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  context.setLocale(Locale('vi'));
                  _setSavedLocale("vi");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: _flagFromLocale("en"),
                title: Text("English"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  context.setLocale(Locale('en'));
                  _setSavedLocale("en");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
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

  Future<bool> _setSavedLocale(String localeStr) async {
    setState(() {
      locale = localeStr;
    });
    return true;
  }
}
