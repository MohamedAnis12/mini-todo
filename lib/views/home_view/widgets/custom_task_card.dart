import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minitodo/models/task_model.dart';
import 'package:minitodo/shared_widgets/custom_text.dart';
import 'package:minitodo/task_cubit/task_cubit.dart';
import 'package:minitodo/views/edit_task_view/edit_task_view.dart';

class CustomTaskCard extends StatelessWidget {
  const CustomTaskCard({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.green,
                value: task.isDone,
                onChanged: (value) async {
                  task.isDone = !task.isDone;
                  await context.read<TaskCubit>().updateTask(task);
                },
              ),
              Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(7),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: task.isDone
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 5,
                            ),
                            child: CustomText(
                              text: task.isDone ? "complete" : "pending",
                              color: task.isDone ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                        Gap(30),
                        CustomText(text: "${task.id}", color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  final taskCubit = context.read<TaskCubit>();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: taskCubit,
                        child: EditTaskView(task: task),
                      ),
                    ),
                  );
                },
                child: Icon(Icons.more_vert, size: 38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
