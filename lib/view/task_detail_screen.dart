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
        title: const Text('Task Details',style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditTaskDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete,),
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
              height: MediaQuery.of(context).size.height - 204,
              width: MediaQuery.of(context).size.width - 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ${task.title}',
                        style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    Text('Description: ${task.description}',
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
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

  // Show a dialog to edit the task
  void _showEditTaskDialog(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    DateTime selectedDate = task.dueDate;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Edit Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Due Date: ${DateFormat.yMMMd().format(selectedDate)}'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: const Text('Select Date', style: TextStyle(color: Colors.blue),),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Update the task with new values
                  final updatedTask = task.copyWith(
                    title: titleController.text,
                    description: descriptionController.text,
                    dueDate: selectedDate,
                  );
                  taskProvider.updateTask(updatedTask);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }


}
