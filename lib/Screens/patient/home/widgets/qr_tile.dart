import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/shared/snack_bar_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../controller/authentication_ctr.dart';

final _authCtr = Get.put(AuthCtr());

class QRTile extends StatelessWidget {
  const QRTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (_) {
            return const QRCodeSheet();
          },
        );
      },
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            const Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Icon(
                Icons.qr_code,
                size: 38,
              ),
            ),
            const VerticalDivider(
              indent: 25,
              endIndent: 25,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Show QR Code"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QRCodeSheet extends StatelessWidget {
  const QRCodeSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Scan this QR code to get patient data",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          QrImage(
            data: _authCtr.userData!.id,
            size: 200,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: GestureDetector(
              onTap: () async {
                await FlutterClipboard.copy(
                  _authCtr.userData!.id,
                ).then(
                  (value) {
                    Navigator.pop(context);
                    showSnackBar(
                      "ID copied to clipboard",
                      context,
                    );
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.copy),
                  const SizedBox(width: 7),
                  Text(_authCtr.userData!.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
