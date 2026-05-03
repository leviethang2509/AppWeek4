import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  final List<Map<String, String>> contacts = const [
    {'name': 'Nguyen Van An', 'phone': '0901 111 111'},
    {'name': 'Tran Minh Binh', 'phone': '0902 222 222'},
    {'name': 'Le Hoang Cuong', 'phone': '0903 333 333'},
    {'name': 'Pham Gia Huy', 'phone': '0904 444 444'},
    {'name': 'Vo Thanh Long', 'phone': '0905 555 555'},
    {'name': 'Dang Quoc Bao', 'phone': '0906 666 666'},
    {'name': 'Bui Anh Khoa', 'phone': '0907 777 777'},
    {'name': 'Huynh Nhat Nam', 'phone': '0908 888 888'},
    {'name': 'Mai Phuong Linh', 'phone': '0909 999 999'},
    {'name': 'Do Ngoc Ha', 'phone': '0910 101 010'},
    {'name': 'Ngo Thanh Tung', 'phone': '0911 111 222'},
    {'name': 'Phan Duc Manh', 'phone': '0912 222 333'},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: _metric(
                  icon: Icons.people_alt_outlined,
                  label: 'Contacts',
                  value: '${contacts.length}',
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metric(
                  icon: Icons.phone_in_talk_outlined,
                  label: 'Action',
                  value: 'Call',
                  color: const Color(0xFF059669),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              final initials = contact['name']!
                  .split(' ')
                  .where((part) => part.isNotEmpty)
                  .take(2)
                  .map((part) => part[0])
                  .join();

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  minVerticalPadding: 14,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.secondaryContainer,
                    foregroundColor: colorScheme.onSecondaryContainer,
                    child: Text(
                      initials,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  title: Text(
                    contact['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(contact['phone']!),
                  ),
                  trailing: IconButton.filledTonal(
                    icon: const Icon(Icons.call_rounded),
                    tooltip: 'Call',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Calling ${contact['name']}...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _metric({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
