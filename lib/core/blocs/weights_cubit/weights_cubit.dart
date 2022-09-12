import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fitness/core/data/models/weight.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weights_state.dart';

class WeightsCubit extends Cubit<WeightsState> {
  final WeightsRepository weightsRepository;

  WeightsCubit(this.weightsRepository) : super(WeightsInitial());

  void getWeights() {
    emit(WeightsLoading());
    try {
      weightsRepository.getWeights().listen((event) {
        emit(WeightsLoaded(event));
      });
    } catch (e) {
      emit(WeightsError('$e'));
    }
  }

  @override
  Future<void> close() {
    weightsRepository.disposeGetWeightsStreams();
    return super.close();
  }
}
