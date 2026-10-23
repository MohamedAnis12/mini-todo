import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minitodo/constants/colors.dart';
import 'package:minitodo/models/task_model.dart';
import 'package:minitodo/shared_widgets/custom_text.dart';
import 'package:minitodo/task_cubit/task_cubit.dart';

class CustomTasksContainer extends StatelessWidget {
  const CustomTasksContainer({
    super.key,
    required this.text,
    required this.number,
    required this.tasks,
  });
  final String text;
  final int number;
  final List<TaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TaskCubit>().filterTasks(number);
      },
      child: Container(
        height: 50,

        decoration: BoxDecoration(
          color: context.read<TaskCubit>().filterNumber == number
              ? AppColors.mainColor
              : Color(0xfff7f9fd),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.mainColor, width: 2),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomText(
              text: text,
              color: context.read<TaskCubit>().filterNumber == number
                  ? Color(0xfff7f9fd)
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
