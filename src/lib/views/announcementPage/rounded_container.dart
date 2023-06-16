import 'package:flutter/material.dart';
import 'package:pet_share/utils/app_colors.dart';

class RoundedContainer extends StatelessWidget {
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? widht;
  final Widget logo;
  final Widget? child;

  const RoundedContainer({
    this.elevation = 6,
    this.borderRadius = 15,
    this.padding,
    this.height,
    this.widht,
    required this.logo,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: padding,
        height: height,
        width: widht,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: AppColors.field,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: AppColors.navigation,
                    thickness: 2,
                    indent: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: logo,
                ),
                const Expanded(
                  child: Divider(
                    color: AppColors.navigation,
                    thickness: 2,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
