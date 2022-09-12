import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fitness/core/data/models/weight.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'latest_weight_state.dart';

class LatestWeightCubit extends Cubit<LatestWeightState> {
  final WeightsRepository weightsRepository;
  LatestWeightCubit(this.weightsRepository) : super(LatestWeightInitial());

  Future<void> getLatestWeight() async {
    emit(LatestWeightLoading());
    try {
      weightsRepository.getLatestWeight().listen((event) {
        if (event != null) {
          emit(LatestWeightLoaded(event));
        } else {
          emit(LatestWeightNoRecords());
        }
      });
    } catch (e) {
      emit(LatestWeightError('$e'));
    }
  }

  @override
  Future<void> close() {
    weightsRepository.disposeLatestWeightStreams();
    return super.close();
  }
}
