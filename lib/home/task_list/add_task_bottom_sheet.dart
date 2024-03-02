import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_sun11/dialog_utils.dart';
import 'package:flutter_app_todo_c10_sun11/firebase_utils.dart';
import 'package:flutter_app_todo_c10_sun11/model/task.dart';
import 'package:flutter_app_todo_c10_sun11/providers/auth_provider.dart';
import 'package:flutter_app_todo_c10_sun11/providers/list_provider.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onChanged: (text) {
                      title = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter task title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Enter Task Title'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      description = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter task description';
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(hintText: 'Enter Task Description'),
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Select Date',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ))
                ],
              )),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      var authProvider = Provider.of<AuthProviders>(context, listen: false);
      DialogUtils.showLoading(context: context, message: 'Loading...');
      FirebaseUtils.addTaskToFireStore(task, authProvider.currentUser!.id!)
          .then((value) {
        // alert dialog
        Navigator.pop(context);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context, message: 'Task added Successfully');
        print('task added successfully');
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        print('task added successfully');
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);

        /// alert dialog , toast , snackbar
        ///
      });
    }
  }
}
