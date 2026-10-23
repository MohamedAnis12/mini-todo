import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minitodo/models/task_model.dart';
import 'package:minitodo/shared_widgets/custom_button.dart';
import 'package:minitodo/shared_widgets/custom_text.dart';
import 'package:minitodo/task_cubit/task_cubit.dart';
import 'package:minitodo/views/add_new_task_view/widgets/custom_text_field.dart';

class AddNewTaskView extends StatefulWidget {
  const AddNewTaskView({super.key});

  @override
  State<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends State<AddNewTaskView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  final TaskModel task = TaskModel(title: "", description: "");
  @override
  void dispose() {
    titleController.dispose();
    descriptionController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  CustomText(text: "Add New Task", fontSize: 24),
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
              Spacer(),
              CustomButton(
                text: "Add task",
                onTap: () async {
                  task.title = titleController.text;
                  task.description = descriptionController!.text;
                  await context.read<TaskCubit>().addNewTask(task);
                  Navigator.pop(context);
                },
              ),
              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
