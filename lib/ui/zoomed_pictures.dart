import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ZoomedPictures extends StatelessWidget {
  final String url;
  const ZoomedPictures({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl: url,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
