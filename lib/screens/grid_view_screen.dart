import 'package:flutter/material.dart';

class GridViewScreen extends StatelessWidget {
  const GridViewScreen({super.key});

  final List<IconData> icons = const [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.star_rounded,
    Icons.music_note_rounded,
    Icons.camera_alt_rounded,
    Icons.flight_rounded,
    Icons.shopping_bag_rounded,
    Icons.sports_esports_rounded,
    Icons.pets_rounded,
    Icons.local_cafe_rounded,
    Icons.phone_android_rounded,
    Icons.lightbulb_rounded,
  ];

  final List<String> labels = const [
    'Home',
    'Love',
    'Star',
    'Music',
    'Camera',
    'Flight',
    'Shop',
    'Game',
    'Pet',
    'Coffee',
    'Phone',
    'Idea',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _overview(context),
          const SizedBox(height: 18),
          _sectionTitle(
            title: 'Fixed column grid',
            subtitle: 'GridView.count with 3 columns',
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            children: List.generate(12, _gridItem),
          ),
          const SizedBox(height: 24),
          _sectionTitle(
            title: 'Responsive grid',
            subtitle: 'GridView.extent with max width 150',
          ),
          const SizedBox(height: 10),
          GridView.extent(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.82,
            children: List.generate(12, _gridItem),
          ),
        ],
      ),
    );
  }

  Widget _overview(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.dashboard_customize_outlined,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gallery components',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Same data, two grid builders.',
                    style: TextStyle(color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _gridItem(int index) {
    final colors = const [
      Color(0xFF2563EB),
      Color(0xFFDB2777),
      Color(0xFFD97706),
      Color(0xFF0891B2),
      Color(0xFF059669),
      Color(0xFF4F46E5),
      Color(0xFF16A34A),
      Color(0xFFDC2626),
      Color(0xFF7C2D12),
      Color(0xFF0E7490),
      Color(0xFF475569),
      Color(0xFFEA580C),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icons[index],
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              labels[index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Item ${index + 1}',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
