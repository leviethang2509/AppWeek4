import 'package:flutter/material.dart';

class AsyncScreen extends StatefulWidget {
  const AsyncScreen({super.key});

  @override
  State<AsyncScreen> createState() => _AsyncScreenState();
}

class _AsyncScreenState extends State<AsyncScreen> {
  bool isLoading = false;
  String message = 'Press the button to load user.';

  Future<void> loadUser() async {
    setState(() {
      isLoading = true;
      message = 'Loading user data...';
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isLoading = false;
      message = 'Data loaded successfully!';
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      _stateIcon(colorScheme),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'User request',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isLoading ? 'In progress' : 'Completed',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: isLoading
                        ? LinearProgressIndicator(
                            key: const ValueKey('loading'),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : Container(
                            key: const ValueKey('done'),
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isLoading
                        ? 'Fetching resources from server...'
                        : 'All async tasks are completed.',
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: isLoading ? null : loadUser,
                    icon: const Icon(Icons.sync_rounded),
                    label: const Text('Reload data'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _stateIcon(ColorScheme colorScheme) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: Container(
        key: ValueKey(isLoading),
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: isLoading
              ? colorScheme.primaryContainer
              : const Color(0xFFDCFCE7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isLoading ? Icons.hourglass_top_rounded : Icons.check_rounded,
          color: isLoading
              ? colorScheme.onPrimaryContainer
              : const Color(0xFF15803D),
          size: 30,
        ),
      ),
    );
  }
}
