import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/extensions/scaffold_messenger_ext.dart';
import '../../common/localizations/app_localization_extension.dart';
import '../../common/presentation/app_router.dart';
import '../logic/user_cubit.dart';

/// A widget that will navigate back to the previous screen
/// and display a message once the user logged out
class NavigateBackOnUserLogout extends StatelessWidget {
  const NavigateBackOnUserLogout({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      // TODO: This condition has an issue, it will be only true when
      // emitting logout state, which might not what I want at the moment
      listenWhen: (previous, current) =>
          current.wasLoggedInAndNowLoggedOut(previous: previous),
      listener: (context, state) {
        assert(
          context.read<UserCubit>().state.userCredential == null,
          'The user should be logged out at this state, check the listenWhen',
        );
        context.go(AppRouter.initialRoute);
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..clearSnackBars()
          ..showSnackBarText(context.loc.sessionExpired);
      },
      child: child,
    );
  }
}
