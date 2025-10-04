import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Use case for sales analysis dashboard screen
class SalesDashboardScreen extends StatefulWidget {
  const SalesDashboardScreen({super.key});

  @override
  SalesDashboardScreenState createState() => SalesDashboardScreenState();
}

class SalesDashboardScreenState extends State<SalesDashboardScreen> {
  // Sales data (FY 2024)
  final SalesData _salesData = SalesData(
    quarters: [
      QuarterData('Q1', 0.0, 0.22, Colors.blue, 2200, 2000, 'YoY +10%'),
      QuarterData('Q2', 0.22, 0.48, Colors.green, 2600, 2300, 'YoY +13%'),
      QuarterData('Q3', 0.48, 0.75, Colors.orange, 2700, 2500, 'YoY +8%'),
      QuarterData('Q4', 0.75, 1.0, Colors.purple, 2500, 2200, 'YoY +14%'),
    ],
    totalSales: 10000,
    targetSales: 9000,
    regions: [
      RegionData('Tokyo', 0.0, 0.35, Colors.red, 3500),
      RegionData('Osaka', 0.35, 0.6, Colors.blue, 2500),
      RegionData('Nagoya', 0.6, 0.8, Colors.green, 2000),
      RegionData('Others', 0.8, 1.0, Colors.grey, 2000),
    ],
    products: [
      ProductData('Product A', 0.0, 0.4, Colors.indigo, 4000, 'Best Seller'),
      ProductData('Product B', 0.4, 0.7, Colors.teal, 3000, 'Growing'),
      ProductData('Product C', 0.7, 0.9, Colors.amber, 2000, 'Stable'),
      ProductData('Product D', 0.9, 1.0, Colors.pink, 1000, 'New Product'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quarterly sales
            _buildQuarterlySales(_salesData),
            const SizedBox(height: 24),

            // Regional sales
            _buildRegionalSales(_salesData),
            const SizedBox(height: 24),

            // Product sales
            _buildProductSales(_salesData),
          ],
        ),
      ),
    );
  }

  Widget _buildQuarterlySales(SalesData data) {
    return _buildSectionCard(
      title: 'Quarterly Sales Trends',
      icon: Icons.timeline,
      child: Column(
        children: [
          AnimatedRangeBar(
            ranges: data.quarters
                .map(
                  (quarter) => RangeData(
                    startPosition: quarter.startPosition,
                    endPosition: quarter.endPosition,
                    color: quarter.color,
                    label: quarter.name,
                    startValueLabel:
                        '¥${_formatNumber((quarter.sales * quarter.startPosition).toInt())}M',
                    endValueLabel: '¥${_formatNumber(quarter.sales)}M',
                    tooltip:
                        '${quarter.name}: ¥${_formatNumber(quarter.sales)}M\n${quarter.comparison}',
                  ),
                )
                .toList(),
            height: 32,
            borderRadius: BorderRadius.circular(16),
            backgroundColor: Colors.grey[100],
            showLabels: true,
            showStartValueLabels: false,
            showEndValueLabels: true,
            showTooltip: true,
            labelPosition: LabelPosition.above,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
            staggerDelay: const Duration(milliseconds: 150),
            rangeBorderRadius: BorderRadius.zero,

            onRangeTap: (range) {
              _showQuarterDetails(
                context,
                data.quarters.firstWhere((q) => q.name == range.label),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: data.quarters
                .map(
                  (quarter) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: quarter.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            quarter.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: quarter.color,
                            ),
                          ),
                          Text(
                            '¥${_formatNumber(quarter.sales)}M',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: quarter.color,
                            ),
                          ),
                          Text(
                            quarter.comparison,
                            style: TextStyle(
                              fontSize: 10,
                              color: quarter.color.withValues(alpha: 0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalSales(SalesData data) {
    return _buildSectionCard(
      title: 'Regional Sales Distribution',
      icon: Icons.location_on,
      child: Column(
        children: [
          RangeBar(
            ranges: data.regions
                .map(
                  (region) => RangeData(
                    startPosition: region.startPosition,
                    endPosition: region.endPosition,
                    color: region.color,
                    label: region.name,
                    startValueLabel:
                        '¥${_formatNumber((region.sales * region.startPosition).toInt())}M',
                    endValueLabel: '¥${_formatNumber(region.sales)}M',
                    tooltip: '${region.name}: ¥${_formatNumber(region.sales)}M',
                  ),
                )
                .toList(),
            height: 28,
            borderRadius: BorderRadius.circular(14),
            backgroundColor: Colors.grey[100],
            showLabels: true,
            showStartValueLabels: false,
            showEndValueLabels: true,
            showTooltip: true,
            labelPosition: LabelPosition.below,
            rangeBorderRadius: BorderRadius.zero,
            onRangeTap: (range) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Display detailed data for ${range.label}'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: data.regions
                .map(
                  (region) => Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: region.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(region.name, style: const TextStyle(fontSize: 12)),
                      Text(
                        '${((region.endPosition - region.startPosition) * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSales(SalesData data) {
    return _buildSectionCard(
      title: 'Product Sales Composition',
      icon: Icons.inventory,
      child: Column(
        children: [
          AnimatedRangeBar(
            ranges: data.products
                .map(
                  (product) => RangeData(
                    startPosition: product.startPosition,
                    endPosition: product.endPosition,
                    color: product.color,
                    label: product.name,
                    endValueLabel: '¥${_formatNumber(product.sales)}M',
                    tooltip:
                        '${product.name}: ¥${_formatNumber(product.sales)}M\nStatus: ${product.status}',
                  ),
                )
                .toList(),
            height: 28,
            borderRadius: BorderRadius.circular(14),
            backgroundColor: Colors.grey[100],
            showLabels: true,
            showStartValueLabels: false,
            showEndValueLabels: true,
            showTooltip: true,
            labelPosition: LabelPosition.above,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
            staggerDelay: const Duration(milliseconds: 100),
            rangeBorderRadius: BorderRadius.zero,
          ),
          const SizedBox(height: 16),
          ...data.products.map(
            (product) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: product.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: product.color.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: product.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '¥${_formatNumber(product.sales)}M',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: product.color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: product.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.status,
                      style: TextStyle(
                        fontSize: 10,
                        color: product.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
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
          Row(
            children: [
              Icon(icon, color: Colors.deepPurple[700], size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _showQuarterDetails(BuildContext context, QuarterData quarter) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${quarter.name} Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sales Performance: ¥${_formatNumber(quarter.sales)}M'),
            Text('Target Sales: ¥${_formatNumber(quarter.target)}M'),
            Text(
              'Achievement Rate: ${(quarter.sales / quarter.target * 100).toInt()}%',
            ),
            const SizedBox(height: 8),
            Text(quarter.comparison),
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
class SalesData {
  final List<QuarterData> quarters;
  final int totalSales;
  final int targetSales;
  final List<RegionData> regions;
  final List<ProductData> products;

  SalesData({
    required this.quarters,
    required this.totalSales,
    required this.targetSales,
    required this.regions,
    required this.products,
  });
}

class QuarterData {
  final String name;
  final double startPosition;
  final double endPosition;
  final Color color;
  final int sales;
  final int target;
  final String comparison;

  QuarterData(
    this.name,
    this.startPosition,
    this.endPosition,
    this.color,
    this.sales,
    this.target,
    this.comparison,
  );
}

class RegionData {
  final String name;
  final double startPosition;
  final double endPosition;
  final Color color;
  final int sales;

  RegionData(
    this.name,
    this.startPosition,
    this.endPosition,
    this.color,
    this.sales,
  );
}

class ProductData {
  final String name;
  final double startPosition;
  final double endPosition;
  final Color color;
  final int sales;
  final String status;

  ProductData(
    this.name,
    this.startPosition,
    this.endPosition,
    this.color,
    this.sales,
    this.status,
  );
}
