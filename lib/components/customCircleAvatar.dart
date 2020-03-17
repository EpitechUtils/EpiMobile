import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {

    final Widget noPicture;
    final double radius;
    final String imagePath;

    const CustomCircleAvatar({
        Key key,
        @required this.noPicture,
        @required this.radius,
        @required this.imagePath
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            constraints: BoxConstraints(
                minHeight: radius,
                maxHeight: radius,
                minWidth: radius,
                maxWidth: radius,
            ),
            child: ClipOval(
                child: CachedNetworkImage(
                    errorWidget: (BuildContext context, String url, Object error) {
                        return this.noPicture;
                    },
                    fit: BoxFit.cover,
                    imageUrl: this.imagePath,
                ),
            ),
        );
    }

}