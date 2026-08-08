import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScannerScreen extends StatefulWidget {
  final bool isQrCode;

  const ScannerScreen({super.key, required this.isQrCode});



  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  QRViewController? qrController;
  String qrResult = "Scanned data will appear here";

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: widget.isQrCode
                  ? const EdgeInsets.all(32.0)
                  : const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
              child: Stack(children: [
                QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
                 Center(
                  child: widget.isQrCode ? Image.asset(
                    "assets/images/scanlogo.png",
                    width: 300,
                    color: Colors.white,
                  ) : null,
                )
              ]),
            )),
            SizedBox(
              height: size.height * 0.09,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  height: size.height * 0.1,
                  child: Text(
                    qrResult,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                    maxLines: 5,
                  )),
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.5,
              child: ElevatedButton(
                onPressed: () async {
                  Clipboard.setData(ClipboardData(text: qrResult));
                },
                child: Text(
                  'Copy',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            // SizedBox(
            //   height: size.height * 0.06,
            //   width: size.width * 0.5,
            //   child: widget.isQrCode
            //       ? ElevatedButton(
            //     onPressed: () async {
            //       final Uri url = Uri.parse(qrResult);
            //      // await launchUrl(url);
            //     },
            //     child: Text(
            //       'Open',
            //       style: TextStyle(
            //         fontSize: 16,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         letterSpacing: 0.5,
            //       ),
            //     ),
            //   )
            //       : null,
            // ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
