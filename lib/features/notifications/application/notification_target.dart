import '../data/app_notification.dart';

/// Where tapping an inbox item leads.
sealed class NotificationTarget {
  const NotificationTarget();

  /// Picks the screen from the item's kind and ids, then its category, as
  /// the API asks; [actionUrl] is only a hint. Anything without a screen
  /// in the app yet (payments, refunds, conduct strikes) shows the item.
  factory NotificationTarget.of(AppNotification n) {
    final kind = n.kind;
    final match = n.matchId;
    final competition = n.competitionId;
    if (kind == 'match.chat_message' && match != null) {
      return OpenMatchChat(match);
    }
    // Match and result events, and the removal, which names its match.
    if ((kind.startsWith('match.') ||
            kind.startsWith('result.') ||
            kind == 'competition.entry_removed') &&
        match != null) {
      return OpenMatch(match);
    }
    if ((kind.startsWith('competition.') || kind == 'draw_generated') &&
        competition != null) {
      return OpenCompetition(competition);
    }
    // Unknown or legacy kinds: by category and the ids there are.
    return switch (n.category) {
      NotificationCategory.match ||
      NotificationCategory.result when match != null => OpenMatch(match),
      NotificationCategory.competition when competition != null =>
        OpenCompetition(competition),
      _ => const ShowDetails(),
    };
  }
}

class OpenMatch extends NotificationTarget {
  const OpenMatch(this.matchId);

  final String matchId;
}

/// A new message in a match's chat.
class OpenMatchChat extends NotificationTarget {
  const OpenMatchChat(this.matchId);

  final String matchId;
}

class OpenCompetition extends NotificationTarget {
  const OpenCompetition(this.competitionId);

  final String competitionId;
}

/// The item itself, in full.
class ShowDetails extends NotificationTarget {
  const ShowDetails();
}
