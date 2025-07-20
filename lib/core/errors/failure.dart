import 'package:dio/dio.dart';

/// Abstract failure class to be extended by specific error types
abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

/// Server-related failures (e.g. 400, 401, 500, timeouts, no internet, etc.)
class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);

  /// Create ServerFailure from Dio error
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

  /// Create ServerFailure based on HTTP status code and response
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == null) {
      return const ServerFailure('Unknown server error.');
    }

    final String message = response?['message'] ??
        response?['error']?['message'] ??
        'An error occurred';

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
