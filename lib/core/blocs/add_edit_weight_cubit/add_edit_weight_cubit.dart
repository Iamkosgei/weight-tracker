import 'package:equatable/equatable.dart';
import 'package:fitness/core/data/models/weight.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_edit_weight_state.dart';

class AddEditWeightCubit extends Cubit<AddEditWeightState> {
  final WeightsRepository weightsRepository;
  AddEditWeightCubit(this.weightsRepository) : super(AddEditWeightInitial());

  Future<void> addEditWeight(Weight weight, {bool isEdit = false}) async {
    try {
      emit(AddEditWeightLoading());
      final res = await weightsRepository.addEditWeight(weight, isEdit: isEdit);
      emit(AddEditWeightSuccess(res));
    } catch (e) {
      emit(AddEditWeightError('$e'));
    }
  }
}
