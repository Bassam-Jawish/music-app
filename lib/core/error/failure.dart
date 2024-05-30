import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return const ServerFailure('badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return const ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return const ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return const ServerFailure('Ops, There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    /*
    * if (statusCode == 404) {
      return const ServerFailure(
          'Your request was not found, please try later');
    } else if (statusCode == 500) {
      return const ServerFailure(
          'There is a problem with server, please try later');
    } else if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422 ) {
      return ServerFailure(response['message']);
    } else {
      return const ServerFailure('There was an error , please try again');
    }
    * */
    if (response['message'] != null) {
      print(statusCode);
      if (response['message'] is List<dynamic>) {
        return ServerFailure(response['message'][0]);
      }
      return ServerFailure(response['message']);
    } else {
      print(statusCode);
      return const ServerFailure('There was an error , please try again');
    }
  }

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $message}';
  }
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $message}';
  }
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

class PlaybackFailure extends Failure {
  const PlaybackFailure(String message) : super(message);
}