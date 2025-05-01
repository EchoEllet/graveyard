import 'models/auth_credential.dart';
import 'models/user.dart';
import 'user_social_login.dart';

abstract class UserApi {
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required UserInfo userInfo,
  });

  Future<UserCredential> authenticateWithSocialLogin(
    SocialLogin socialLogin, {
    // Used for sign up only
    required UserInfo? userInfo,
  });

  Future<void> updateUserInfo(
    UserInfo userInfo,
  );
  Future<void> updateUserPassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> updateDeviceNotificationsToken();

  Future<void> sendResetPasswordLink({
    required String email,
  });
  Future<void> sendEmailVerificationLink();

  Future<void> logout();

  /// Registers a callback to be called when the API service logged out the user (e.g., invalid token).
  ///
  /// Only one callback can be registered at a time. Calling this method
  /// again will replace the existing callback.
  ///
  Future<void> setOnAutoLogout(void Function() onAutoLogout);

  /// Delete the account and logout
  Future<void> deleteAccount();

  Future<UserCredential?> fetchSavedUserCredential();

  // TODO: Add a way to check if this should logout in case if the user
  //  no longer logged in when calling this function, see UserCubit
  //  since when fethcing the user and the user no longer exist or logged in,
  //  the setOnAutoLogout will be triggered.
  Future<User?> fetchUser();
}
