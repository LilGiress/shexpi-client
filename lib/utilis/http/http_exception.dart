enum ExceptionType {
  ValidationException,
  NotFoundException,
  AuthenticationException,
  AuthorizationException,
  HttpException,
  ServerError
}


class HttpException extends Object implements Exception {
  final int code;
  final String message;
  final dynamic error;

  HttpException(this.code, this.error, this.message);

  ExceptionType get type {
    switch(code.toString()){
      case '422':
        return ExceptionType.ValidationException;
        break;
      case '404':
        return ExceptionType.NotFoundException;
        break;
      case '401':
        return ExceptionType.AuthenticationException;
        break;
      case '403':
        return ExceptionType.AuthorizationException;
        break;
      case '500':
        return ExceptionType.ServerError;
        break;
      default:
        return ExceptionType.HttpException;

    }
  }

  @override
  String toString() {
    return message;

    // return super.toString();
  }
}