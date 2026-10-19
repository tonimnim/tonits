import 'dart:typed_data';

import '../../../core/api/api_client.dart';
import 'evidence.dart';

class EvidenceRepository {
  EvidenceRepository(this._api);

  final ApiClient _api;

  /// Declares a screenshot by its type, size and SHA-256 before uploading.
  Future<UploadIntent> createUpload({
    required String mediaType,
    required int byteSize,
    required String sha256,
  }) async {
    final json = await _api.post(
      '/v1/evidence/uploads',
      body: {'mediaType': mediaType, 'byteSize': byteSize, 'sha256': sha256},
      auth: true,
    );
    return UploadIntent.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// Sends the bytes straight to storage. Returns false when storage
  /// refused them.
  Future<bool> upload(UploadIntent intent, Uint8List bytes) async {
    final status = await _api.putBytes(
      intent.url,
      bytes,
      headers: intent.headers,
    );
    // 412: a retried PUT whose first attempt already stored the file.
    return (status >= 200 && status < 300) || status == 412;
  }

  /// Queues verification; repeating it is safe.
  Future<Evidence> complete(String id) => _evidence(
    _api.post(
      '/v1/evidence/uploads/${Uri.encodeComponent(id)}/complete',
      auth: true,
    ),
  );

  Future<Evidence> status(String id) => _evidence(
    _api.get('/v1/evidence/uploads/${Uri.encodeComponent(id)}', auth: true),
  );

  Future<Evidence> _evidence(Future<Map<String, dynamic>?> request) async =>
      Evidence.fromJson((await request)!['data'] as Map<String, dynamic>);
}
