import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerLoadingEffect extends StatelessWidget {
  ProfileShimmerLoadingEffect({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _buildBackgroundImage(context),
              Positioned(bottom: 0, child: _buildUserInforTagShimmer(context)),
            ],
          ),
          _buildDataContentSection(context),
          _buildDataContentSection(context),
          _buildDataContentSection(context),
          _buildDataContentSection(context),
          _buildDataContentSection(context),
        ],
      ),
    );
  }

  Padding _buildDataContentSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ShimmerSection(
            child: Container(
              height: Dimens.medium_text,
              width: DeviceUtils.getScaledWidth(context, 0.35),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: Dimens.kMaxBorderRadius,
              ),
            ),
          ),
          const SizedBox(
            height: Dimens.vertical_margin,
          ),
          _ShimmerSection(
            child: Container(
              height: Dimens.medium_text * 5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: Dimens.kMaxBorderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, 0.5),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: Dimens.kMaxBorderRadius,
      ),
      child: Center(
        child: _ShimmerSection(
          child: Container(
            width: DeviceUtils.getScaledWidth(context, 0.8),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: Dimens.kMaxBorderRadius,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInforTagShimmer(BuildContext context) {
    return GlassmorphismContainer(
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.vertical_padding,
        horizontal: Dimens.horizontal_padding,
      ),
      height: kToolbarHeight * 3,
      width: DeviceUtils.getScaledWidth(context, 1.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ShimmerSection(
                  child: Container(
                    width: double.infinity,
                    height: Dimens.medium_text,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: Dimens.kMaxBorderRadius,
                    ),
                  ),
                ),
                _ShimmerSection(
                  child: Container(
                    width: 50,
                    height: Dimens.medium_text,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: Dimens.kMaxBorderRadius,
                    ),
                  ),
                ),
                _ShimmerSection(
                  child: Container(
                    width: 150,
                    height: Dimens.medium_text,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: Dimens.kMaxBorderRadius,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ShimmerSection(
                      child: Container(
                        width: 50,
                        height: Dimens.medium_text,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: Dimens.kMaxBorderRadius,
                        ),
                      ),
                    ),
                    _ShimmerSection(
                      child: Container(
                        width: 50,
                        height: Dimens.medium_text,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: Dimens.kMaxBorderRadius,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: Dimens.extra_large_horizontal_margin,
          ),
          _ShimmerSection(
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 0.35),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: Dimens.kMaxBorderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ShimmerSection({required Widget child}) {
    return Shimmer.fromColors(
      child: child,
      baseColor: _themeStore.light.withOpacity(0.5),
      highlightColor: _themeStore.themeColorfulColorShimmer,
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 3000),
    );
  }
}
