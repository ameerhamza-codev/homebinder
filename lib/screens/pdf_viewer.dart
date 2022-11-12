import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewClass extends StatefulWidget {
 String name,url;

 PdfViewClass(this.name,this.url);

  @override
  _PdfViewClassState createState() => _PdfViewClassState();
}

class _PdfViewClassState extends State<PdfViewClass> {


  bool isDownloading=false;
  String percentage='';

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
      setState(() {
        percentage=(received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }
  Future download(String savePath) async {
    try {
      Response response = await Dio().get(
        widget.url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('pdf ${widget.url}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.name),
        actions: [
          isDownloading?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                const CupertinoActivityIndicator(),
              ],
            ),
          )
              :
          IconButton(
            onPressed: ()async{
              bool status = await Permission.storage.isGranted;

              if (!status) await Permission.storage.request();

              setState(() {
                isDownloading=true;
                percentage='';
              });

              var tempDir = await getApplicationDocumentsDirectory();
              String fullPath = tempDir.path + "/${widget.name}.pdf";
              print('full path ${fullPath}');

              await download(fullPath);
              Share.shareFiles([fullPath], text: '${widget.name}');
              setState(() {
                isDownloading=false;
              });
            },
            icon: const Icon(Icons.download),
          )
        ],
      ),
      body: SfPdfViewer.network(
          widget.url),
    );
  }
}
