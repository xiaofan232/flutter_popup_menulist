import 'package:flutter/material.dart';
import 'cached_network_image_extend.dart';

/// cached network image
Widget buildNetWorkImage(String url,
    {fit: BoxFit.cover, defaultImageAssetPath = ""}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    ),
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => CircularProgressIndicator(),
  );
}
