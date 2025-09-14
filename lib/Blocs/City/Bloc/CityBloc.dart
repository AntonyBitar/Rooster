import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooster_app/Blocs/Countries/Bloc/CountryBloc.dart';
import '../../Countries/States/CountryStates.dart';
import '../Events/CityEvent.dart';
import '../Repository/CityRepository.dart';
import '../States/CityStates.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final CityRepository repository;
  final CountryBloc countryBloc;
  CitiesBloc({required this.repository, required this.countryBloc}) : super(CitiesLoadSuccess(cities:[],selectedCity:null,hasReachedMax:true)) {
    on<LoadCities>(_onLoadCities);
    on<ResetCity>(_onResetCity);

    // countrySubscription = countryBloc.stream.listen((countryState) {
    //   if (countryState is CountryLoadSuccess && countryState.country!=null) {
    //     add(LoadCities( search: '',page:  1,countryId:countryState.country!.id!,reset: true,isFromListener: true));
    //   }
    // });
  }
  Future<void> _onResetCity(ResetCity event, Emitter<CitiesState> emit) async {
    if (state is CitiesLoadSuccess) {
      final currentState = state as CitiesLoadSuccess;
      emit(CitiesLoadSuccess(
        cities: currentState.cities,
        hasReachedMax: currentState.hasReachedMax,
        selectedCity: null,
      ));
    }
  }
  Future<void> _onLoadCities(
      LoadCities event, Emitter<CitiesState> emit) async {
    if(event.countryId!=-1){
    try {
      final previousSuccess =
      state is CitiesLoadSuccess ? state as CitiesLoadSuccess : null;

      final paged = await repository.loadCities(
        event.search,
        event.page,
        event.countryId!,
      );

      final allCities = (event.reset || previousSuccess == null)
          ? paged.cities
          :  previousSuccess.cities + paged.cities;
      emit(CitiesLoadSuccess(
        cities: allCities,
        hasReachedMax: !paged.hasMore,
        selectedCity: null,
      ));
    } catch (e) {
      print(e);
      emit(CitiesLoadFailure(e.toString()));
      }
    }
    else{
      print("asdasd");
      emit(CitiesLoadSuccess(
        cities: [],
        hasReachedMax: false,
        selectedCity: null,
      ));
    }
  }
}
