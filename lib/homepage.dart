import 'dart:async';
import 'package:flutter/material.dart';
import 'google_sheets_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // collect user input

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      "goat",
      "kya baat hai",
      true,
    );
    setState(() {});
  }

  // new transaction

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Attendance",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Stack(alignment: Alignment.center, children: [
            // Expanded(
            //   flex: 5,
            //   child: QRView(
            //     key: qrKey,
            //     onQRViewCreated: _onQRViewCreated,
            //     overlay: QrScannerOverlayShape(
            //         borderWidth: 10,
            //         borderLength: 20,
            //         borderRadius: 10,
            //         cutOutSize: MediaQuery.of(context).size.width * 0.8),
            //   ),
            // ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    _enterTransaction();
                  },
                  child: Text("jak")),
            )
          ])),
    );
  }
}
