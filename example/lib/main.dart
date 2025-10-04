import 'package:flutter/material.dart';
import 'widgets/custom_drawer.dart';
import 'screens/range_bar_screen.dart';
import 'screens/animated_range_bar_screen.dart';
import 'screens/project_management_screen.dart';
import 'screens/sales_dashboard_screen.dart';
import 'screens/resource_monitor_screen.dart';
import 'screens/value_range_demo_screen.dart';
import 'screens/animation_customizer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Range Bar Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RangeBarDemo(),
    );
  }
}

class RangeBarDemo extends StatefulWidget {
  const RangeBarDemo({super.key});

  @override
  State<RangeBarDemo> createState() => _RangeBarDemoState();
}

class _RangeBarDemoState extends State<RangeBarDemo> {
  String _currentPage = 'range_bar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_getPageTitle()), elevation: 0),
      drawer: CustomDrawer(
        currentPage: _currentPage,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
      body: _buildCurrentPage(),
    );
  }

  String _getPageTitle() {
    switch (_currentPage) {
      case 'range_bar':
        return 'RangeBar';
      case 'animated_range_bar':
        return 'AnimatedRangeBar';
      case 'project_management':
        return 'Project Management';
      case 'sales_dashboard':
        return 'Sales Dashboard';
      case 'resource_monitor':
        return 'Resource Monitor';
      case 'value_range_demo':
        return 'Gantt Chart';
      case 'animation_customizer':
        return 'Animation Settings';
      default:
        return 'Range Bar Demo';
    }
  }

  Widget _buildCurrentPage() {
    switch (_currentPage) {
      case 'range_bar':
        return const RangeBarScreen();
      case 'animated_range_bar':
        return const AnimatedRangeBarScreen();
      case 'project_management':
        return const ProjectManagementScreen();
      case 'sales_dashboard':
        return const SalesDashboardScreen();
      case 'resource_monitor':
        return const ResourceMonitorScreen();
      case 'value_range_demo':
        return const ValueRangeDemoScreen();
      case 'animation_customizer':
        return const AnimationCustomizerScreen();
      default:
        return const RangeBarScreen();
    }
  }
}
