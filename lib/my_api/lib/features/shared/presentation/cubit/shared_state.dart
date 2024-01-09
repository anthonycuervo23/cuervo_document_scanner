part of 'shared_cubit.dart';

abstract class SharedState extends Equatable {
  const SharedState();

  @override
  List<Object> get props => [];
}

class SharedInitial extends SharedState {}
