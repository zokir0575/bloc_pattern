import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/services/bored_service.dart';
import 'package:bloc_pattern/services/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _boredService;
  final ConnectivityService _connectivityService;
  HomeBloc(this._boredService, this._connectivityService) : super(HomeLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if(event == ConnectivityResult.none){
        print("no internet");
        add(NoInternetEvevnt());
      }else{
        print("yes internet");
        add(LoadApiEvent());
      }
    });
  on<LoadApiEvent>((event, emit) async {
    emit(HomeLoadingState());
    final activity = await _boredService.getBoredActivity();
    emit(HomeLoadedState(activity.activity, activity.type, activity.participants));
  });
  on<NoInternetEvevnt>((event, emit) {
    emit(HomeNoInternetState());
  });
  }
}
