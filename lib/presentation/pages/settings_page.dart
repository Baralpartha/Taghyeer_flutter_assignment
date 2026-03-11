import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../cubits/theme/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(
        body: Center(child: Text('User not available')),
      );
    }

    final user = authState.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
              title: Text(user.fullName),
              subtitle: Text('${user.username}\n${user.email}'),
              isThreeLine: true,
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            value: isDark,
            title: const Text('Dark Mode'),
            onChanged: (value) {
              context.read<ThemeCubit>().toggleTheme(value);
            },
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: () => context.read<AuthCubit>().logout(),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}