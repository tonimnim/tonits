// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceSession _$DeviceSessionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DeviceSession', json, ($checkedConvert) {
      final val = _DeviceSession(
        id: $checkedConvert('id', (v) => v as String),
        deviceName: $checkedConvert('deviceName', (v) => v as String? ?? ''),
        userAgent: $checkedConvert('userAgent', (v) => v as String? ?? ''),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        lastUsedAt: $checkedConvert(
          'lastUsedAt',
          (v) => DateTime.parse(v as String),
        ),
        revokedAt: $checkedConvert(
          'revokedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        current: $checkedConvert('current', (v) => v as bool? ?? false),
      );
      return val;
    });

_DeletionRequest _$DeletionRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DeletionRequest', json, ($checkedConvert) {
      final val = _DeletionRequest(
        id: $checkedConvert('id', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(
            _$DeletionStatusEnumMap,
            v,
            unknownValue: DeletionStatus.unknown,
          ),
        ),
        requestedAt: $checkedConvert(
          'requestedAt',
          (v) => DateTime.parse(v as String),
        ),
        executeAfter: $checkedConvert(
          'executeAfter',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

const _$DeletionStatusEnumMap = {
  DeletionStatus.pending: 'pending',
  DeletionStatus.cancelled: 'cancelled',
  DeletionStatus.completed: 'completed',
  DeletionStatus.unknown: 'unknown',
};
