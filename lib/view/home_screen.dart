import 'package:flutter/material.dart';
import 'package:next_task/view/task_analytics_scree.dart';
import 'package:provider/provider.dart';
import '../model/task.dart';
import '../provider/task_provider.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completedTasks = taskProvider.tasks.where((task) => task.isCompleted).length;
    final totalTasks = taskProvider.tasks.length;

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: const Color(0xFFe84132),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('My Tasks',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.note_add,size: 30,),
            onPressed: () {
              _showAddTaskDialog(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const TaskAnalyticsScreen()),
              // );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Task Summary
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskAnalyticsScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFD5901),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Task Summary',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$completedTasks of $totalTasks tasks completed',
                      style: const TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(minHeight: 10,
                      value: totalTasks == 0 ? 0 : completedTasks / totalTasks,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 10),
            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return Card(
                    elevation: 5,
                    color: const Color(0xFFFD5901),
                    child: ListTile(
                      title: Text(task.title,style: const TextStyle(color: Colors.white),),
                      subtitle: Text(task.description,style: const TextStyle(color: Colors.white70),),
                      trailing: Icon(
                        task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: task.isCompleted ? Colors.green : Colors.white,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(task: task),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog for adding a new task
  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newTask = Task(
                title: titleController.text,
                description: descriptionController.text,
                isCompleted: false,
                dueDate: DateTime.now() //.add(const Duration(days: 7)),
              );
              taskProvider.addTask(newTask);
              Navigator.of(context).pop();
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
