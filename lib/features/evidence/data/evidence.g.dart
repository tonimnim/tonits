// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Evidence _$EvidenceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Evidence', json, ($checkedConvert) {
      final val = _Evidence(
        id: $checkedConvert('id', (v) => v as String),
        status: $checkedConvert('status', (v) => v as String),
        ready: $checkedConvert('ready', (v) => v as bool? ?? false),
        errorCode: $checkedConvert('processingErrorCode', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'errorCode': 'processingErrorCode'});

_UploadIntent _$UploadIntentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_UploadIntent', json, ($checkedConvert) {
      final val = _UploadIntent(
        id: $checkedConvert('id', (v) => v as String),
        url: $checkedConvert('uploadUrl', (v) => Uri.parse(v as String)),
        headers: $checkedConvert(
          'requiredHeaders',
          (v) => Map<String, String>.from(v as Map),
        ),
      );
      return val;
    }, fieldKeyMap: const {'url': 'uploadUrl', 'headers': 'requiredHeaders'});
