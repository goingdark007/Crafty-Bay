import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';

class SectionHeader extends StatelessWidget {

  final String title;
  final VoidCallback onTapSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onTapSeeAll
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.titleMedium),
        TextButton(
            onPressed: onTapSeeAll,
            child: Text(context.l10n.homeScreenAll, style: const TextStyle(color: AppColors.themeColor))
        )
      ],
    );
  }
}