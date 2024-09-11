import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfDownloadViewer extends StatefulWidget {
  final String exam;
  final String module;

  const PdfDownloadViewer({super.key,required this.module ,required this.exam});

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
        // If the file exists locally, use it
        setState(() {
          pdfPath = file.path;
          isLoading = false;
        });
      } else {
        // If the file doesn't exist, download it
        await downloadAndSavePdf(file);
      }
    } catch (e) {
      print('Error loading PDF: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading PDF: $e')),
      );
    }
  }

  Future<void> downloadAndSavePdf(File file) async {
    try {
      // Get the PDF file from Firebase Storage
      final ref = FirebaseStorage.instance.ref('2024/bac${widget.exam}.pdf');
      final bytes = await ref.getData();

      // Write the file
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.module}'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pdfPath != null
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: PDFView(
          filePath: pdfPath!,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: false,
        ),
      )
          : const Center(child: Text('نعتذر الملف غير متوفر')),
    );
  }
}