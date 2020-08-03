import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const directoryName = 'Signature';

class DrawScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawScreen();
}

class _DrawScreen extends State<DrawScreen> {
  GlobalKey<SignatureState> signatureKey = GlobalKey();
  var image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Signature(key: signatureKey),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Ký lại', style: TextStyle(color: Colors.red)),
          onPressed: () {
            signatureKey.currentState.clearPoints();
          },
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text('Lưu chữ ký'),
          onPressed: () async {
            // setRenderedImage(context);
            ui.Image renderedImage = await signatureKey.currentState.rendered;
            setState(() {
              image = renderedImage;
            });
            File file = await getImage(context);
            Navigator.of(context).pop(file);
          },
        )
      ],
    );
  }

  setRenderedImage(BuildContext context) async {
    ui.Image renderedImage = await signatureKey.currentState.rendered;

    setState(() {
      image = renderedImage;
    });

    // showImage(context);
  }

  Future<File> getImage(BuildContext context) async {
    var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    await Directory('$path/$directoryName').create(recursive: true);
    final file = File('$path/$directoryName/${formattedDate()}.png')..writeAsBytesSync(pngBytes.buffer.asInt8List());
    return file;
  }

  String formattedDate() {
    // DateTime dateTime = DateTime.now();
    // String dateTimeString = 'Signature'
    return '_my_Signature';
  }
}

class Signature extends StatefulWidget {
  Signature({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignatureState();
  }
}

class SignatureState extends State<Signature> {
  // [SignatureState] responsible for receives drag/touch events by draw/user
  // @_points stores the path drawn which is passed to
  // [SignaturePainter]#contructor to draw canvas
  List<Offset> _points = <Offset>[];

  Future<ui.Image> get rendered {
    // [CustomPainter] has its own @canvas to pass our
    // [ui.PictureRecorder] object must be passed to [Canvas]#contructor
    // to capture the Image. This way we can pass @recorder to [Canvas]#contructor
    // using @painter[SignaturePainter] we can call [SignaturePainter]#paint
    // with the our newly created @canvas
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(points: _points);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder.endRecording().toImage(size.width.floor(), size.height.floor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox _object = context.findRenderObject();
              Offset _locationPoints = _object.localToGlobal(details.globalPosition);
              final _newLocationPoint = Offset(_locationPoints.dx, _locationPoints.dy - 155);
              _points = new List.from(_points)..add(_newLocationPoint);
            });
          },
          onPanEnd: (DragEndDetails details) {
            setState(() {
              _points.add(null);
            });
          },
          child: CustomPaint(
            painter: SignaturePainter(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }

  // clearPoints method used to reset the canvas
  // method can be called using
  //   key.currentState.clearPoints();
  void clearPoints() {
    setState(() {
      _points.clear();
    });
  }
}

class SignaturePainter extends CustomPainter {
  // [SignaturePainter] receives points through constructor
  // @points holds the drawn path in the form (x,y) offset;
  // This class responsible for drawing only
  // It won't receive any drag/touch events by draw/user.
  List<Offset> points = <Offset>[];

  SignaturePainter({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
