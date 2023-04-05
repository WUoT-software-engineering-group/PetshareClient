import 'package:pet_share/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LabeledIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const LabeledIcon(this.icon, this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.smallElements['reddish'],
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            label,
            style:
                TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
