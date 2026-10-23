import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minitodo/models/task_model.dart';
import 'package:minitodo/shared_widgets/custom_button.dart';
import 'package:minitodo/shared_widgets/custom_text.dart';
import 'package:minitodo/task_cubit/task_cubit.dart';
import 'package:minitodo/views/add_new_task_view/widgets/custom_text_field.dart';
import 'package:minitodo/views/edit_task_view/widgets/custom_is_done_row.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key, required this.task});
  final TaskModel task;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  //variables++++++++++++++++++++++
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //states++++++++++++++++++++++++++
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(
      text: widget.task.description,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  //+++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(50),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_new, size: 32),
                    ),
                    Gap(50),
                    CustomText(text: "Edit Task", fontSize: 24),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        await context.read<TaskCubit>().deleteTask(widget.task);
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red.shade200,
                        size: 36,
                      ),
                    ),
                  ],
                ),
                Gap(50),
                CustomText(text: "Task Title", fontSize: 20),
                Gap(10),
                CustomTextField(
                  hintText: "Enter task title",
                  controller: titleController,
                ),
                Gap(20),
                CustomText(text: "Description(optional)", fontSize: 20),
                Gap(10),
                CustomTextField(
                  hintText: "Enter description",
                  controller: descriptionController,
                  maxLines: 6,
                ),
                Gap(50),
                CustomText(text: "Status", fontSize: 24),
                Gap(20),
                CustomIsDoneRow(task: widget.task),
                Gap(150),
                CustomButton(
                  text: "Edit task",
                  onTap: () async {
                    widget.task.title = titleController.text;
                    widget.task.description = descriptionController.text;
                    await context.read<TaskCubit>().updateTask(widget.task);
                    Navigator.pop(context);
                  },
                ),
                Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
