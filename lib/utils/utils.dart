import 'package:intl/intl.dart';

enum PaymentMethod { onepay, alipay, creditdebit, maruhan }

class Utils {
  static String getDateFormat(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
  
  static String getTimeFormat(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formateTime(String time) {
    return time
        .split(':')
        .sublist(0, 2)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(',', ':');
  }

  static String getQueryDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String getCurrency(int number) {
    return NumberFormat("#,###").format(number);
  }

  static String getDateFormatUs(DateTime date) {
    final DateFormat formatter = DateFormat('yMd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getErrorMessageFirebaseAuth(errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      // case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "email_in_use";
      // break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "wrong_password";
      // break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "no_user_found";
      // break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "user_disable";
      // break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "too_many_request";
      // break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "server_error";
      // break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "invalid_email";
      // break;
      case "ERROR_ABORTED_BY_USER":
        return "user_aborted";
      // break;
      case "ERROR_MISSING_GOOGLE_AUTH_TOKEN":
        return "missing_token";
      // break;
      case "ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
      case "account-exists-with-different-credential":
        return "exist_different_cred";
      // break;
      case "ERROR_AUTHORIZATION_DENIED":
        return "authorize_denied";
      // break;

      default:
        return "login_failed";
      // break;
    }
  }
}
