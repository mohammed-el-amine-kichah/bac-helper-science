import 'package:flutter/material.dart';
import '../services/check_connection.dart';

abstract class DownloadDialog extends StatelessWidget {
  const DownloadDialog({Key? key}) : super(key: key);

  void Function()? get retry;
  void Function()? get download;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: CheckConnection().isConnected(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data == true) {
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('هل تريد تحميل الملف ؟',
                      style: TextStyle(
                          fontSize: 22,
                          decoration: TextDecoration.none,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.end),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: download,
                        child: const Text('تحميل'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('الغاء'),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('لا يوجد اتصال بالانترنت',
                      style: TextStyle(
                          fontSize: 22,
                          decoration: TextDecoration.none,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.end),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: retry, child: const Text('أعد المحاولة'),
                    style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('الغاء'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class MyDownloadDialog extends DownloadDialog {
  const MyDownloadDialog({Key? key}) : super(key: key);

  @override
  void Function()? get retry => _handleRetry;

  @override
  void Function()? get download => _handleDownload;

  void _handleRetry() {
    // Implement your retry logic here
    print('Retrying...');
  }

  void _handleDownload() {
    // Implement your download logic here
    print('Downloading...');
  }
}
