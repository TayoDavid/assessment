import 'package:assessment/data/model/task.dart';
import 'package:assessment/resources/utils/constants.dart';
import 'package:assessment/resources/utils/extensions.dart';
import 'package:assessment/ui/views/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    this.onDoneTapped,
    this.onEditTapped,
    this.onDeleteTapped,
  });

  final Task task;
  final VoidCallback? onDoneTapped;
  final VoidCallback? onEditTapped;
  final VoidCallback? onDeleteTapped;

  @override
  Widget build(BuildContext context) {
    final completed = task.completed == 1;
    final cs = Theme.of(context).colorScheme;
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          CustomSlidableAction(
            flex: 2,
            padding: EdgeInsets.zero,
            onPressed: (_) => onDoneTapped!(),
            backgroundColor: green,
            foregroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check, size: 16).padding(bottom: 4),
                AppText(
                  completed ? 'InComplete' : 'Completed',
                  size: 13,
                  weight: FontWeight.w500,
                  color: kWhite,
                ),
              ],
            ).center,
          ),
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (_) => onEditTapped!(),
            backgroundColor: mildGreenBorder,
            foregroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, size: 16).padding(bottom: 4),
                AppText(
                  'Edit',
                  size: 13,
                  weight: FontWeight.w500,
                  color: kWhite,
                ),
              ],
            ).center,
          ),
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (_) => onDeleteTapped!(),
            backgroundColor: bluePrimary,
            foregroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, size: 16).padding(bottom: 4),
                AppText(
                  'Delete',
                  size: 13,
                  weight: FontWeight.w500,
                  color: kWhite,
                ),
              ],
            ).center,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        title: AppText(
          task.title.value,
          color: completed ? greyTitle : cs.onBackground,
        ),
        subtitle: AppText(
          task.description.value,
          color: completed ? greyTitle : cs.onBackground,
        ),
      ),
    );
  }
}
