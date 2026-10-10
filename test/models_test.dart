import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/api/cursor_page.dart';
import 'package:tonits/features/competitions/data/competition.dart';
import 'package:tonits/features/matches/data/match_summary.dart';
import 'package:tonits/features/players/application/player_stats.dart';
import 'package:tonits/features/players/application/players_providers.dart';
import 'package:tonits/features/players/data/played_match.dart';
import 'package:tonits/features/players/data/player_profile.dart';
import 'package:tonits/features/rankings/data/ranked_player.dart';

import 'support/fakes.dart';

void main() {
  test('parses a competition page', () {
    final page = CursorPage.fromJson({
      'data': [competitionJson(entryType: 'paid', entryFeeMinor: 10000)],
      'page': {'nextCursor': 'abc', 'hasMore': true},
    }, Competition.fromJson);

    final c = page.items.single;
    expect(page.nextCursor, 'abc');
    expect(page.hasMore, isTrue);
    expect(c.status, CompetitionStatus.registrationOpen);
    expect(c.format, CompetitionFormat.singleElimination);
    expect(c.entryType, EntryType.paid);
    expect(c.entryFeeMinor, 10000);
    expect(c.startsAt, DateTime.utc(2026, 10, 14, 16));
  });

  test('unknown enum values do not break parsing', () {
    final c = Competition.fromJson({
      ...competitionJson(),
      'status': 'something_new',
      'format': 'swiss',
    });
    expect(c.status, CompetitionStatus.unknown);
    expect(c.format, CompetitionFormat.unknown);
  });

  test('status filters use the wire values', () {
    expect(CompetitionStatus.registrationOpen.wire, 'registration_open');
    expect(CompetitionStatus.running.wire, 'running');
  });

  test('a match knows the opponent from the player side', () {
    final m = MatchSummary.fromJson(matchJson());
    expect(m.lifecycle, MatchLifecycle.readyForCheckIn);
    expect(m.opponent!.displayName, 'Amina Otieno');
    expect(m.allowedActions, {'check_in'});

    final away = MatchSummary.fromJson({
      ...matchJson(),
      'currentPlayerSide': 'away',
    });
    expect(away.opponent!.displayName, 'striker.9');
  });

  test('a match waiting for an earlier round has no opponent yet', () {
    final m = MatchSummary.fromJson({...matchJson(), 'away': null});
    expect(m.opponent, isNull);
  });

  test('lifecycle and outcome parse from snake_case', () {
    expect(
      MatchLifecycle.parse('awaiting_opponent_confirmation'),
      MatchLifecycle.awaitingOpponentConfirmation,
    );
    expect(MatchLifecycle.parse('new_state'), MatchLifecycle.unknown);
    expect(MatchOutcome.parse('no_result'), MatchOutcome.noResult);
    expect(MatchOutcome.parse(null), isNull);
  });

  test('a provisional ranked player has no rank or rating', () {
    final p = RankedPlayer.fromJson({
      ...rankedJson(1, 'New Player'),
      'rank': null,
      'rating': null,
      'rankMovement': null,
    });
    expect(p.rank, isNull);
    expect(p.rating, isNull);
  });

  test('a profile reads the eFootball rating and record', () {
    final p = PlayerProfile.fromJson(profileJson());
    expect(p.rating!.rating, 1542);
    expect(p.rating!.countryRank, 24);
    expect(p.record.winRate, closeTo(13 / 21, 1e-9));
    expect(PlayerProfile.fromJson(profileJson(rated: false)).rating, isNull);
  });

  test('stats derive goals per match and the current streak', () {
    final recent = recentJson().map(PlayedMatch.fromJson).toList();
    final stats = PlayerStats.from(
      PlayerProfile.fromJson(profileJson()).record,
      recent,
    );
    expect(stats.goalsPerMatch, closeTo(15 / 6, 1e-9));
    expect(stats.goalsSample, 6);
    expect(stats.streak, (MatchResult.win, 3));
  });

  test('no matches means no goals or streak', () {
    final stats = PlayerStats.from(
      const Record(matchesPlayed: 0, wins: 0, draws: 0, losses: 0),
      const [],
    );
    expect(stats.goalsPerMatch, isNull);
    expect(stats.streak, isNull);
    expect(stats.record.winRate, isNull);
  });

  group('rank neighbourhood', () {
    final ladder = ladderJson().map(RankedPlayer.fromJson).toList();

    test('shows two either side of the player', () {
      final rows = neighbourhood(ladder, myPlayerId);
      expect(rows.map((r) => r.rank), [22, 23, 24, 25, 26]);
    });

    test('clips at the top of the ladder', () {
      final rows = neighbourhood(ladder, ladder.first.playerId);
      expect(rows.map((r) => r.rank), [21, 22, 23]);
    });

    test('falls back to the top three when the player is not listed', () {
      final rows = neighbourhood(ladder, 'someone-else');
      expect(rows.map((r) => r.rank), [21, 22, 23]);
    });
  });
}
