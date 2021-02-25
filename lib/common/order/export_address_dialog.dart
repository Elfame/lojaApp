import 'package:flutter/material.dart';
import 'package:lojavirtual/models/address.dart';
import 'package:open_file/open_file.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ExportAddressDialog extends StatelessWidget {


   ExportAddressDialog(this.address);
  final Address address;

  final ScreenshotController screenshotController  = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Endereço de entrega"),
      content: Screenshot(
        controller: screenshotController ,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Text(
            '${address.street}, ${address.number} ${address.complement}\n'
                '${address.district}\n'
                '${address.city}/${address.state}\n'
                '${address.zipCode}',

          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: [
        FlatButton(
          onPressed: () async {
            Navigator.of(context).pop();
           final file = await screenshotController.capture();
           await GallerySaver.saveImage(file.path);
           await OpenFile.open(file.path);
          },
          
          child:  const Text('Exportar'),
        ),
      ],
      

    );
  }
}
