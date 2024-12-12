import 'package:flutter/material.dart';
import 'package:personal_finance/widgets/profile_option.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.appBarTheme.foregroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ProfileCard(
              name: 'John Doe',
              email: 'johndoe@example.com',
              avatarUrl: null,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ProfileOption(
                    icon: Icons.security,
                    title: 'Security Settings',
                  ),
                  ProfileOption(
                    icon: Icons.notifications,
                    title: 'Notifications',
                  ),
                  ProfileOption(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Logout'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
