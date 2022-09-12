part of 'delete_weight_cubit.dart';

abstract class DeleteWeightState extends Equatable {
  const DeleteWeightState();

  @override
  List<Object> get props => [];
}

class DeleteWeightInitial extends DeleteWeightState {}

class DeleteWeightLoading extends DeleteWeightState {}

class DeleteWeightError extends DeleteWeightState {
  final String error;

  const DeleteWeightError(this.error);
}

class DeleteWeightSuccess extends DeleteWeightState {
  final Weight weight;

  const DeleteWeightSuccess(this.weight);
}
