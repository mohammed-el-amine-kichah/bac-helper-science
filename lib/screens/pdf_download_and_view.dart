import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfDownloadViewer extends StatefulWidget {
  final String exam;
  final String module;

  const PdfDownloadViewer({super.key, required this.module, required this.exam});

  @override
  _PdfDownloadViewerState createState() => _PdfDownloadViewerState();
}

class _PdfDownloadViewerState extends State<PdfDownloadViewer> {
  String? pdfPath;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    setState(() {
      isLoading = true;
    });

    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/bac_${widget.exam}.pdf');

      if (await file.exists()) {
        setState(() {
          pdfPath = file.path;
          isLoading = false;
        });
      } else {
        await downloadAndSavePdf(file);
      }
    } catch (e) {
      print('Error loading PDF: $e');
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Error loading PDF: $e');
    }
  }

  Future<void> downloadAndSavePdf(File file) async {
    try {
      final ref = FirebaseStorage.instance.ref('2024/bac${widget.exam}.pdf');
      final bytes = await ref.getData();

      await file.writeAsBytes(bytes!);

      setState(() {
        pdfPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      print('Error downloading PDF: $e');
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Error downloading PDF: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.module),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pdfPath != null
          ? SfPdfViewer.file(
        File(pdfPath!),
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          print('Error loading PDF: ${details.error}');
          _showErrorSnackBar('Error loading PDF: ${details.error}');
        },
      )
          : const Center(child: Text('نعتذر الملف غير متوفر')),
    );
  }
}