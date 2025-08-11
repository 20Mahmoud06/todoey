import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../widgets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  final BuildContext parentContext;
  const AddTaskScreen({super.key, required this.parentContext});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _controller = TextEditingController();
  final String text = 'Enter your task';
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0.sp,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 15.0.h),
            CustomTextField(controller: _controller, text: text),
            if (_errorMessage != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
            SizedBox(height: 15.0.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {
                final taskTitle = _controller.text.trim();
                if (taskTitle.isNotEmpty) {
                  final box = Hive.box('tasksBox');
                  box.add({'name': taskTitle, 'isDone': false});
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _errorMessage = "Task cannot be empty!";
                  });
                }
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
