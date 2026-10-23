
import 'package:flutter/material.dart';
import 'package:minitodo/constants/colors.dart';
import 'package:minitodo/shared_widgets/custom_text.dart';

class CustomIsDoneContainer extends StatelessWidget {
  const CustomIsDoneContainer({
    super.key,
    required this.text,
    required this.isDone,
    required this.onTap,
  });
  final String text;
  final bool isDone;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 60,
          // width: double.infinity,
          decoration: BoxDecoration(
            color: isDone ? AppColors.mainColor : Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: CustomText(
              text: text,
              color: isDone ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
