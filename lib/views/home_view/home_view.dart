import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minitodo/constants/colors.dart';
import 'package:minitodo/shared_widgets/custom_text.dart';
import 'package:minitodo/task_cubit/task_cubit.dart';
import 'package:minitodo/views/add_new_task_view/add_new_task_view.dart';
import 'package:minitodo/views/home_view/widgets/custom_task_card.dart';
import 'package:minitodo/views/home_view/widgets/custom_task_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is TaskError) {
          return Center(child: CustomText(text: state.message));
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(50),
                  CustomText(text: 'My Tasks', fontSize: 42),
                  Gap(20),
                  CustomText(
                    text: "keep going , you are doing grate!",
                    color: Colors.grey,
                  ),
                  Gap(20),
                  Row(
                    children: [
                      CustomTasksContainer(
                        text: "all",
                        number: 0,
                        tasks: tasks,
                      ),
                      Gap(20),
                      CustomTasksContainer(
                        text: "complete",
                        number: 1,
                        tasks: tasks,
                      ),
                      Gap(20),
                      CustomTasksContainer(
                        text: "pending",
                        number: 2,
                        tasks: tasks,
                      ),
                    ],
                  ),
                  Gap(20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, index) {
                        return CustomTaskCard(task: tasks[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              shape: CircleBorder(),
              child: Icon(Icons.add, color: Colors.white, size: 38),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<TaskCubit>(),
                      child: AddNewTaskView(),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
