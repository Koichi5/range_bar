import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Demo screen for actual value range specification
class ValueRangeDemoScreen extends StatefulWidget {
  const ValueRangeDemoScreen({super.key});

  @override
  ValueRangeDemoScreenState createState() => ValueRangeDemoScreenState();
}

class ValueRangeDemoScreenState extends State<ValueRangeDemoScreen> {
  // Task data for new app development project
  final DateTime _projectStart = DateTime(2024, 1, 1);
  final DateTime _projectEnd = DateTime(2024, 12, 31);

  final List<ProjectTask> _tasks = [
    ProjectTask(
      id: 'planning',
      name: 'Planning & Requirements',
      startDate: DateTime(2024, 1, 15),
      endDate: DateTime(2024, 2, 28),
      color: Colors.blue,
      progress: 1.0,
      status: TaskStatus.completed,
      assignee: 'Planning Team',
      dependencies: [],
    ),
    ProjectTask(
      id: 'design',
      name: 'UI/UX Design',
      startDate: DateTime(2024, 2, 15),
      endDate: DateTime(2024, 4, 15),
      color: Colors.lightBlue,
      progress: 1.0,
      status: TaskStatus.completed,
      assignee: 'Design Team',
      dependencies: ['planning'],
    ),
    ProjectTask(
      id: 'backend',
      name: 'Backend Development',
      startDate: DateTime(2024, 3, 1),
      endDate: DateTime(2024, 7, 31),
      color: Colors.blue,
      progress: 0.8,
      status: TaskStatus.inProgress,
      assignee: 'Backend Team',
      dependencies: ['planning'],
    ),
    ProjectTask(
      id: 'frontend',
      name: 'Frontend Development',
      startDate: DateTime(2024, 4, 1),
      endDate: DateTime(2024, 8, 15),
      color: Colors.cyan,
      progress: 0.6,
      status: TaskStatus.inProgress,
      assignee: 'Frontend Team',
      dependencies: ['design'],
    ),
    ProjectTask(
      id: 'mobile',
      name: 'Mobile App Development',
      startDate: DateTime(2024, 5, 1),
      endDate: DateTime(2024, 9, 30),
      color: Colors.teal,
      progress: 0.3,
      status: TaskStatus.inProgress,
      assignee: 'Mobile Team',
      dependencies: ['design', 'backend'],
    ),
    ProjectTask(
      id: 'testing',
      name: 'Testing & QA',
      startDate: DateTime(2024, 7, 1),
      endDate: DateTime(2024, 10, 15),
      color: Colors.indigo,
      progress: 0.2,
      status: TaskStatus.inProgress,
      assignee: 'QA Team',
      dependencies: ['backend', 'frontend'],
    ),
    ProjectTask(
      id: 'deployment',
      name: 'Deployment & Release Prep',
      startDate: DateTime(2024, 9, 15),
      endDate: DateTime(2024, 11, 15),
      color: Colors.blueGrey,
      progress: 0.0,
      status: TaskStatus.pending,
      assignee: 'DevOps Team',
      dependencies: ['testing'],
    ),
    ProjectTask(
      id: 'launch',
      name: 'Official Launch',
      startDate: DateTime(2024, 11, 1),
      endDate: DateTime(2024, 11, 30),
      color: Colors.lightBlue,
      progress: 0.0,
      status: TaskStatus.pending,
      assignee: 'All Teams',
      dependencies: ['deployment'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gantt chart section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Gantt chart header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timeline,
                          color: colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Project Timeline',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'FY 2024',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Timeline display
                  _buildTimelineHeader(),

                  // Gantt chart
                  _buildGanttChart(),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Project statistics
            _buildProjectStats(),
            const SizedBox(height: 32),

            // Implementation example
            _buildImplementationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineHeader() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: colorScheme.outline, width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 180), // Space for task names
          Expanded(
            flex: 3, // 3x width for graph section
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: List.generate(12, (index) {
                  final month = index + 1;
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: colorScheme.outline,
                            width: index == 0 ? 0 : 0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        _getMonthName(month),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGanttChart() {
    return Column(children: _tasks.map((task) => _buildTaskRow(task)).toList());
  }

  Widget _buildTaskRow(ProjectTask task) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Task information section (reduced width)
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _getStatusIcon(task.status),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        task.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  task.assignee,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: task.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${(task.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: task.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (task.dependencies.isNotEmpty)
                      Icon(
                        Icons.link,
                        size: 10,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Gantt chart section (significantly expanded width)
          Expanded(
            flex: 3, // Ensure 3x width
            child: Container(
              height: 40, // Slightly increased height
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                // Background for displaying month boundaries
                border: Border(
                  left: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.5),
                    width: 0.5,
                  ),
                  right: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.5),
                    width: 0.5,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  // Month boundaries
                  Row(
                    children: List.generate(11, (index) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: colorScheme.outline.withValues(
                                  alpha: 0.5,
                                ),
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  // Range Bar
                  RangeBar(
                    ranges: [
                      RangeData(
                        startPosition: _normalizeDateValue(
                          task.startDate,
                          _projectStart,
                          _projectEnd,
                        ),
                        endPosition: _normalizeDateValue(
                          task.endDate,
                          _projectStart,
                          _projectEnd,
                        ),
                        color: task.color,
                        label: task.name,
                        startValueLabel: _formatDate(task.startDate),
                        endValueLabel: _formatDate(task.endDate),
                        tooltip:
                            '${task.name}\nPeriod: ${_formatDate(task.startDate)} - ${_formatDate(task.endDate)}\nAssignee: ${task.assignee}\nProgress: ${(task.progress * 100).toInt()}%',
                      ),
                    ],
                    height: 28, // Increased bar height
                    borderRadius: BorderRadius.circular(14),
                    backgroundColor:
                        Colors.transparent, // Transparent background
                    showLabels: false,
                    showTooltip: true,
                    showStartValueLabels: false,
                    showEndValueLabels: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return Icon(Icons.check_circle, color: Colors.green, size: 16);
      case TaskStatus.inProgress:
        return Icon(Icons.play_circle, color: Colors.orange, size: 16);
      case TaskStatus.pending:
        return Icon(Icons.schedule, color: Colors.grey, size: 16);
    }
  }

  Widget _buildProjectStats() {
    final colorScheme = Theme.of(context).colorScheme;
    final totalDuration = _projectEnd.difference(_projectStart).inDays;
    final completedTasks = _tasks
        .where((task) => task.status == TaskStatus.completed)
        .length;
    final totalProgress =
        _tasks.fold<double>(0, (sum, task) => sum + task.progress) /
        _tasks.length;

    // Current date (assumed to be July 15 for demo)
    final currentDate = DateTime(2024, 7, 15);
    final elapsedDays = currentDate.difference(_projectStart).inDays;
    final timeProgress = elapsedDays / totalDuration;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: colorScheme.primary, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Project Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Overall progress
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overall Progress Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                RangeBar(
                  ranges: [
                    RangeData(
                      startPosition: 0.0,
                      endPosition: totalProgress,
                      color: Colors.blue,
                      label: 'Completed',
                      endValueLabel: '${(totalProgress * 100).toInt()}%',
                    ),
                  ],
                  height: 24,
                  borderRadius: BorderRadius.circular(12),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: false,
                  showEndValueLabels: true,
                ),
                const SizedBox(height: 8),
                Text(
                  'Work Progress: ${(totalProgress * 100).toInt()}% | Time Progress: ${(timeProgress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Statistics information
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Completed Tasks',
                  '$completedTasks/${_tasks.length}',
                  Icons.task_alt,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Elapsed Days',
                  '$elapsedDays days',
                  Icons.calendar_today,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Remaining Days',
                  '${totalDuration - elapsedDays} days',
                  Icons.schedule,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildImplementationSection() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: colorScheme.secondary, size: 24),
              const SizedBox(width: 12),
              Text(
                'Implementation Example',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'How to implement Gantt charts:',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '''// Gantt chart task example
final projectStart = DateTime(2024, 1, 1);
final projectEnd = DateTime(2024, 12, 31);

final task = ProjectTask(
  name: 'Backend Development',
  startDate: DateTime(2024, 3, 1),
  endDate: DateTime(2024, 7, 31),
  color: Colors.green,
  progress: 0.8,
);

// Display task duration with RangeBar
RangeBar(
  ranges: [
    RangeData(
      startPosition: normalizeDateValue(task.startDate, projectStart, projectEnd),
      endPosition: normalizeDateValue(task.endDate, projectStart, projectEnd),
      color: task.color,
      label: task.name,
      startValueLabel: formatDate(task.startDate),
      endValueLabel: formatDate(task.endDate),
      tooltip: '\${task.name}\\nPeriod: \${formatDate(task.startDate)} - \${formatDate(task.endDate)}\\nProgress: \${(task.progress * 100).toInt()}%',
    ),
  ],
  backgroundColor: colorScheme.surfaceContainerHighest, // Display overall timeline
  showTooltip: true,
);

// Date normalization function
double normalizeDateValue(DateTime date, DateTime min, DateTime max) {
  final dateMs = date.millisecondsSinceEpoch.toDouble();
  final minMs = min.millisecondsSinceEpoch.toDouble();
  final maxMs = max.millisecondsSinceEpoch.toDouble();
  return (dateMs - minMs) / (maxMs - minMs);
}''',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: colorScheme.onSecondaryContainer.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  double _normalizeDateValue(DateTime date, DateTime min, DateTime max) {
    final dateMs = date.millisecondsSinceEpoch.toDouble();
    final minMs = min.millisecondsSinceEpoch.toDouble();
    final maxMs = max.millisecondsSinceEpoch.toDouble();
    return (dateMs - minMs) / (maxMs - minMs);
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

// Data models
class ProjectTask {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;
  final double progress;
  final TaskStatus status;
  final String assignee;
  final List<String> dependencies;

  ProjectTask({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.color,
    required this.progress,
    required this.status,
    required this.assignee,
    required this.dependencies,
  });
}

enum TaskStatus { pending, inProgress, completed }
