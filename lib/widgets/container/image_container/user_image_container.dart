import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, required this.url, this.radius})
      : super(key: key);

  final String url;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius != null ? radius! * 2 : null,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipRRect(
          borderRadius: Dimens.kMaxBorderRadius,
          // handle 404 NOT Found Image
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (BuildContext context, String url, dynamic error) {
              if (error.statusCode == 403) {
                // Code to handle 403 error corrections on the database.
                // Not implemented when experiencing this issue.
              } else if (error.statusCode == 404) {
                // log("File Not Found");
              }
              return const Icon(Icons.person_outline_rounded);
            },
          ),
        ),
      ),
    );
  }
}
