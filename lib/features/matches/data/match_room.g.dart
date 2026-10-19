// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchRoom _$MatchRoomFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_MatchRoom',
  json,
  ($checkedConvert) {
    final val = _MatchRoom(
      summary: $checkedConvert(
        'summary',
        (v) => MatchSummary.fromJson(v as Map<String, dynamic>),
        readValue: _whole,
      ),
      code: $checkedConvert('code', (v) => v as String? ?? ''),
      bestOf: $checkedConvert('bestOf', (v) => (v as num?)?.toInt() ?? 1),
      gamesToWinValue: $checkedConvert(
        'gamesToWin',
        (v) => (v as num?)?.toInt(),
      ),
      drawAllowed: $checkedConvert('drawAllowed', (v) => v as bool? ?? false),
      checkInOpensAt: $checkedConvert(
        'checkInOpensAt',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      resultDueAt: $checkedConvert(
        'resultDueAt',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      completionReason: $checkedConvert(
        'completionReason',
        (v) => v as String?,
      ),
      instructions: $checkedConvert(
        'friendMatchInstructions',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) => FriendMatchInstruction.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList() ??
            const <FriendMatchInstruction>[],
      ),
      verification: $checkedConvert(
        'resultVerification',
        (v) => ResultVerification.fromJson(v as Map<String, dynamic>),
      ),
      result: $checkedConvert(
        'result',
        (v) => v == null
            ? null
            : ConfirmedResult.fromJson(v as Map<String, dynamic>),
      ),
      windows: $checkedConvert(
        'verificationPolicy',
        (v) => v == null
            ? const VerificationWindows()
            : VerificationWindows.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'gamesToWinValue': 'gamesToWin',
    'instructions': 'friendMatchInstructions',
    'verification': 'resultVerification',
    'windows': 'verificationPolicy',
  },
);

_FriendMatchInstruction _$FriendMatchInstructionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FriendMatchInstruction', json, ($checkedConvert) {
  final val = _FriendMatchInstruction(
    title: $checkedConvert('title', (v) => v as String),
    detail: $checkedConvert('detail', (v) => v as String),
  );
  return val;
});

_ResultVerification _$ResultVerificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_ResultVerification',
      json,
      ($checkedConvert) {
        final val = _ResultVerification(
          phase: $checkedConvert(
            'phase',
            (v) =>
                $enumDecodeNullable(
                  _$VerificationPhaseEnumMap,
                  v,
                  unknownValue: VerificationPhase.notStarted,
                ) ??
                VerificationPhase.notStarted,
          ),
          submitted: $checkedConvert(
            'submittedResult',
            (v) => v == null
                ? null
                : SubmittedResult.fromJson(v as Map<String, dynamic>),
          ),
          myScreenshotSent: $checkedConvert(
            'myScreenshot',
            (v) => v as bool? ?? false,
            readValue: _present,
          ),
          myScreenshots: $checkedConvert(
            'myScreenshots',
            (v) =>
                (v as List<dynamic>?)
                    ?.map(
                      (e) =>
                          ResultScreenshot.fromJson(e as Map<String, dynamic>),
                    )
                    .toList() ??
                const <ResultScreenshot>[],
          ),
          opponentScreenshotSent: $checkedConvert(
            'opponentScreenshotSubmitted',
            (v) => v as bool? ?? false,
          ),
          confirmationDeadline: $checkedConvert(
            'confirmationDeadline',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          screenshotDeadline: $checkedConvert(
            'screenshotDeadline',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          resolution: $checkedConvert('resolution', (v) => v as String?),
          entryRemoved: $checkedConvert(
            'entryRemoved',
            (v) => v as bool? ?? false,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'submitted': 'submittedResult',
        'myScreenshotSent': 'myScreenshot',
        'opponentScreenshotSent': 'opponentScreenshotSubmitted',
      },
    );

const _$VerificationPhaseEnumMap = {
  VerificationPhase.notStarted: 'not_started',
  VerificationPhase.awaitingConfirmation: 'awaiting_confirmation',
  VerificationPhase.awaitingScreenshots: 'awaiting_screenshots',
  VerificationPhase.inReview: 'in_review',
  VerificationPhase.resolved: 'resolved',
};

_ResultScreenshot _$ResultScreenshotFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ResultScreenshot', json, ($checkedConvert) {
      final val = _ResultScreenshot(
        game: $checkedConvert('game', (v) => (v as num?)?.toInt() ?? 1),
        evidenceId: $checkedConvert('evidenceId', (v) => v as String),
      );
      return val;
    });

_Score _$ScoreFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Score',
  json,
  ($checkedConvert) {
    final val = _Score(
      $checkedConvert('homeScore', (v) => (v as num).toInt()),
      $checkedConvert('awayScore', (v) => (v as num).toInt()),
      penalties: $checkedConvert(
        'tiebreak',
        (v) => v == null ? null : Score.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'home': 'homeScore',
    'away': 'awayScore',
    'penalties': 'tiebreak',
  },
);

_SubmittedResult _$SubmittedResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SubmittedResult', json, ($checkedConvert) {
      final val = _SubmittedResult(
        score: $checkedConvert(
          'score',
          (v) => Score.fromJson(v as Map<String, dynamic>),
          readValue: _whole,
        ),
        games: $checkedConvert(
          'games',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <Score>[],
        ),
        byMe: $checkedConvert('submittedByMe', (v) => v as bool),
        at: $checkedConvert('submittedAt', (v) => DateTime.parse(v as String)),
      );
      return val;
    }, fieldKeyMap: const {'byMe': 'submittedByMe', 'at': 'submittedAt'});

_ConfirmedResult _$ConfirmedResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ConfirmedResult', json, ($checkedConvert) {
      final val = _ConfirmedResult(
        score: $checkedConvert(
          'score',
          (v) => Score.fromJson(v as Map<String, dynamic>),
          readValue: _whole,
        ),
        games: $checkedConvert(
          'games',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <Score>[],
        ),
        origin: $checkedConvert('origin', (v) => v as String),
      );
      return val;
    });

_VerificationWindows _$VerificationWindowsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_VerificationWindows',
      json,
      ($checkedConvert) {
        final val = _VerificationWindows(
          confirm: $checkedConvert(
            'reportWindowSeconds',
            (v) => v == null
                ? const Duration(minutes: 10)
                : _seconds((v as num).toInt()),
          ),
          screenshot: $checkedConvert(
            'responseWindowSeconds',
            (v) => v == null
                ? const Duration(minutes: 10)
                : _seconds((v as num).toInt()),
          ),
          perGameScreenshots: $checkedConvert(
            'screenshotEvidence',
            (v) => v as bool? ?? false,
            readValue: _perGame,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'confirm': 'reportWindowSeconds',
        'screenshot': 'responseWindowSeconds',
        'perGameScreenshots': 'screenshotEvidence',
      },
    );
