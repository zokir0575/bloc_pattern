part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadApiEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoInternetEvevnt extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
