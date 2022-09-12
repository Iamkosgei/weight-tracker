import 'package:fitness/configs/colors.dart';
import 'package:fitness/core/blocs/weights_cubit/weights_cubit.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:fitness/core/di/injector.dart';
import 'package:fitness/core/navigation/routes.dart';
import 'package:fitness/core/services/auth_service.dart';
import 'package:fitness/utils/utils.dart';
import 'package:fitness/views/pages/home_page/widgets/add_weight_bottom_sheet.dart';
import 'package:fitness/views/pages/home_page/widgets/latest_weight.dart';
import 'package:fitness/views/pages/home_page/widgets/no_weight_added.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final logout = await inject.get<AuthService>().logoutuser();

                if (logout) {
                  navigator.pushNamedAndRemoveUntil(
                      loginRoute, (route) => false);
                }
              },
              icon: const Icon(
                Icons.logout,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const LatestWeigth(),
              ];
            },
            body: BlocProvider(
              create: (_) => WeightsCubit(
                inject.get<WeightsRepository>(),
              )..getWeights(),
              child: BlocBuilder<WeightsCubit, WeightsState>(
                builder: (_, state) {
                  if (state is WeightsLoaded) {
                    if (state.weights.isEmpty) {
                      return const NoWeightAdded();
                    }
                    if (state is WeightsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.separated(
                        itemBuilder: (_, index) {
                          final weight = state.weights[index];
                          return ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: AddBottomSheet(
                                        weight: weight,
                                      ),
                                    );
                                  });
                            },
                            title: Text('${weight.weight} KG'),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            subtitle:
                                Text(getHowLongAgo(weight.createdDate ?? 0)),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: state.weights.length);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors().primaryColor,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              context: context,
              builder: (BuildContext bc) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: const AddBottomSheet(),
                );
              });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
