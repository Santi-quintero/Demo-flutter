import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// IMPORT PACKAGE
import 'package:signature/signature.dart';

import '../widgets/web.dart';
import '../widgets/widgets.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String assetPDFPath = "";
  Uint8List? _signatureBytes;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Library Pdf'),
        ),
        drawer: const SideMenu(),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Signature(
              controller: _controller,
              width: 300,
              height: 300,
              backgroundColor: Colors.lightBlueAccent,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                final signatureImage = await _controller.toPngBytes();
                setState(() {
                  _signatureBytes = signatureImage;
                });

                if (_signatureBytes != null) {
                  final resp =
                      await PdfApi.generatePdfDowloandWeb(_signatureBytes);
                  saveAndLaunchFile(resp!, 'filePdf.pdf');
                }
                _controller.clear();
              },
              child: const Text("Dowloand file demo web"),
            ),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)),
            onPressed: onSubmit,
            child: const Text(
              'Signature android',
              style: TextStyle(fontSize: 20),
            )),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child: const Text("Clear"),
            onPressed: () => _controller.clear()));
  }

  Future onSubmit() async {
    final signatureImage = await _controller.toPngBytes();
    setState(() {
      _signatureBytes = signatureImage;
    });

    if (_signatureBytes != null) {
      final resp = await PdfApi.generatePdf(_signatureBytes);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PDFView(
                    filePath: resp.path,
                  )));
    }
    _controller.clear();
  }
}

class PdfApi {
  static generatePdf(Uint8List? bytes) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        })); // Pa
    final profileImage = pw.MemoryImage(bytes!);

    // pdf.editPage(0, pw.Page(build: (pw.Context context) {
    //    context.canvas.drawImage();
    // }));
    pdf.editPage(0, pw.Page(build: (pw.Context context) {
      return pw.Container(
        child: pw.Image(profileImage,
            height: 150, width: 200, alignment: pw.Alignment.bottomRight),
      ); // Center
    })); // Page

    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/example.pdf");
    return await file.writeAsBytes(await pdf.save());
  }

  // static existPdf(Uint8List? bytes) async {
  //   final data = await rootBundle.load('assets/SignedPdf.pdf');
  //   final bytes = data.buffer.asUint8List();

  //   final pdf = pw.Document.load(
  //     PdfDocumentParserBase(bytes),
  //   );
  // }

  static generatePdfDowloandWeb(Uint8List? bytes) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        })); // Pa
    final profileImage = pw.MemoryImage(bytes!);

    // pdf.editPage(0, pw.Page(build: (pw.Context context) {
    //    context.canvas.drawImage();
    // }));
    pdf.editPage(0, pw.Page(build: (pw.Context context) {
      return pw.Container(
        child: pw.Image(profileImage,
            height: 150, width: 200, alignment: pw.Alignment.bottomRight),
      ); // Center
    })); // Page

    List<int> bytesPdf = await pdf.save();

    return bytesPdf;
  }
}
