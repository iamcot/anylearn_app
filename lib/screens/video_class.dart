import 'package:flutter/material.dart';

class VideoClassScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoClassScreen();
}

class _VideoClassScreen extends State<VideoClassScreen> {
  int classId = 0;
  @override
  void didChangeDependencies() {
    classId = int.parse((ModalRoute.of(context)?.settings.arguments.toString())!);
    if (classId == 0) {
      Navigator.of(context).pop();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
