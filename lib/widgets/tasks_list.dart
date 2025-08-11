import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'task_tile.dart';
import 'custom_text_field.dart';

class TasksList extends StatelessWidget {
  final Box box;
  const TasksList({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    if (box.isEmpty) {
      return Center(
        child: Text(
          "No tasks yet!",
          style: TextStyle(fontSize: 18.0.sp, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 15.0, bottom: 80.0),
      itemCount: box.length,
      itemBuilder: (context, index) {
        final dynamic taskData = box.getAt(index);
        if (taskData is! Map) {
          return Container();
        }
        final task = taskData;

        return TaskTile(
          taskTitle: task['name'] ?? 'Untitled Task',
          isChecked: task['isDone'] ?? false,
          checkboxCallback: (value) {
            box.putAt(index, {
              'name': task['name'],
              'isDone': value ?? false,
            });
          },
          longPressCallback: () {
            _showTaskOptions(context, task, index);
          },
        );
      },
    );
  }

  void _showTaskOptions(BuildContext context, Map task, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.h),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: Colors.blueAccent),
                title: const Text('Edit Task'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditTaskDialog(context, task, index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                title: const Text('Delete Task'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmDialog(context, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, Map task, int index) {
    final controller = TextEditingController(text: task['name']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(child: Text('Edit Task',style: TextStyle(fontSize: 20.sp),)),
          content: CustomTextField(
            controller: controller,
            text: 'New task name',
            textInputAction: TextInputAction.done,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black38, fontSize: 16.sp),
              ),
            ),
            SizedBox(width: 10.w),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () {
                final updatedName = controller.text.trim();
                if (updatedName.isNotEmpty) {
                  box.putAt(index, {
                    'name': updatedName,
                    'isDone': task['isDone'],
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Delete Task?'),
          content: const Text('Are you sure you want to permanently delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                style: TextStyle(color: Colors.black38,),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                box.deleteAt(index);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
