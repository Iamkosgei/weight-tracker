import 'package:fitness/configs/assets.dart';
import 'package:fitness/core/blocs/latest_weight_cubit/latest_weight_cubit.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:fitness/core/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LatestWeigth extends StatelessWidget {
  const LatestWeigth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LatestWeightCubit(inject.get<WeightsRepository>())..getLatestWeight(),
      child: BlocBuilder<LatestWeightCubit, LatestWeightState>(
        builder: (context, state) {
          return state is LatestWeightLoaded
              ? SliverToBoxAdapter(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            Assets.scale,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${state.weight.weight}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 62,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'KG',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Latest weight',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                )
              : const SliverToBoxAdapter();
        },
      ),
    );
  }
}
