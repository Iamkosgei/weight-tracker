import 'package:equatable/equatable.dart';
import 'package:fitness/core/data/models/weight.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_weight_state.dart';

class DeleteWeightCubit extends Cubit<DeleteWeightState> {
  final WeightsRepository weightsRepository;
  DeleteWeightCubit(this.weightsRepository) : super(DeleteWeightInitial());

  Future<void> deleteWeight(Weight weight) async {
    try {
      emit(DeleteWeightLoading());

      final res = await weightsRepository.deleteWeight(weight);
      emit(DeleteWeightSuccess(res));
    } catch (e) {
      emit(DeleteWeightError('$e'));
    }
  }
}
