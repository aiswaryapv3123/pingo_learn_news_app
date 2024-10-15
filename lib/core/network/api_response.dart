class ApiResponse<T> {
  final T? data;
  final String? message;

  ApiResponse({
    required this.data,
    this.message,
  });

  @override
  String toString() {
    return 'ApiResponse: $data, Message: $message }';
  }
}
