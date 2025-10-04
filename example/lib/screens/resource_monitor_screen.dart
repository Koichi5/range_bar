import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Use case for resource usage monitoring screen
class ResourceMonitorScreen extends StatefulWidget {
  const ResourceMonitorScreen({super.key});

  @override
  ResourceMonitorScreenState createState() => ResourceMonitorScreenState();
}

class ResourceMonitorScreenState extends State<ResourceMonitorScreen> {
  Timer? _timer;
  final Random _random = Random();

  // Server data
  final List<ServerData> _servers = [
    ServerData(
      name: 'Web Server 01',
      status: ServerStatus.healthy,
      cpu: 45.0,
      memory: 62.0,
      disk: 78.0,
      network: 23.0,
    ),
    ServerData(
      name: 'Database Server',
      status: ServerStatus.warning,
      cpu: 78.0,
      memory: 85.0,
      disk: 45.0,
      network: 67.0,
    ),
    ServerData(
      name: 'API Server 01',
      status: ServerStatus.healthy,
      cpu: 32.0,
      memory: 48.0,
      disk: 56.0,
      network: 34.0,
    ),
    ServerData(
      name: 'Cache Server',
      status: ServerStatus.critical,
      cpu: 92.0,
      memory: 96.0,
      disk: 23.0,
      network: 89.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        for (var server in _servers) {
          // Update data in real-time (in actual apps, fetch from API)
          server.cpu = _updateValue(server.cpu);
          server.memory = _updateValue(server.memory);
          server.disk = _updateValue(server.disk);
          server.network = _updateValue(server.network);
          server.updateStatus();
        }
      });
    });
  }

  double _updateValue(double current) {
    final change = (_random.nextDouble() - 0.5) * 10; // -5 to +5
    final newValue = current + change;
    return newValue.clamp(0.0, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Server list
            const Text(
              'Monitoring',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ...(_servers.map((server) => _buildServerCard(server))),

            const SizedBox(height: 24),

            // Overall statistics
            _buildOverallStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildServerCard(ServerData server) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: server.status.color.withValues(alpha: 0.3),
          width: 2,
        ),
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
          // Server name and status
          Row(
            children: [
              Expanded(
                child: Text(
                  server.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: server.status.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: server.status.color.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      server.status.icon,
                      size: 16,
                      color: server.status.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      server.status.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: server.status.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Resource usage
          _buildResourceBar('CPU', server.cpu, Icons.memory, Colors.blue),
          const SizedBox(height: 12),
          _buildResourceBar(
            'Memory',
            server.memory,
            Icons.storage,
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildResourceBar('Disk', server.disk, Icons.storage, Colors.orange),
          const SizedBox(height: 12),
          _buildResourceBar(
            'Network',
            server.network,
            Icons.network_check,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildResourceBar(
    String label,
    double usage,
    IconData icon,
    Color baseColor,
  ) {
    final Color color = _getUsageColor(usage, baseColor);
    final double normalizedUsage = usage / 100.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              '${usage.toInt()}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedRangeBar(
          ranges: [
            RangeData(
              startPosition: 0.0,
              endPosition: normalizedUsage,
              color: color,
              label: label,
            ),
          ],
          height: 8,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.grey[200],
          showLabels: false,
          showStartValueLabels: false,
          showEndValueLabels: false,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
      ],
    );
  }

  Color _getUsageColor(double usage, Color baseColor) {
    if (usage >= 90) return Colors.red;
    if (usage >= 75) return Colors.orange;
    if (usage >= 50) return Colors.yellow[700]!;
    return baseColor;
  }

  Widget _buildOverallStats() {
    final avgCpu =
        _servers.fold<double>(0, (sum, s) => sum + s.cpu) / _servers.length;
    final avgMemory =
        _servers.fold<double>(0, (sum, s) => sum + s.memory) / _servers.length;
    final avgDisk =
        _servers.fold<double>(0, (sum, s) => sum + s.disk) / _servers.length;
    final avgNetwork =
        _servers.fold<double>(0, (sum, s) => sum + s.network) / _servers.length;

    return Container(
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
          const Row(
            children: [
              Icon(Icons.analytics, color: Colors.deepPurple, size: 24),
              SizedBox(width: 12),
              Text(
                'Overall Average Usage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),

          AnimatedRangeBar(
            ranges: [
              RangeData(
                startPosition: 0.0,
                endPosition: 0.25,
                color: Colors.blue,
                label: 'CPU',
                endValueLabel: '${avgCpu.toInt()}%',
              ),
              RangeData(
                startPosition: 0.25,
                endPosition: 0.5,
                color: Colors.green,
                label: 'Memory',
                endValueLabel: '${avgMemory.toInt()}%',
              ),
              RangeData(
                startPosition: 0.5,
                endPosition: 0.75,
                color: Colors.orange,
                label: 'Disk',
                endValueLabel: '${avgDisk.toInt()}%',
              ),
              RangeData(
                startPosition: 0.75,
                endPosition: 1.0,
                color: Colors.purple,
                label: 'Network',
                endValueLabel: '${avgNetwork.toInt()}%',
              ),
            ],
            height: 32,
            borderRadius: BorderRadius.circular(16),
            backgroundColor: Colors.grey[100],
            showLabels: true,
            showStartValueLabels: false,
            showEndValueLabels: true,
            labelPosition: LabelPosition.above,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
            staggerDelay: const Duration(milliseconds: 100),
            rangeBorderRadius: BorderRadius.zero,
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _buildAvgStat('CPU Avg', avgCpu, Colors.blue),
              _buildAvgStat('Memory Avg', avgMemory, Colors.green),
              _buildAvgStat('Disk Avg', avgDisk, Colors.orange),
              _buildAvgStat('Network Avg', avgNetwork, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvgStat(String label, double value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              '${value.toInt()}%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Data models
class ServerData {
  final String name;
  ServerStatus status;
  double cpu;
  double memory;
  double disk;
  double network;

  ServerData({
    required this.name,
    required this.status,
    required this.cpu,
    required this.memory,
    required this.disk,
    required this.network,
  });

  void updateStatus() {
    final maxUsage = [
      cpu,
      memory,
      disk,
      network,
    ].reduce((a, b) => a > b ? a : b);

    if (maxUsage >= 90) {
      status = ServerStatus.critical;
    } else if (maxUsage >= 75) {
      status = ServerStatus.warning;
    } else {
      status = ServerStatus.healthy;
    }
  }
}

enum ServerStatus {
  healthy('Healthy', Colors.green, Icons.check_circle),
  warning('Warning', Colors.orange, Icons.warning),
  critical('Critical', Colors.red, Icons.error);

  const ServerStatus(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;
}
