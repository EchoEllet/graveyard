import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/global_validator.dart';
import '../../../common/localizations/app_localization_extension.dart';
import '../../../common/presentation/widgets/platform_adaptive_icon.dart';
import '../../../common/text_input_handler.dart';
import '../../data/models/user.dart';
import '../../logic/auth_validator.dart';
import 'city_picker_field.dart';

class UserInfoTextInputs extends StatelessWidget {
  const UserInfoTextInputs({
    required this.labOwnerPhoneNumberInputHandler,
    required this.labPhoneNumberController,
    required this.labNameController,
    required this.labOwnerNameController,
    required this.cityInputHandler,
    super.key,
  });

  final TextInputHandler labOwnerPhoneNumberInputHandler;
  final TextEditingController labPhoneNumberController;
  final TextEditingController labNameController;
  final TextEditingController labOwnerNameController;
  final ({
    FormFieldSetter<IraqGovernorate> onSaved,
    IraqGovernorate initialCity,
    bool loadCachedCity,
  }) cityInputHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                maxLength: 11,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: true,
                controller: labOwnerPhoneNumberInputHandler.controller,
                focusNode: labOwnerPhoneNumberInputHandler.focusNode,
                autofillHints: const [AutofillHints.telephoneNumberLocal],
                decoration: InputDecoration(
                  hintText: context.loc.labOwnerPhoneNumber,
                  prefixIcon: const PlatformAdaptiveIcon(
                    materialIcon: Icons.phone,
                    cupertinoIcon: CupertinoIcons.phone,
                  ),
                  labelText: context.loc.labOwnerPhoneNumber,
                ),
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                validator: (value) => AuthValidator.validatePhoneNumber(
                  phoneNumber: value ?? '',
                  localizations: context.loc,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                maxLength: 11,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.phone,
                enableSuggestions: true,
                controller: labPhoneNumberController,
                autofillHints: const [AutofillHints.telephoneNumberLocal],
                decoration: InputDecoration(
                  hintText: context.loc.labPhoneNumber,
                  prefixIcon: const PlatformAdaptiveIcon(
                    materialIcon: Icons.phone_outlined,
                    cupertinoIcon: CupertinoIcons.phone,
                  ),
                  labelText: context.loc.labPhoneNumber,
                ),
                minLines: 1,
                maxLines: 1,
                validator: (value) => AuthValidator.validatePhoneNumber(
                  phoneNumber: value ?? '',
                  localizations: context.loc,
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.location],
          controller: labNameController,
          decoration: InputDecoration(
            hintText: context.loc.labName,
            prefixIcon: const PlatformAdaptiveIcon(
              materialIcon: Icons.location_history_rounded,
              cupertinoIcon: CupertinoIcons.person_2_square_stack,
            ),
            labelText: context.loc.labName,
          ),
          minLines: 1,
          maxLines: 1,
          validator: (value) => GlobalValidator.validateTextIsEmpty(
            value ?? '',
            errorMessage: context.loc.pleaseEnterTheLabName,
          ),
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.name],
          decoration: InputDecoration(
            hintText: context.loc.labOwnerName,
            prefixIcon: const PlatformAdaptiveIcon(
              materialIcon: Icons.location_history,
              cupertinoIcon: CupertinoIcons.person,
            ),
            labelText: context.loc.labOwnerName,
          ),
          minLines: 1,
          controller: labOwnerNameController,
          maxLines: 1,
          validator: (value) => GlobalValidator.validateTextIsEmpty(
            value ?? '',
            errorMessage: context.loc.pleaseEnterTheLabOwnerName,
          ),
        ),
        const SizedBox(height: 8),
        // TODO: Update how the CityPickerFormField work, don't use onSaved to avoid some bugs
        CityPickerFormField(
          onSaved: cityInputHandler.onSaved,
          initialCity: cityInputHandler.initialCity,
          loadCachedCity: cityInputHandler.loadCachedCity,
        ),
      ],
    );
  }
}
