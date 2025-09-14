import 'package:bloc/bloc.dart';
import '../../../Models/Country/CountryModel.dart';
import '../Events/CountryEvent.dart';
import '../Repository/CountryRepository.dart';
import '../States/CountryStates.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository repository;

  CountryBloc(this.repository) : super(CountryInitial()){
    on<LoadCountryCreation>(_onLoadCountry);
    on<ResetCountry>(_onResetCountry);

  }


  // on<DeleteClientEvent>((event, emit) async {
  //   // Call delete API from repository, then maybe reload list
  //   // Emit states accordingly (e.g., ClientDeletedSuccess)
  // });


  Future<void> _onResetCountry(ResetCountry event, Emitter<CountryState> emit) async {
    if (state is CountryLoadSuccess) {
      final currentState = state as CountryLoadSuccess;
      emit(CountryLoadSuccess(
        countries: currentState.countries,
        hasReachedMax: currentState.hasReachedMax,
        country: null,
      ));
    }
  }
  Future<void> _onLoadCountry(LoadCountryCreation event, Emitter<CountryState> emit) async {
    if(event.shouldLoad) {
      try {
        final paged = await repository.loadCountries(event.search, event.page);
        List<Country> allCountries = [];
        if (event.reset || state is CountryInitial) {
          allCountries = paged.countries;
        } else {
          allCountries =
              (state as CountryLoadSuccess).countries + paged.countries;
        }
        emit(CountryLoadSuccess(
            countries: allCountries,
            hasReachedMax: !paged.hasMore,
            country: event.selectedCountry
        ));
      } catch (e) {
        emit(CountryLoadFailure(e.toString()));
      }
    }else{
      emit(CountryLoadSuccess(
          countries: [],
          hasReachedMax: false,
          country: event.selectedCountry
      ));
    }
  }
}
