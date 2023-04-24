import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../widgets/web.dart';
import '../widgets/widgets.dart';

class SignaturePdf extends StatefulWidget {
  const SignaturePdf({super.key});

  @override
  State<SignaturePdf> createState() => _SignaturePdfState();
}

class _SignaturePdfState extends State<SignaturePdf> {
  String assetPDFPath = "";
  @override
  void initState() {
    super.initState();
  }

  final keySignaturePad = GlobalKey<SfSignaturePadState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature'),
      ),
      drawer: const SideMenu(),
      body: Column(
        children: [
          SfSignaturePad(
            key: keySignaturePad,
            backgroundColor: Colors.yellow.withOpacity(0.2),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text("Abrir desde la carpeta"),
            onPressed: () {
              if (assetPDFPath != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFView(
                              filePath: assetPDFPath,
                            )));
              }
            },
          )
        ],
      ),
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50)),
          onPressed: onSubmit,
          child: const Text(
            'Signature',
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  Future onSubmit() async {
    final image = await keySignaturePad.currentState?.toImage();
    final imageSignature = await image!.toByteData(format: ImageByteFormat.png);

    // final file = await PdfApi.generatePdf(imageSignature: imageSignature);

    await PdfApi.fromAsset(
            "assets/SignedPdf.pdf", "SignedPdf.pdf", imageSignature)
        .then((f) {
      setState(() {
        assetPDFPath = f.path;
      });
    });

    // // ignore: use_build_context_synchronously
    // Navigator.of(context).pop();

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PDFView(
                  filePath: assetPDFPath,
                )));

    keySignaturePad.currentState?.clear();
  }
}

class PdfApi {
  static Future<File> generatePdf({required ByteData? imageSignature}) async {
    final document = PdfDocument();
    final page = document.pages.add();

    drawSignature(page, imageSignature);

    return saveFile(document);
  }

  static void drawSignature(PdfPage page, ByteData? imageSignature) {
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(imageSignature!.buffer.asUint8List());

    page.graphics.drawImage(image,
        Rect.fromLTWH(pageSize.width - 200, pageSize.height - 200, 100, 100));
  }

  static Future<File> saveFile(PdfDocument document) async {
    // final path = await getApplicationDocumentsDirectory();
    // final fileName = '${path.path}/${DateTime.now().toIso8601String()}.pdf';

    final directory = await getExternalStorageDirectory();
    final fileName = "${directory?.path}/example.pdf";

    final file = File(fileName);
    List<int> bytes = await document.save();
    File assetFile = await file.writeAsBytes(bytes);
    document.dispose();

    return assetFile;
  }

  static Future<File> fromAsset(
      String asset, String filename, ByteData? imageSignature) async {
    Completer<File> completer = Completer();
    try {
      var data = await rootBundle.load(asset);
      var bytesImg = data.buffer.asUint8List();

      PdfDocument document = PdfDocument(inputBytes: bytesImg);
      PdfPage page = document.pages[0];

      final Size pageSize = page.getClientSize();
      final PdfBitmap image = PdfBitmap(imageSignature!.buffer.asUint8List());
      page.graphics.drawImage(image,
          Rect.fromLTWH(pageSize.width - 200, pageSize.height - 200, 100, 80));

      List<int> bytes = await document.save();

      document.dispose();

      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      // await saveAndLaunchFile(bytes, filename);

      await file.writeAsBytes(bytes, flush: true);

      completer.complete(file);
    } catch (e) {
      throw Exception("Error parsing asset pdf file!");
    }

    return completer.future;
  }
}
