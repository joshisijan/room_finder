import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularCacheImage extends StatelessWidget {
  final String photoUrl;
  final double diameter;
  final Color borderColor;

  const CircularCacheImage({
    Key key,
    @required this.photoUrl,
    this.diameter = 100.0,
    @required this.borderColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photoUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          border: Border.all(color: this.borderColor),
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
