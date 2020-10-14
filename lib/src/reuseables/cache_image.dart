import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;

  const CustomCacheImage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, value) {
        return Container(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
