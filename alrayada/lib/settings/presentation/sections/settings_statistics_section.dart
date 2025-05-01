import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/localizations/app_localization_extension.dart';
import '../../../common/presentation/widgets/platform_adaptive_icon.dart';
import '../../logic/settings_cubit.dart';
import '../settings_section.dart';

class SettingsStatisticsSection extends StatelessWidget {
  const SettingsStatisticsSection({required this.state, super.key});

  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: context.loc.statistics,
      tiles: [
        SwitchListTile.adaptive(
          title: Text(context.loc.forceUseScrollableChart),
          subtitle: Text(context.loc.forceUseScrollableChartSettingsDesc),
          secondary: const Icon(Icons.tune),
          onChanged: (value) => context.read<SettingsCubit>().updateSettings(
              state.copyWith(
                  forceUseScrollableChart: !state.forceUseScrollableChart)),
          value: state.forceUseScrollableChart,
        ),
        SwitchListTile.adaptive(
          title: Text(context.loc.preferNumbersInChartMonths),
          subtitle: Text(context.loc.preferNumbersInChartMonthsSettingsDesc),
          secondary: PlatformAdaptiveIcon(
            materialIcon: Icons.insert_chart_outlined,
            cupertinoIcon: CupertinoIcons.chart_bar,
            semanticLabel: context.loc.preferNumbersInChartMonths,
          ),
          onChanged: (value) => context.read<SettingsCubit>().updateSettings(
              state.copyWith(
                  useMonthNumberInChart: !state.useMonthNumberInChart)),
          value: state.useMonthNumberInChart,
        ),
      ],
    );
  }
}
