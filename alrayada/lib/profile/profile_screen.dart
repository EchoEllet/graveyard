import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

import '../auth/data/models/user.dart';
import '../auth/logic/user_cubit.dart';
import '../auth/presentation/fields/user_info_text_inputs.dart';
import '../auth/presentation/navigate_back_on_logout.dart';
import '../common/extensions/scaffold_messenger_ext.dart';
import '../common/localizations/app_localization_extension.dart';
import '../common/logic/connectivity/connectivity_cubit.dart';
import '../common/presentation/widgets/errors/internet_error.dart';
import '../common/presentation/widgets/platform_adaptive_icon.dart';
import '../common/text_input_handler.dart';
import 'delete_account_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _labOwnerPhoneNumberInputHandler =
      TextInputHandler(TextEditingController(), FocusNode());
  final _labPhoneNumberController = TextEditingController();
  final _labNameController = TextEditingController();
  final _labOwnerNameController = TextEditingController();
  var _labCity = IraqGovernorate.defaultCity;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final userInfo =
        context.read<UserCubit>().state.userCredentialOrThrow.user.info;
    _labOwnerPhoneNumberInputHandler.controller.text =
        userInfo.labOwnerPhoneNumber;
    _labPhoneNumberController.text = userInfo.labPhoneNumber;
    _labNameController.text = userInfo.labName;
    _labOwnerNameController.text = userInfo.labOwnerName;
    _labCity = userInfo.city;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.profile),
      ),
      body: SafeArea(
        child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
          builder: (context, state) {
            if (state is ConnectivityDisconnected) {
              return const InternetError(onTryAgain: null);
            }
            return BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                // This should be nullable since once the user logout
                // It will take a short time before navigating back to the previous
                // screen due to animations
                final user = state.userCredential?.user;
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    const FlutterLogo(size: 200),
                    const Padding(padding: EdgeInsets.only(top: 4)),
                    ListTile(
                      title: Text(context.loc.emailAddress),
                      subtitle: Text(user?.email ?? ''),
                      trailing: const PlatformAdaptiveIcon(
                        materialIcon: Icons.email,
                        cupertinoIcon: CupertinoIcons.mail_solid,
                      ),
                      // TODO: Implement update change email address
                      onTap: () => throw UnimplementedError(
                        "We haven't implement change email address yet",
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: UserInfoTextInputs(
                        labOwnerPhoneNumberInputHandler:
                            _labOwnerPhoneNumberInputHandler,
                        labPhoneNumberController: _labPhoneNumberController,
                        labNameController: _labNameController,
                        labOwnerNameController: _labOwnerNameController,
                        cityInputHandler: (
                          initialCity: _labCity,
                          onSaved: (newValue) => _labCity =
                              newValue ?? IraqGovernorate.defaultCity,
                          loadCachedCity: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: BlocConsumer<UserCubit, UserState>(
                        listener: (context, state) {
                          if (state is UserUpdateUserFailure) {
                            ScaffoldMessenger.of(context).showSnackBarText(
                                context.loc.unknownErrorWithMsg(
                              state.exception.message,
                            ));
                            return;
                          }
                          if (state is UserUpdateUserSuccess) {
                            ScaffoldMessenger.of(context).showSnackBarText(
                                context.loc.dataHasBeenSuccessfullyUpdated);
                            return;
                          }
                        },
                        builder: (context, state) {
                          if (state is UserUpdateUserInProgress) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            // TODO: 401 error message are being shown once the user no longer
                            //  logged in due to UserCubit.updateUserInfo()
                            //  two messages one after the other are being shown.
                            // What is happening that the action (e.g., delete user account)
                            // are being triggered and the NavigateBackOnUserLogout triggered
                            // as well, so error message from there and a info message from
                            // NavigateBackOnUserLogout saying that user has logged out.
                            //
                            // An idea to solve this, we might want to have it at
                            // one place and always listen, show logout message
                            // and then always move to the home screen
                            child: NavigateBackOnUserLogout(
                              child: PlatformElevatedButton(
                                onPressed: () {
                                  final isValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (!isValid) return;
                                  // TODO: Only use save() method when needed, same for other usages
                                  _formKey.currentState?.save();
                                  context.read<UserCubit>().updateUserInfo(
                                        UserInfo(
                                          labOwnerPhoneNumber:
                                              _labOwnerPhoneNumberInputHandler
                                                  .controller.text,
                                          labPhoneNumber:
                                              _labPhoneNumberController.text,
                                          labName: _labNameController.text,
                                          labOwnerName:
                                              _labOwnerNameController.text,
                                          city: _labCity,
                                        ),
                                      );
                                },
                                child: Text(context.loc.update),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: BlocConsumer<UserCubit, UserState>(
                        listener: (context, state) {
                          if (state is UserDeleteFailure) {
                            ScaffoldMessenger.of(context).showSnackBarText(
                                context.loc.unknownErrorWithMsg(
                              state.exception.message,
                            ));
                            return;
                          }
                          if (state is UserDeleteSuccess) {
                            context.pop();
                            return;
                          }
                        },
                        builder: (context, state) {
                          if (state is UserDeleteInProgress) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              child: Text(context.loc.deleteAccount),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    const DeleteAccountDialog(),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
