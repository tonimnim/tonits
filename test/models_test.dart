import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tonits/core/api/cursor_page.dart';
import 'package:tonits/features/auth/data/models.dart';
import 'package:tonits/features/competitions/data/competition.dart';
import 'package:tonits/features/matches/data/match_summary.dart';
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
    expect(c.startsAt, DateTime.utc(2027, 1, 14, 16));
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
    MatchSummary parse(String lifecycle, String? outcome) =>
        MatchSummary.fromJson({
          ...matchJson(),
          'lifecycle': lifecycle,
          'outcome': outcome,
        });
    final m = parse('awaiting_opponent_confirmation', 'no_result');
    expect(m.lifecycle, MatchLifecycle.awaitingOpponentConfirmation);
    expect(m.outcome, MatchOutcome.noResult);
  });

  test('values the app does not know yet fall back instead of failing', () {
    final m = MatchSummary.fromJson({
      ...matchJson(),
      'lifecycle': 'a_new_state',
      'outcome': 'a_new_outcome',
    });
    expect(m.lifecycle, MatchLifecycle.unknown);
    expect(m.outcome, isNull);
  });

  test('a field the contract requires names itself when missing', () {
    expect(
      () => MatchSummary.fromJson({...matchJson()}..remove('roundName')),
      throwsA(
        isA<CheckedFromJsonException>().having(
          (e) => e.key,
          'key',
          'roundName',
        ),
      ),
    );
  });

  test('a provisional ranked player has no rank, rating or level', () {
    final p = RankedPlayer.fromJson({
      ...rankedJson(1, 'New Player'),
      'rank': null,
      'rating': null,
      'level': null,
      'rankMovement': null,
    });
    expect(p.rank, isNull);
    expect(p.rating, isNull);
    expect(p.level, isNull);
    expect(
      RankedPlayer.fromJson(rankedJson(2, 'Top', level: 'semi_pro')).level,
      RatingLevel.semiPro,
    );
  });

  test('a profile reads the eFootball rating, its level and the record', () {
    final p = PlayerProfile.fromJson(profileJson());
    expect(p.rating!.rating, 1542);
    expect(p.rating!.level, RatingLevel.amateur);
    expect(p.rating!.countryRank, 24);
    expect(p.record.winRate, closeTo(13 / 21, 1e-9));
    expect(PlayerProfile.fromJson(profileJson(rated: false)).rating, isNull);
    // Listed at the starting rating before any match.
    final fresh = PlayerProfile.fromJson(newPlayerProfileJson());
    expect(fresh.rating!.rating, PlayerProfile.startingRating);
    expect(fresh.hasPlayed, isFalse);
  });

  test('a level added after this build reads as unknown, not an error', () {
    GameRating rating(Map<String, dynamic> extra) => GameRating.fromJson({
      'gameId': 'efootball-mobile',
      'rating': 2500,
      ...extra,
    });
    expect(rating({'level': 'world_class'}).level, RatingLevel.worldClass);
    expect(rating({'level': 'hall_of_fame'}).level, RatingLevel.unknown);
    // Servers from before levels send none.
    expect(rating({}).level, isNull);
  });

  test('an open competition past its deadline reads as ended', () {
    final ended = Competition.fromJson({
      ...competitionJson(),
      'registrationClosesAt': '2020-01-01T00:00:00Z',
    });
    expect(ended.status, CompetitionStatus.registrationOpen);
    expect(ended.registrationEnded, isTrue);
    expect(Competition.fromJson(competitionJson()).registrationEnded, isFalse);
  });

  test('legal documents read the contest rules, and a new kind as unknown', () {
    LegalDocumentType kind(String type) => LegalDocument.fromJson({
      'documentType': type,
      'version': '1.0',
      'contentUrl': '/legal/$type',
    }).type;
    expect(kind('contest_rules'), LegalDocumentType.contestRules);
    expect(kind('cookie_policy'), LegalDocumentType.unknown);
  });
}
