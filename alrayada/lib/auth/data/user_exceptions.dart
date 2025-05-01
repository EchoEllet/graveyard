import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'user_social_login.dart';

@immutable
sealed class UserException extends Equatable implements Exception {
  const UserException({
    required this.message,
  });
  final String message;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}

// Sign In

class EmailNotFoundUserException extends UserException {
  const EmailNotFoundUserException({required super.message});
}

class InvalidCredentialsUserException extends UserException {
  const InvalidCredentialsUserException({required super.message});
}

class WrongPasswordUserException extends UserException {
  const WrongPasswordUserException({required super.message});
}

// Sign Up

class EmailAlreadyUsedUserException extends UserException {
  const EmailAlreadyUsedUserException({required super.message});
}

class EmailVerificationLinkAlreadySentUserException extends UserException {
  const EmailVerificationLinkAlreadySentUserException({
    required super.message,
    required this.minutesToExpire,
  });

  final int minutesToExpire;

  @override
  List<Object?> get props => [minutesToExpire, ...super.props];
}

class ResetPasswordLinkAlreadySentUserException extends UserException {
  const ResetPasswordLinkAlreadySentUserException({
    required super.message,
    required this.minutesToExpire,
  });

  final int minutesToExpire;

  @override
  List<Object?> get props => [minutesToExpire, ...super.props];
}

class EmailAlreadyVerifiedUserException extends UserException {
  const EmailAlreadyVerifiedUserException({required super.message});
}

class UnknownUserException extends UserException {
  const UnknownUserException({required super.message});
}

class EmailNeedsVerificationUserException extends UserException {
  const EmailNeedsVerificationUserException({required super.message});
}

class TooManyRequestsUserException extends UserException {
  const TooManyRequestsUserException({required super.message});
}

class UserDisabledUserException extends UserException {
  const UserDisabledUserException({required super.message});
}

class NetworkUserException extends UserException {
  const NetworkUserException({required super.message});
}

class OperationNotAllowedUserException extends UserException {
  const OperationNotAllowedUserException({required super.message});
}

class UserNotLoggedInAnyMoreUserException extends UserException {
  const UserNotLoggedInAnyMoreUserException({required super.message});
}

class InvalidSocialInfoUserException extends UserException {
  const InvalidSocialInfoUserException({required super.message});
}

class SocialEmailIsNotVerifiedUserException extends UserException {
  const SocialEmailIsNotVerifiedUserException({required super.message});
}

/// To handle this exception, request the user sign up data first
/// Then use [socialLogin] to send the request once again.
class SocialMissingSignUpDataUserException extends UserException {
  const SocialMissingSignUpDataUserException({
    required super.message,
    required this.socialLogin,
  });

  /// Should be sent to the server once the user enter the sign up data.
  final SocialLogin socialLogin;

  @override
  List<Object?> get props => [socialLogin, ...super.props];
}
