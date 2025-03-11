import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';
import 'controller.dart';

class GameControllerStyleViewBody extends StatelessWidget {
  const GameControllerStyleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsCubit, OptionsState>(
      builder: (context, state) {
        return Column(
          children: [
            InkWell(
              onTap: () => getIt.get<OptionsCubit>().changeControllerStyle(1),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(AppLocalization.style1),
                    trailing: Radio(
                        value: getIt.get<OptionsCubit>().state.controllerStyle,
                        groupValue: 1,
                        onChanged: (value) {}),
                  ),
                  const Controller(style: 1),
                ],
              ),
            ),
            InkWell(
              onTap: () => getIt.get<OptionsCubit>().changeControllerStyle(2),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(AppLocalization.style2),
                    trailing: Radio(
                        value: getIt.get<OptionsCubit>().state.controllerStyle,
                        groupValue: 2,
                        onChanged: (value) {}),
                  ),
                  const Controller(style: 2),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
