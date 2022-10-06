import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  final String token;

  const WebviewScreen({required this.url, this.token = ""});

  @override
  State<StatefulWidget> createState() => _WebviewScreen();
}

class _WebviewScreen extends State<WebviewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        key: UniqueKey(),
        initialUrl: widget.url,
        userAgent: "anylearn-app",
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          Map<String, String> headers = {"token": widget.token};
          webViewController.loadUrl(widget.url, headers: headers);
        },
        onPageStarted: (String progress) {
          print("WebView is loading (progress : $progress%)");
        },
        onPageFinished: (url) {
          print("WebView loaded");
        },
      ),
    );
  }
}
