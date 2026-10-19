import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/widgets.dart';
import '../../data/competition.dart';
import '../../../auth/application/auth_providers.dart';

/// Paid entry is collected with M-Pesa, which only serves Kenya, so paid
/// competitions are open to players in Kenya alone. This marks them for
/// everyone else, before they tap in; the server's eligibility check stays
/// the authority.
class KenyaOnlyBadge extends ConsumerWidget {
  const KenyaOnlyBadge({super.key, required this.competition});

  final Competition competition;

  static bool appliesTo(Competition competition, String? countryCode) =>
      competition.isPaid && countryCode != null && countryCode != 'KE';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(currentPlayerProvider)?.countryCode;
    if (!appliesTo(competition, country)) return const SizedBox.shrink();
    return const StatusBadge('Kenya only', tone: StatusTone.muted);
  }
}
