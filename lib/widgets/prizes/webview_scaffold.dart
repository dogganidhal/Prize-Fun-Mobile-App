import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewScaffold extends StatefulWidget {
  final String url;

  const WebviewScaffold({Key key, this.url}) : super(key: key);

  @override
  _WebviewScaffoldState createState() => _WebviewScaffoldState();
}

class _WebviewScaffoldState extends State<WebviewScaffold> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (await _webViewController.canGoBack()) {
            await _webViewController.goBack();
          } else {
            return true;
          }
          return false;
        },
        child: WebView(
          onWebViewCreated: (controller) => _webViewController = controller,
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      )
    );
  }
}
