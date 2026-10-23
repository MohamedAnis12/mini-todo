import 'package:flutter/material.dart';
import 'package:minitodo/models/task_model.dart';
import 'package:minitodo/views/edit_task_view/widgets/custom_is_done_container.dart';

class CustomIsDoneRow extends StatefulWidget {
  const CustomIsDoneRow({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  State<CustomIsDoneRow> createState() => _CustomIsDoneRowState();
}

class _CustomIsDoneRowState extends State<CustomIsDoneRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CustomIsDoneContainer(
            text: 'done',
            isDone: widget.task.isDone,
            onTap: () {
              setState(() {
                widget.task.isDone = true;
              });
            },
          ),
        ),
        Expanded(
          child: CustomIsDoneContainer(
            text: 'notDone',
            isDone: !widget.task.isDone,
            onTap: () {
              setState(() {
                widget.task.isDone = false;
              });
            },
          ),
        ),
      ],
    );
  }
}