import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class GenderButton extends StatelessWidget {
  const GenderButton(
      {Key? key,
      required this.iconData,
      required this.gender,
      this.isSelected = false})
      : super(key: key);

  final IconData iconData;
  final String gender;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: AppColors.green,
              size: 50,
            ),
            Text(
              gender,
              style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppColors.orange : AppColors.backgroundInput,
        ));
  }
}

// class GenderButton extends StatefulWidget {
//   final IconData iconData;
//   final String gender;
//   final Color? color;
//   final bool isSelected;
//   const GenderButton(
//       {Key? key,
//       required this.iconData,
//       required this.gender,
//       this.color,
//       this.isSelected = false})
//       : super(key: key);

//   @override
//   State<GenderButton> createState() => _GenderButtonState();
// }

// class _GenderButtonState extends State<GenderButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 150,
//         height: 150,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               widget.iconData,
//               color: widget.color,
//               size: 50,
//             ),
//             Text(
//               widget.gender,
//               style: const TextStyle(
//                   color: widget.isSelected ? AppColors.white : AppColors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600),
//             )
//           ],
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: AppColors.backgroundInput,
//         ));
//   }
// }
