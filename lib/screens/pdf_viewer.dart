import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';

class PdfViewClass extends StatefulWidget {
 String name,url;

 PdfViewClass(this.name,this.url);

  @override
  _PdfViewClassState createState() => _PdfViewClassState();
}

class _PdfViewClassState extends State<PdfViewClass> {

  bool _isLoading=false;
  PDFDocument? doc;
  getPDF()async{
    setState(() {
      _isLoading=true;
    });
    doc = await PDFDocument.fromURL(widget.url);
    setState(() {
      _isLoading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPDF();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.name),
      ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: doc!)),
    );
  }
}
