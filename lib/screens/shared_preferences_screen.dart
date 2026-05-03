import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreen extends StatefulWidget {
  const SharedPreferencesScreen({super.key});

  @override
  State<SharedPreferencesScreen> createState() =>
      _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState extends State<SharedPreferencesScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String result = 'No saved data yet.';

  Future<void> saveData() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty) {
      showMessage('Please enter your name');
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name);
    await prefs.setString('age', age);
    await prefs.setString('email', email);
    await prefs.setString('timestamp', DateTime.now().toString());

    setState(() {
      result = 'Data saved successfully!';
    });

    nameController.clear();
    ageController.clear();
    emailController.clear();

    showMessage('Saved successfully');
  }

  Future<void> showData() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('name');
    final age = prefs.getString('age') ?? '';
    final email = prefs.getString('email') ?? '';
    final timestamp = prefs.getString('timestamp') ?? '';

    if (name == null || name.isEmpty) {
      setState(() {
        result = 'No data available. Please save your name first.';
      });
      return;
    }

    setState(() {
      result = '''
Name: $name
Age: ${age.isEmpty ? 'Not provided' : age}
Email: ${email.isEmpty ? 'Not provided' : email}
Last saved: $timestamp
''';
    });
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('name');
    await prefs.remove('age');
    await prefs.remove('email');
    await prefs.remove('timestamp');

    setState(() {
      result = 'All saved data has been cleared.';
    });

    showMessage('Data cleared');
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _statusCard(context),
          const SizedBox(height: 14),
          _formCard(),
          const SizedBox(height: 14),
          _actions(context),
          const SizedBox(height: 14),
          _resultCard(context),
        ],
      ),
    );
  }

  Widget _statusCard(BuildContext context) {
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
                color: colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.storage_rounded,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Local profile',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Save, read, and clear local values.',
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

  Widget _formCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _inputField(
              controller: nameController,
              label: 'Enter your name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 12),
            _inputField(
              controller: ageController,
              label: 'Enter your age',
              icon: Icons.cake_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _inputField(
              controller: emailController,
              label: 'Enter your email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
      ),
    );
  }

  Widget _actions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: saveData,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Save'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: showData,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Show'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: clearData,
          icon: const Icon(Icons.delete_outline),
          label: const Text('Clear data'),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.error,
            side: BorderSide(color: colorScheme.error),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _resultCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
