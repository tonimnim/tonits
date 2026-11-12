import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'countries.dart';

/// Where the player is, from their IP address, the way most apps know it
/// without asking for location: Cloudflare's trace page answers any request
/// with a `loc=KE` line for the country the address belongs to. No key, no
/// permission, and nothing about the player is sent beyond the request.
///
/// Null when it can't tell: offline, a timeout, or a code the app doesn't
/// list (such as Tor's `T1`). The player is then asked instead.
final countryLookupProvider = FutureProvider<String?>((ref) => lookUpCountry());

Future<String?> lookUpCountry({http.Client? client}) async {
  final http_ = client ?? http.Client();
  try {
    final response = await http_
        .get(Uri.parse('https://www.cloudflare.com/cdn-cgi/trace'))
        .timeout(const Duration(seconds: 6));
    if (response.statusCode != 200) return null;
    for (final line in const LineSplitter().convert(response.body)) {
      if (line.startsWith('loc=')) {
        return Country.byCode(line.substring(4).trim())?.code;
      }
    }
    return null;
  } catch (_) {
    return null;
  } finally {
    if (client == null) http_.close();
  }
}
