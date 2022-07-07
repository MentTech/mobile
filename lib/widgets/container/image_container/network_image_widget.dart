import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    Key? key,
    required this.url,
    this.radius,
    this.alternativeUrl,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  final String? url;
  final String? alternativeUrl;
  final double? radius;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius != null ? radius! * 2 : null,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipRRect(
          borderRadius: borderRadius ?? Dimens.kMaxBorderRadius,
          // handle 404 NOT Found Image
          child: InkWell(
            borderRadius: borderRadius ?? Dimens.kMaxBorderRadius,
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: url ??
                  alternativeUrl ??
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (BuildContext context, String url, dynamic error) {
                // if (error.statusCode == 403) {
                //   // Code to handle 403 error corrections on the database.
                //   // Not implemented when experiencing this issue.
                // } else if (error.statusCode == 404) {
                //   // log("File Not Found");
                // }
                return alternativeUrl != null
                    ? Image.network(alternativeUrl!)
                    : const Icon(Icons.person_outline_rounded);
              },
            ),
          ),
        ),
      ),
    );
  }
}
