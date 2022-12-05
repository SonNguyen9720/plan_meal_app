import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_meal_app/config/theme.dart';

class ProfileTileComponent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onPressed;

  const ProfileTileComponent(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            imageUrl.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset(
                      imageUrl,
                      height: 20,
                      width: 20,
                      color: AppColors.green,
                    ),
                  )
                : Container(),
            Expanded(
                child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            )),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
