import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'user_detail_screen.dart';

const int matricLastDigit = 5;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _service = UserService();

  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _service.fetchUsers();
  }

  // Sends a new API request when the Retry button is pressed.
  void _retry() {
    debugPrint('Retry button pressed. Fetching users again...');

    setState(() {
      _usersFuture = _service.fetchUsers();
    });
  }

  // Allows users to refresh the list by pulling down.
  Future<void> _refreshUsers() async {
    _retry();

    try {
      await _usersFuture;
    } catch (error) {
      debugPrint('Refresh failed: $error');
      // FutureBuilder will display the error screen.
    }
  }

  // Determines the extra field based on the matric number.
  String _extraField(User user) {
    if (matricLastDigit <= 3) {
      return 'Company: ${user.company.name}';
    }

    if (matricLastDigit <= 6) {
      return 'City: ${user.address.city}';
    }

    return 'Website: ${user.website}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Directory')),

      body: FutureBuilder<List<User>>(
        future: _usersFuture,

        builder: (context, snapshot) {
          // 1. Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading users...', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }

          // 2. Error state
          if (snapshot.hasError) {
            debugPrint('API Error: ${snapshot.error}');

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.wifi_off_rounded,
                      size: 64,
                      color: Colors.redAccent,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Could not load users',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Unable to retrieve user information. '
                      'Please check your internet connection and try again.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                    const SizedBox(height: 12),

                    // Display the actual error for debugging.
                    Text(
                      'Error details: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),

                    const SizedBox(height: 24),

                    FilledButton.icon(
                      onPressed: _retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Successful response
          final users = snapshot.data ?? [];

          if (users.isEmpty) {
            return const Center(child: Text('No users available.'));
          }

          // 4. Display the user list
          return RefreshIndicator(
            onRefresh: _refreshUsers,

            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: users.length,

              itemBuilder: (context, index) {
                final user = users[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),

                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),

                    leading: CircleAvatar(
                      child: Text(
                        user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                      ),
                    ),

                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),

                        Text(user.email),

                        const SizedBox(height: 4),

                        Text(_extraField(user)),
                      ],
                    ),

                    trailing: const Icon(Icons.chevron_right),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailScreen(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
