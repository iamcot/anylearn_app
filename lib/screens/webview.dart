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
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            debugPrint("WebView loaded");
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setUserAgent("anylearn-app")
      ..loadRequest(Uri.parse(widget.url), headers: {"token": widget.token});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
