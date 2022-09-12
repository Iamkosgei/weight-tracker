part of 'latest_weight_cubit.dart';

abstract class LatestWeightState extends Equatable {
  const LatestWeightState();

  @override
  List<Object> get props => [];
}

class LatestWeightInitial extends LatestWeightState {}

class LatestWeightLoading extends LatestWeightState {}

class LatestWeightError extends LatestWeightState {
  final String error;

  const LatestWeightError(this.error);
}

class LatestWeightLoaded extends LatestWeightState {
  final Weight weight;

  const LatestWeightLoaded(this.weight);

  @override
  List<Object> get props => [weight];
}

class LatestWeightNoRecords extends LatestWeightState {}
