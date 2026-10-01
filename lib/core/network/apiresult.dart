class ApiResult<T> {
  final bool success;
  final String message;
  final T? data;
  final int? statusCode;
  final String? errorMessage;

  const ApiResult._({
    required this.success,
    required this.message,
    this.data,
    this.statusCode,
    this.errorMessage,
  });

  factory ApiResult.success({
    required String message,
    T? data,
    int? statusCode,
  }) =>
      ApiResult._(
        success: true,
        message: message,
        data: data,
        statusCode: statusCode,
      );

  factory ApiResult.error(
      String message, {
        int? statusCode,
      }) =>
      ApiResult._(
        success: false,
        message: message,
        statusCode: statusCode,
        errorMessage: message,
      );

  String? get recordId {
    if (data == null || data is! Map) return null;
    final m = Map<String, dynamic>.from(data as Map);

    for (final key in ['inspection_id', 'id', '_id']) {
      if (m[key] != null && m[key].toString().isNotEmpty) {
        return m[key].toString();
      }
    }
    if (m['data'] is Map) {
      final inner = Map<String, dynamic>.from(m['data'] as Map);
      for (final key in ['inspection_id', 'id', '_id']) {
        if (inner[key] != null && inner[key].toString().isNotEmpty) {
          return inner[key].toString();
        }
      }
    }
    return null;
  }
}