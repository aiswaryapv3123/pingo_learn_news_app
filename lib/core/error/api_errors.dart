import 'package:pingo_learn_news/core/error/api_failure.dart';

class ServerError extends ApiFailure {
  final Map<String, List<String>>? validationErrors;
  ServerError({
    required String message,
    int? errorCode,
    String? validationMessage,
    this.validationErrors,
  }) : super(
            message: message,
            errorCode: errorCode,
            validationMessage: validationMessage);
}

class ClientError extends ApiFailure {
  ClientError({
    required String message,
    int? errorCode,
    String? validationMessage,
  }) : super(
            message: message,
            errorCode: errorCode,
            validationMessage: validationMessage);
}
