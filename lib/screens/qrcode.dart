import 'package:anylearn/dto/user_dto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class QrCodeScreen extends StatelessWidget {
  final UserDTO user = new UserDTO(
    name: "MC Hoài Trinh",
    refcode: "1900113",
    walletC: 100,
    walletM: 123400,
    image:
        "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
  );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double qrWidth = width * 2 / 3;
    double textPadding = (width - qrWidth) / 2;
    double qrPadding = (height - qrWidth) / 3;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: qrPadding, bottom: 10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            QrImage(
              data: user.refcode,
              version: QrVersions.auto,
              size: qrWidth,
              gapless: true,
              embeddedImage: AssetImage('assets/images/logo_app.png'),
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
              ),
            ),
            Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              MaterialButton(
              color: Colors.green,
              onPressed: () => _scan(context),
              child: Text("QUÉT QR", style: TextStyle(
                fontSize: 18.0,
                color: Colors.white
              ),),
            ),
            MaterialButton(
              onPressed: () {
                Share.share("Tham gia học cùng tôi trên anyLEARN https://anylearn.vn/ref/" + user.refcode);
              },
              child: Text("CHIA SẺ MÃ", style: TextStyle(
                fontSize: 16.0,
                color: Colors.blue
              ),),
            ),
            ],)
          ),
        ),
           ],),),
    );
  }

  Future _scan(context) async {
    var result = await BarcodeScanner.scan(
        options: ScanOptions(
      restrictFormat: [
        BarcodeFormat.qr,
      ],
      android: AndroidOptions(
        useAutoFocus: true,
      )
    ));
    print(result.rawContent); 
  }
}
