import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/task.dart';
import '../provider/task_provider.dart';
import 'package:intl/intl.dart';



class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFe84132),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Task Details',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              taskProvider.deleteTask(task.id!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height - 179,
              width: MediaQuery.of(context).size.width - 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ${task.title}', style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    Text('Description: ${task.description}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                    const SizedBox(height: 20),
                    Text(
                      'Due Date: ${DateFormat.yMMMd().format(task.dueDate)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Spacer(),
          Container(
            height: 80,
            color: const Color(0xFFe84132),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                taskProvider.updateTask(task.copyWith(isCompleted: !task.isCompleted));
                Navigator.pop(context);
              },
              child: Text(task.isCompleted ? 'Mark as Incomplete' : 'Mark as Complete'),
            ),
          ),
        ],
      ),
    );
  }
}
