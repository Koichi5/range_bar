import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Use case for project progress management screen
class ProjectManagementScreen extends StatefulWidget {
  const ProjectManagementScreen({super.key});

  @override
  ProjectManagementScreenState createState() => ProjectManagementScreenState();
}

class ProjectManagementScreenState extends State<ProjectManagementScreen> {
  // Project data
  final List<ProjectData> _projects = [
    ProjectData(
      name: 'Mobile App Development',
      phases: [
        PhaseData(
          'Planning & Design',
          0.0,
          0.2,
          Colors.blue,
          isCompleted: true,
        ),
        PhaseData('UI/UX Design', 0.2, 0.35, Colors.purple, isCompleted: true),
        PhaseData(
          'Development',
          0.35,
          0.8,
          Colors.orange,
          isCompleted: false,
          currentProgress: 0.65,
        ),
        PhaseData('Testing', 0.8, 0.95, Colors.red, isCompleted: false),
        PhaseData('Release', 0.95, 1.0, Colors.green, isCompleted: false),
      ],
      deadline: 'March 31, 2024',
      teamSize: 8,
    ),
    ProjectData(
      name: 'Website Renewal',
      phases: [
        PhaseData(
          'Requirements Definition',
          0.0,
          0.15,
          Colors.indigo,
          isCompleted: true,
        ),
        PhaseData('Design', 0.15, 0.4, Colors.teal, isCompleted: true),
        PhaseData('Frontend', 0.4, 0.7, Colors.amber, isCompleted: true),
        PhaseData(
          'Backend',
          0.7,
          0.9,
          Colors.deepOrange,
          isCompleted: false,
          currentProgress: 0.85,
        ),
        PhaseData(
          'Launch Preparation',
          0.9,
          1.0,
          Colors.green,
          isCompleted: false,
        ),
      ],
      deadline: 'February 15, 2024',
      teamSize: 5,
    ),
    ProjectData(
      name: 'Data Analytics Platform',
      phases: [
        PhaseData(
          'Research & Analysis',
          0.0,
          0.25,
          Colors.cyan,
          isCompleted: true,
        ),
        PhaseData(
          'Architecture Design',
          0.25,
          0.4,
          Colors.blue,
          isCompleted: true,
        ),
        PhaseData(
          'Infrastructure Setup',
          0.4,
          0.75,
          Colors.purple,
          isCompleted: false,
          currentProgress: 0.5,
        ),
        PhaseData('Data Pipeline', 0.75, 1.0, Colors.pink, isCompleted: false),
      ],
      deadline: 'April 30, 2024',
      teamSize: 6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header statistics
            _buildOverviewCards(),
            const SizedBox(height: 24),

            // Project list
            const Text(
              'Project Progress',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ...(_projects.map((project) => _buildProjectCard(project))),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCards() {
    final totalProjects = _projects.length;
    final completedProjects = _projects.where((p) => p.isCompleted).length;
    final totalTeamMembers = _projects.fold<int>(
      0,
      (sum, p) => sum + p.teamSize,
    );

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Projects',
            '$totalProjects',
            Icons.folder_outlined,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Completed',
            '$completedProjects',
            Icons.check_circle_outline,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'members',
            '$totalTeamMembers',
            Icons.people_outline,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(ProjectData project) {
    final overallProgress = project.calculateOverallProgress();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project name and meta information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'Deadline: ${project.deadline}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.people, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${project.teamSize} members',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getProgressColor(
                    overallProgress,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(overallProgress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getProgressColor(overallProgress),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Progress bar
          AnimatedRangeBar(
            ranges: project.phases
                .map((phase) => _buildPhaseRangeData(phase))
                .toList(),
            height: 24,
            borderRadius: BorderRadius.circular(12),
            backgroundColor: Colors.grey[100],
            showLabels: true,
            showStartValueLabels: false,
            showEndValueLabels: false,
            labelPosition: LabelPosition.above,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
            staggerDelay: const Duration(milliseconds: 100),
            rangeBorderRadius: BorderRadius.zero,
            onRangeTap: (range) {
              _showPhaseDetails(
                context,
                project.phases.firstWhere((phase) => phase.name == range.label),
              );
            },
          ),

          const SizedBox(height: 16),

          // Phase details
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.phases
                .map((phase) => _buildPhaseChip(phase))
                .toList(),
          ),
        ],
      ),
    );
  }

  RangeData _buildPhaseRangeData(PhaseData phase) {
    if (phase.isCompleted) {
      return RangeData(
        startPosition: phase.startPosition,
        endPosition: phase.endPosition,
        color: phase.color,
        label: phase.name,
      );
    } else if (phase.currentProgress != null) {
      // In-progress phase
      return RangeData(
        startPosition: phase.startPosition,
        endPosition: phase.currentProgress!,
        color: phase.color,
        label: phase.name,
      );
    } else {
      // Not started phase
      return RangeData(
        startPosition: phase.startPosition,
        endPosition: phase.startPosition, // Zero width to hide
        color: phase.color.withValues(alpha: 0.3),
        label: phase.name,
      );
    }
  }

  Widget _buildPhaseChip(PhaseData phase) {
    IconData icon;
    Color color;

    if (phase.isCompleted) {
      icon = Icons.check_circle;
      color = Colors.green;
    } else if (phase.currentProgress != null) {
      icon = Icons.play_circle_filled;
      color = Colors.orange;
    } else {
      icon = Icons.radio_button_unchecked;
      color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            phase.name,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.8) return Colors.green;
    if (progress >= 0.5) return Colors.orange;
    return Colors.red;
  }

  void _showPhaseDetails(BuildContext context, PhaseData phase) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(phase.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: ${phase.isCompleted
                  ? "Completed"
                  : phase.currentProgress != null
                  ? "In Progress"
                  : "Not Started"}',
            ),
            if (phase.currentProgress != null && !phase.isCompleted)
              Text('Progress: ${(phase.currentProgress! * 100).toInt()}%'),
            const SizedBox(height: 8),
            Text(
              'Duration: ${(phase.startPosition * 100).toInt()}% - ${(phase.endPosition * 100).toInt()}%',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Data models
class ProjectData {
  final String name;
  final List<PhaseData> phases;
  final String deadline;
  final int teamSize;

  ProjectData({
    required this.name,
    required this.phases,
    required this.deadline,
    required this.teamSize,
  });

  bool get isCompleted => phases.every((phase) => phase.isCompleted);

  double calculateOverallProgress() {
    double totalProgress = 0;
    for (final phase in phases) {
      if (phase.isCompleted) {
        totalProgress += (phase.endPosition - phase.startPosition);
      } else if (phase.currentProgress != null) {
        totalProgress += (phase.currentProgress! - phase.startPosition);
      }
    }
    return totalProgress;
  }
}

class PhaseData {
  final String name;
  final double startPosition;
  final double endPosition;
  final Color color;
  final bool isCompleted;
  final double? currentProgress;

  PhaseData(
    this.name,
    this.startPosition,
    this.endPosition,
    this.color, {
    this.isCompleted = false,
    this.currentProgress,
  });
}
