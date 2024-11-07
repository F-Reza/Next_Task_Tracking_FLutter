import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';


class TaskAnalyticsScreen extends StatelessWidget {
  const TaskAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completedTasks = taskProvider.tasks.where((task) => task.isCompleted).length;
    final pendingTasks = taskProvider.tasks.length - completedTasks;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFe84132),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Task Analytics',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Task Status Distribution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 200, child: PieChart(PieChartData(
              sections: [
                PieChartSectionData(
                  value: completedTasks.toDouble(),
                  color: Colors.green,
                  title: 'Completed',titleStyle: TextStyle(color: Colors.white),
                  radius: 60,
                ),
                PieChartSectionData(
                  value: pendingTasks.toDouble(),
                  color: Colors.red,
                  title: 'Pending',
                  radius: 60,
                ),
              ],
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ))),
            const SizedBox(height: 20),
            const Text(
              'Task Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 1),
                        const FlSpot(1, 2),
                        const FlSpot(2, 3),
                        FlSpot(3, completedTasks.toDouble()),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
