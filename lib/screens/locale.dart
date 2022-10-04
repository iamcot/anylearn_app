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
        title: Text("Chọn ngôn ngữ".tr()),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              TextButton.icon(
                icon: Icon(Icons.language),
                onPressed: () {
                  context.locale = Locale('vi');

                  print(context.supportedLocales);
                },
                label: Text('Việt Nam'),
              ),
              TextButton.icon(
                icon: Icon(Icons.language),
                onPressed: () {
                  context.locale = Locale ('en');
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
