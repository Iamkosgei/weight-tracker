part of 'weights_cubit.dart';

abstract class WeightsState extends Equatable {
  const WeightsState();

  @override
  List<Object> get props => [];
}

class WeightsInitial extends WeightsState {}

class WeightsLoading extends WeightsState {}

class WeightsError extends WeightsState {
  final String error;

  const WeightsError(this.error);
}

class WeightsLoaded extends WeightsState {
  final List<Weight> weights;

  const WeightsLoaded(this.weights);

  @override
  List<Object> get props => [weights];
}
