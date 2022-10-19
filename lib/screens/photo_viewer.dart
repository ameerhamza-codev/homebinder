import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../utils/constants.dart';

class PhotoViewer extends StatefulWidget {
  String name,url;

  PhotoViewer(this.name,this.url);

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.name),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.download),
          )
        ],
      ),
      body: widget.url==""?PhotoView(
        imageProvider: AssetImage("assets/images/placeholder-image.jpeg"),
      ):
      PhotoView(
        imageProvider: NetworkImage(widget.url),
      ),
    );
  }
}
