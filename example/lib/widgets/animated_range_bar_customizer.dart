import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Animation settings customizer widget
class AnimatedRangeBarCustomizer extends StatefulWidget {
  const AnimatedRangeBarCustomizer({super.key});

  @override
  AnimatedRangeBarCustomizerState createState() =>
      AnimatedRangeBarCustomizerState();
}

class AnimatedRangeBarCustomizerState
    extends State<AnimatedRangeBarCustomizer> {
  // Animation settings
  double _durationMs = 800.0;
  double _staggerDelayMs = 150.0;
  double _initialDelayMs = 100.0;
  Curve _selectedCurve = Curves.easeInOut;

  // List of available curves
  final Map<String, Curve> _curves = {
    'linear': Curves.linear,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'easeInCubic': Curves.easeInCubic,
    'easeOutCubic': Curves.easeOutCubic,
    'easeInOutCubic': Curves.easeInOutCubic,
    'bounceIn': Curves.bounceIn,
    'bounceOut': Curves.bounceOut,
    'bounceInOut': Curves.bounceInOut,
    'elasticIn': Curves.elasticIn,
    'elasticOut': Curves.elasticOut,
    'elasticInOut': Curves.elasticInOut,
    'fastOutSlowIn': Curves.fastOutSlowIn,
    'slowMiddle': Curves.slowMiddle,
  };

  // Sample data
  final List<RangeData> _sampleRanges = [
    const RangeData(
      startPosition: 0.0,
      endPosition: 0.25,
      color: Colors.red,
      label: 'Q1',
      startValueLabel: '0%',
      endValueLabel: '25%',
    ),
    const RangeData(
      startPosition: 0.4,
      endPosition: 0.6,
      color: Colors.blue,
      label: 'Q2',
      startValueLabel: '40%',
      endValueLabel: '60%',
    ),
    const RangeData(
      startPosition: 0.75,
      endPosition: 1.0,
      color: Colors.green,
      label: 'Q3',
      startValueLabel: '75%',
      endValueLabel: '100%',
    ),
  ];

  // Key for restarting animation
  int _animationKey = 0;

  void _restartAnimation() {
    setState(() {
      _animationKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animation preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Animation Preview',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _restartAnimation,
                        icon: const Icon(Icons.replay, size: 18),
                        label: const Text('Play'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AnimatedRangeBar(
                    key: ValueKey(_animationKey),
                    ranges: _sampleRanges,
                    height: 30,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: Colors.white,
                    showLabels: true,
                    showStartValueLabels: true,
                    showEndValueLabels: true,
                    labelPosition: LabelPosition.above,
                    duration: Duration(milliseconds: _durationMs.round()),
                    curve: _selectedCurve,
                    staggerDelay: Duration(
                      milliseconds: _staggerDelayMs.round(),
                    ),
                    initialDelay: Duration(
                      milliseconds: _initialDelayMs.round(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings controls
            const Text(
              'Animation Settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Duration settings
            _buildSliderSetting(
              label: 'Duration (Animation Time)',
              value: _durationMs,
              min: 200,
              max: 3000,
              divisions: 28,
              unit: 'ms',
              onChanged: (value) {
                setState(() {
                  _durationMs = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // Stagger Delay settings
            _buildSliderSetting(
              label: 'Stagger Delay (Inter-range Delay)',
              value: _staggerDelayMs,
              min: 0,
              max: 500,
              divisions: 25,
              unit: 'ms',
              onChanged: (value) {
                setState(() {
                  _staggerDelayMs = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // Initial Delay settings
            _buildSliderSetting(
              label: 'Initial Delay (Start Delay)',
              value: _initialDelayMs,
              min: 0,
              max: 1000,
              divisions: 20,
              unit: 'ms',
              onChanged: (value) {
                setState(() {
                  _initialDelayMs = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Curve selection
            const Text(
              'Animation Curve',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Curve>(
                  value: _selectedCurve,
                  isExpanded: true,
                  items: _curves.entries.map((entry) {
                    return DropdownMenuItem<Curve>(
                      value: entry.value,
                      child: Text(entry.key),
                    );
                  }).toList(),
                  onChanged: (Curve? newCurve) {
                    if (newCurve != null) {
                      setState(() {
                        _selectedCurve = newCurve;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Settings display
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Settings:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Duration: ${_durationMs.round()}ms\n'
                    'Stagger Delay: ${_staggerDelayMs.round()}ms\n'
                    'Initial Delay: ${_initialDelayMs.round()}ms\n'
                    'Curve: ${_curves.entries.firstWhere((e) => e.value == _selectedCurve).key}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Implementation example section
            _buildImplementationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSetting({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String unit,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              '${value.round()}$unit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
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
            'AnimatedRangeBar implementation with current settings:',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _generateDetailedCodeSample(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: colorScheme.onSecondaryContainer.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Usage Example:',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _generateUsageExample(),
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

  String _generateDetailedCodeSample() {
    final curveName = _curves.entries
        .firstWhere((e) => e.value == _selectedCurve)
        .key;
    return '''// AnimatedRangeBar configuration
AnimatedRangeBar(
  ranges: [
    RangeData(
      startPosition: 0.1,
      endPosition: 0.4,
      color: Colors.blue,
      label: 'Task A',
      startValueLabel: '10%',
      endValueLabel: '40%',
    ),
    RangeData(
      startPosition: 0.5,
      endPosition: 0.8,
      color: Colors.green,
      label: 'Task B',
      startValueLabel: '50%',
      endValueLabel: '80%',
    ),
  ],
  duration: Duration(milliseconds: ${_durationMs.round()}),
  curve: Curves.$curveName,
  staggerDelay: Duration(milliseconds: ${_staggerDelayMs.round()}),
  initialDelay: Duration(milliseconds: ${_initialDelayMs.round()}),
  height: 30,
  showLabels: true,
  showStartValueLabels: true,
  showEndValueLabels: true,
  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
)''';
  }

  String _generateUsageExample() {
    return '''// Project progress visualization example
class ProjectProgressWidget extends StatefulWidget {
  @override
  _ProjectProgressWidgetState createState() => _ProjectProgressWidgetState();
}

class _ProjectProgressWidgetState extends State<ProjectProgressWidget> {
  List<RangeData> _projectRanges = [];

  void _updateProgress() {
    setState(() {
      _projectRanges = [
        RangeData(
          startPosition: 0.0,
          endPosition: 0.3,
          color: Colors.blue,
          label: 'Design Phase',
        ),
        RangeData(
          startPosition: 0.3,
          endPosition: 0.7,
          color: Colors.orange,
          label: 'Development Phase',
        ),
        RangeData(
          startPosition: 0.7,
          endPosition: 1.0,
          color: Colors.green,
          label: 'Testing Phase',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedRangeBar(
          ranges: _projectRanges,
          duration: Duration(milliseconds: ${_durationMs.round()}),
          curve: Curves.${_curves.entries.firstWhere((e) => e.value == _selectedCurve).key},
          staggerDelay: Duration(milliseconds: ${_staggerDelayMs.round()}),
        ),
        ElevatedButton(
          onPressed: _updateProgress,
          child: Text('Update Progress'),
        ),
      ],
    );
  }
}''';
  }
}
