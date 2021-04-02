import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  WebViewExample({this.url,this.appBarText});
  final String url;
  final String appBarText;
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.appBarText),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: WebView(
        initialUrl: widget.url, //the link
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
