import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Models/Country/CountryModel.dart';
import '../../Countries/States/CountryStates.dart';
import '../Events/SupplierEvent.dart';
import '../Repository/SupplierRepository.dart';
import '../States/SupplierStates.dart' as c;

class SuppliersCreationBloc extends Bloc<SuppliersCreationEvent, c.SuppliersCreationState> {
  final SupplierCreationRepository repository;

  SuppliersCreationBloc(this.repository) : super(c.SuppliersCreationInitial()){
    on<LoadSupplierCreation>(_onLoadSuppliers);
    // on<DeleteClientEvent>((event, emit) async {
    //   // Call delete API from repository, then maybe reload list
    //   // Emit states accordingly (e.g., ClientDeletedSuccess)
    // });
  }
  Future<void> _onLoadSuppliers(LoadSupplierCreation event, Emitter<c.SuppliersCreationState> emit) async {
    try {
      final paged = await repository.loadSuppliersCreation();
      emit(c.SuppliersCreationLoadSuccess(
        supplierCode: paged.supplierCode,
        supplierCodeCopy: paged.supplierCode
      ));
    } catch (e) {
      emit(c.SuppliersCreationLoadFailure(e.toString()));
    }
  }
}
