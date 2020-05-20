import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class QrCodeScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrCodeScanScreen();
}

class _QrCodeScanScreen extends State<QrCodeScanScreen> {
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            controller: this._outputController,
            readOnly: true,
            maxLines: 2,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.wrap_text),
              helperText: 'The barcode or qrcode you scan will be displayed in this area.',
              hintText: 'The barcode or qrcode you scan will be displayed in this area.',
              hintStyle: TextStyle(fontSize: 15),
              contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
            ),
          ),
          FloatingActionButton(
            onPressed: () => _scan(),
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }

  Future _scan() async {
    var result = await BarcodeScanner.scan();
    this._outputController.text = result.rawContent;
  }
}
