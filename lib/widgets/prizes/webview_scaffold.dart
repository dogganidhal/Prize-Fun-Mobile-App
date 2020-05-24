

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScaffold extends StatelessWidget {
  final String url;

  const WebviewScaffold({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
//        title: Padding(
//          padding: EdgeInsets.symmetric(vertical: 8),
//          child: Text("Règlement du concours"),
//        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
      ),
      body: WebView(
        initialUrl: url,
      )
    );
  }
}