import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

enum PDFWidget {
  CGU,
  PRIVACY_POLICY
}

class GCUPrivacyPolicy extends StatelessWidget {
  final PDFWidget pdf;

  const GCUPrivacyPolicy({Key key, this.pdf}) : super(key: key);

  Future<String> _preparePdf(String documentPath) async {
    final ByteData bytes =
    await rootBundle.load(documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _preparePdf(
        pdf == PDFWidget.CGU ? "pdf/cgu.pdf" : "pdf/privacy-policy.pdf"
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: _appbar,
            body: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        return PDFViewerScaffold(
          path: snapshot.data,
          appBar: _appbar,
        );
      }
    );
  }

  AppBar get _appbar => AppBar(
    elevation: 0,
    title: Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(pdf == PDFWidget.CGU ? "CGU" : "Politique de confidentialité"),
    ),
    centerTitle: true,
    bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1)
    ),
  );
}
