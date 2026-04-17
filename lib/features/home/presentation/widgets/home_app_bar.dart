import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/asset_paths.dart';
import 'app_bar_icon_button.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetPaths.navLogoSVG),
      actions: [
        AppBarIconButton(icon: Icons.person, onTap: (){}),
        const SizedBox(width: 6),
        AppBarIconButton(icon: Icons.call, onTap: (){}),
        const SizedBox(width: 6),
        AppBarIconButton(icon: Icons.notifications_active_outlined, onTap: () {}),
        const SizedBox(width: 10)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}