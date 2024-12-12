import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () async {},
    );
  }
}
