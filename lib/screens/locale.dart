import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: Column(
            children: [
              TextButton.icon(
                icon: Image.asset(
                  "assets/icons/vi.png",
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  context.locale = Locale('vi');
                  Navigator.pop(context);
                },
                label: Text('VietNam'),
              ),
              TextButton.icon(
                icon: Image.asset(
                  "assets/icons/en.png",
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  context.locale = Locale('en');
                  Navigator.pop(context);
                },
                label: Text('English'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
