/// One page of a keyset-paginated collection: `{data: [...], page: {nextCursor,
/// hasMore}}`. Cursors are opaque; pass them back unchanged.
class CursorPage<T> {
  const CursorPage({
    required this.items,
    required this.nextCursor,
    required this.hasMore,
  });

  factory CursorPage.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) parse,
  ) {
    final page = json['page'] as Map<String, dynamic>;
    return CursorPage(
      items: (json['data'] as List)
          .cast<Map<String, dynamic>>()
          .map(parse)
          .toList(),
      nextCursor: page['nextCursor'] as String?,
      hasMore: page['hasMore'] as bool? ?? false,
    );
  }

  final List<T> items;
  final String? nextCursor;
  final bool hasMore;
}

/// Builds `path?key=value&…`, skipping null values.
String withQuery(String path, Map<String, Object?> query) {
  final params = {
    for (final MapEntry(:key, :value) in query.entries)
      if (value != null) key: '$value',
  };
  return params.isEmpty ? path : '$path?${Uri(queryParameters: params).query}';
}
