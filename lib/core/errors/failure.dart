import 'package:dio/dio.dart';

/// Abstract failure class to be extended by specific error types
abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

/// Server-related failures (e.g. timeouts, bad response, no internet, etc.)
class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);

  /// Factory constructor to handle different Dio errors
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with API server.');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with API server.');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with API server.');
      case DioExceptionType.badCertificate:
        return const ServerFailure('Invalid certificate.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled.');
      case DioExceptionType.connectionError:
        return const ServerFailure('Connection error occurred.');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return const ServerFailure('No internet connection.');
        }
        return const ServerFailure('Unexpected error. Please try again.');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
  if (response is! Map) {
    return const ServerFailure('Unexpected server response format.');
  }

  // أولاً نحاول نجيب رسالة الخطأ من أكثر من احتمال
  dynamic rawMessage = response['massege'] ?? response['message'] ?? response['error'];

  String message;

  if (rawMessage is Map && rawMessage.containsKey('email')) {
    final emailErrors = rawMessage['email'];
    if (emailErrors is List && emailErrors.isNotEmpty) {
      message = emailErrors.first; // زي "The email has already been taken."
    } else {
      message = 'Invalid email.';
    }
  } else if (rawMessage is String) {
    message = rawMessage;
  } else {
    message = 'An error occurred';
  }

  if (message.toLowerCase().contains('wrong')) {
    return const ServerFailure('Email or password is incorrect.');
  }

  if (statusCode == null) {
    return ServerFailure(message);
  }

  if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
    return ServerFailure(message);
  } else if (statusCode == 404) {
    return const ServerFailure('Request not found (404).');
  } else if (statusCode == 500) {
    return const ServerFailure('Internal server error (500).');
  } else {
    return ServerFailure('Error $statusCode: $message');
  }
}


}
