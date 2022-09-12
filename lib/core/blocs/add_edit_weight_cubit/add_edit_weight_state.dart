part of 'add_edit_weight_cubit.dart';

abstract class AddEditWeightState extends Equatable {
  const AddEditWeightState();

  @override
  List<Object> get props => [];
}

class AddEditWeightInitial extends AddEditWeightState {}

class AddEditWeightLoading extends AddEditWeightState {}

class AddEditWeightError extends AddEditWeightState {
  final String error;

  const AddEditWeightError(this.error);
}

class AddEditWeightSuccess extends AddEditWeightState {
  final Weight weight;

  const AddEditWeightSuccess(this.weight);
}
