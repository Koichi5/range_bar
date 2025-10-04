import 'package:flutter/material.dart';

// Widgets
import '../widgets/basic_range_bar_samples.dart';
import '../widgets/advanced_range_bar_samples.dart';

// Demos
import '../demos/animated_range_bar_demo.dart';
import '../demos/overlap_test_demo.dart';

// Screens
import 'animation_customizer_screen.dart';
import 'project_management_screen.dart';
import 'sales_dashboard_screen.dart';
import 'resource_monitor_screen.dart';
import 'value_range_demo_screen.dart';

/// Detailed sample list screen for RangeBar
class SamplesScreen extends StatelessWidget {
  const SamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Range Bar Sample List')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Partial range specification demo (most important feature)
              _NavigationCard(
                title: 'Partial Range Specification (Important!)',
                description:
                    'How to display a portion of the overall range in Gantt chart style',
                icon: Icons.straighten,
                destination: ValueRangeDemoScreen(),
                isHighlighted: true,
              ),
              SizedBox(height: 16),

              // Basic samples
              _SectionHeader(
                title: 'Basic Usage Examples',
                description:
                    'Basic functionality and styling options for RangeBar',
                icon: Icons.bar_chart,
              ),
              SizedBox(height: 16),
              BasicRangeBarSamples(),
              SizedBox(height: 32),

              // Advanced samples
              _SectionHeader(
                title: 'Advanced Features',
                description:
                    'Advanced features such as tooltips, accessibility, and point data',
                icon: Icons.settings,
              ),
              SizedBox(height: 16),
              AdvancedRangeBarSamples(),
              SizedBox(height: 32),

              // Animation features
              _SectionHeader(
                title: 'Animated RangeBar',
                description:
                    'Animation that extends sequentially from left to right. With delays based on distance between ranges.',
                icon: Icons.animation,
              ),
              SizedBox(height: 16),
              AnimatedRangeBarDemo(),
              SizedBox(height: 32),

              // Animation customizer
              _NavigationCard(
                title: 'Animation Settings Customizer',
                description:
                    'Customize animations by freely adjusting Duration, Curve, and delay times',
                icon: Icons.tune,
                destination: AnimationCustomizerScreen(),
              ),
              SizedBox(height: 16),

              // Practical use cases
              _SectionHeader(
                title: 'Practical Use Cases',
                description: 'Experience real-world application usage examples',
                icon: Icons.apps,
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _UseCaseCard(
                      title: 'Project Progress Management',
                      description: 'Visualize task progress with animations',
                      icon: Icons.assignment,
                      color: Colors.blue,
                      destination: ProjectManagementScreen(),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _UseCaseCard(
                      title: 'Sales Analysis Dashboard',
                      description: 'Display quarterly sales and regional data',
                      icon: Icons.analytics,
                      color: Colors.green,
                      destination: SalesDashboardScreen(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _UseCaseCard(
                      title: 'Resource Monitoring',
                      description:
                          'Real-time monitoring of server CPU and memory usage',
                      icon: Icons.monitor,
                      color: Colors.orange,
                      destination: ResourceMonitorScreen(),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _UseCaseCard(
                      title: 'Customizer',
                      description:
                          'Detailed customization of animation settings',
                      icon: Icons.tune,
                      color: Colors.purple,
                      destination: AnimationCustomizerScreen(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // Developer tests
              _SectionHeader(
                title: 'Developer Tests',
                description:
                    'Tests for overlap validation and error handling (errors occur in debug mode)',
                icon: Icons.bug_report,
              ),
              SizedBox(height: 16),
              OverlapTestDemo(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

/// Section header widget
class _SectionHeader extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.tertiary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.tertiary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: colorScheme.tertiary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onTertiaryContainer.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Card with navigation
class _NavigationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Widget destination;
  final bool isHighlighted;

  const _NavigationCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.destination,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHighlighted
              ? colorScheme.secondaryContainer
              : colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHighlighted
                ? colorScheme.secondary
                : colorScheme.primary.withValues(alpha: 0.3),
            width: isHighlighted ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isHighlighted
                    ? colorScheme.secondary.withValues(alpha: 0.2)
                    : colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isHighlighted
                    ? colorScheme.secondary
                    : colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isHighlighted
                          ? colorScheme.onSecondaryContainer
                          : colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isHighlighted
                          ? colorScheme.onSecondaryContainer.withValues(
                              alpha: 0.8,
                            )
                          : colorScheme.onPrimaryContainer.withValues(
                              alpha: 0.8,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isHighlighted
                  ? colorScheme.secondary
                  : colorScheme.primary.withValues(alpha: 0.6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/// Use case card
class _UseCaseCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Widget destination;

  const _UseCaseCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: color.withValues(alpha: 0.8),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.arrow_forward, color: color, size: 16)],
            ),
          ],
        ),
      ),
    );
  }
}
