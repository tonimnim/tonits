import 'package:flutter/material.dart';

import '../../core/countries.dart';
import '../../core/theme.dart';
import '../auth/auth_scope.dart';

/// Placeholder for the signed-in app until the main tabs exist.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthScope.of(context);
    final player = auth.player!;
    final country = Country.byCode(player.countryCode);
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TONITS',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          TextButton(
            onPressed: () => AuthScope.read(context).signOut(),
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          if (auth.pendingCountryCode != null)
            Card(
              color: TonitsColors.panel,
              child: ListTile(
                title: const Text("Your country wasn't saved"),
                trailing: TextButton(
                  onPressed: () => AuthScope.read(context).savePendingCountry(),
                  child: const Text('Retry'),
                ),
              ),
            ),
          Text(
            'Welcome,\n${player.displayName}'.toUpperCase(),
            style: text.displaySmall,
          ),
          const SizedBox(height: 24),
          _Detail('Konami ID', player.konamiId ?? '—'),
          _Detail(
            'Country',
            country == null
                ? player.countryCode
                : '${country.flag}  ${country.name}',
          ),
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(color: TonitsColors.muted),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
