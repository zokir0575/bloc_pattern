import 'package:bloc_pattern/home/bloc/home_bloc.dart';
import 'package:bloc_pattern/services/bored_service.dart';
import 'package:bloc_pattern/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(RepositoryProvider.of<BoredService>(context),
          RepositoryProvider.of<ConnectivityService>(context),
          )
            ..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const  Text("Activities for bored people"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeLoadedState) {
            return Column(
              children: [
                Text(state.activityName),
                Text(state.activityType),
                Text(state.participants.toString()),
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
                    child: const  Text("Load me"))
              ],
            );
          }
          if(state is HomeNoInternetState){
            return const  Text("no internet :(");
          }
          return Container();
        }),
      ),
    );
  }
}
