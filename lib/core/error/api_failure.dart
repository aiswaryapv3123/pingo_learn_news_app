abstract class ApiFailure {
  final String? message;
  final int? errorCode;
  final String? validationMessage;

  ApiFailure({
    required this.message,
    this.errorCode,
    this.validationMessage,
  });

  @override
  String toString() {
    return 'ApiFailure: $message, Error Code: ${errorCode ?? 'None'}, Validation: ${validationMessage ?? 'None'}';
  }
}
