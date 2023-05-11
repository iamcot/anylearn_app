import '../main.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QrCodeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrCodeScreen();
}

class _QrCodeScreen extends State<QrCodeScreen> {
  // late AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final qrWidth = width * 2 / 3;
    final textPadding = (width - qrWidth) / 2;
    final qrPadding = (height - qrWidth) / 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: qrPadding, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: user.refLink,
              version: QrVersions.auto,
              size: qrWidth,
              gapless: true,
              embeddedImage: AssetImage('assets/images/logo_app.jpg'),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(40, 40),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: textPadding, right: textPadding),
              child: Text(
                "Bạn bè có thể kết nối với bạn khi quét mã QR này. Thêm bạn học thêm vui.",
                textAlign: TextAlign.center,
              ).tr(),
            ),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // MaterialButton(
                      //   color: Colors.green,
                      //   onPressed: () => _scan(context),
                      //   child: Text(
                      //     "QUÉT QR",
                      //     style: TextStyle(fontSize: 18.0, color: Colors.white),
                      //   ),
                      // ),
                      MaterialButton(
                        onPressed: () {
                          Share.share(user!.refLink);
                        },
                        child: Text(
                          "CHIA SẺ MÃ",
                          style: TextStyle(fontSize: 16.0, color: Colors.blue),
                        ).tr(),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // Future _scan(context) async {
  //   var result = await BarcodeScanner.scan(
  //       options: ScanOptions(
  //           restrictFormat: [
  //         BarcodeFormat.qr,
  //       ],
  //           android: AndroidOptions(
  //             useAutoFocus: true,
  //           )));
  // }
}
