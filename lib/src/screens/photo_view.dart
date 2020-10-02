import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class NetworkPhotoViewPage extends StatelessWidget {
  final String url;

  NetworkPhotoViewPage({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(this.url),
          enableRotation: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.close,
        ),
        backgroundColor: Colors.white30,
        elevation: 0.0,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class PhotoViewerPage extends StatelessWidget {
  final File file;

  PhotoViewerPage({@required this.file});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
          imageProvider: FileImage(file),
          enableRotation: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.close,
        ),
        backgroundColor: Colors.white30,
        elevation: 0.0,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
