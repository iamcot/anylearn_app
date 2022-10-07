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
              TextButton.icon(
                icon: _flagFromLocale("vi"),
                onPressed: () {
                  context.setLocale(Locale('vi'));
                  _setSavedLocale("vi");
                  Navigator.pop(context);
                },
                label: Text(
                  'Tiếng Việt',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton.icon(
                icon: _flagFromLocale("en"),
                onPressed: () {
                  context.setLocale(Locale('en'));
                  _setSavedLocale("en");
                  Navigator.pop(context);
                },
                label: Text(
                  'English',
                  style: TextStyle(fontSize: 20),
                ),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rs = prefs.setString('locale', localeStr);
    locale = localeStr;
    return rs;
  }
}
