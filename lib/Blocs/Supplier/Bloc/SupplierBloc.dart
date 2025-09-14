import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Controllers/home_controller.dart';
import '../../../Models/Supplier/SupplierModel.dart';
import '../Events/SupplierEvent.dart';
import '../Repository/SupplierRepository.dart';
import '../States/SupplierStates.dart';

class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {
  final SupplierRepository repository;
  static const int _perPage = 5;

  SuppliersBloc(this.repository) : super(SuppliersInitial()) {
    on<LoadSuppliers>(_onLoadSuppliers);
    on<StoreSupplier>(_onStoreSupplier);
    on<UpdateSupplier>(_onUpdateSupplier);
    on<DeleteSupplier>(_onDeleteSupplier);
    on<SupplierLoading>((event,emit){
      emit(SuppliersInitial());
    });
    // on<DeleteClientEvent>((event, emit) async {
    //   // Call delete API from repository, then maybe reload list
    //   // Emit states accordingly (e.g., ClientDeletedSuccess)
    // });
  }
  Future<void> _onDeleteSupplier(DeleteSupplier event, Emitter<SuppliersState> emit) async {
    final SuppliersLoadSuccess recentSuppliersLoadSuccess=(state as SuppliersLoadSuccess);
    emit(SuppliersInitial());
    http.Response response=await repository.deleteSupplier(event.supplier.id!);
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    String message = responseBody['message']?? 'Unknown error';
    emit (SuppliersStatus(message,response.statusCode==200?"Success":"error",response.statusCode));
    if(response.statusCode==200){
      recentSuppliersLoadSuccess.suppliers.remove(event.supplier);
    }
    emit(SuppliersLoadSuccess(suppliers: recentSuppliersLoadSuccess.suppliers, hasReachedMax: true));
  }
  Future<void> _onStoreSupplier(StoreSupplier event, Emitter<SuppliersState> emit) async {
     emit(SuppliersInitial());
      http.Response response=await repository.storeSupplier(event.supplier);
     Map<String, dynamic> responseBody = jsonDecode(response.body);
     String message = responseBody['message']?? 'Unknown error';
      emit (SuppliersStatus(message,response.statusCode==200?"Success":"error",response.statusCode));
  }

  Future<void> _onUpdateSupplier(UpdateSupplier event, Emitter<SuppliersState> emit) async {
    final SuppliersLoadSuccess recentSuppliersLoadSuccess=(state as SuppliersLoadSuccess);
    emit(SuppliersInitial());
    http.Response response=await repository.updateSupplier(event.supplier);
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    String message = responseBody['message']?? 'Unknown error';
    emit (SuppliersStatus(message,response.statusCode==200?"Success":"error",response.statusCode));
    if(response.statusCode==200) {
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final supplierJson = decoded['data'] as Map<String, dynamic>;
      print(supplierJson);
      Supplier s = Supplier.fromJson(supplierJson);
      int index = recentSuppliersLoadSuccess.suppliers.indexWhere((test) => test.id == s.id);
      recentSuppliersLoadSuccess.suppliers[index]=s;
    }
    emit(SuppliersLoadSuccess(suppliers: recentSuppliersLoadSuccess.suppliers, hasReachedMax: true));
  }

  Future<void> _onLoadSuppliers(LoadSuppliers event, Emitter<SuppliersState> emit) async {
    try {
      if (!event.reset && state is SuppliersLoadSuccess && (state as SuppliersLoadSuccess).hasReachedMax) return;
      final int page = (event.reset || state is SuppliersInitial || state is SuppliersStatus)
          ? 1
          : ((state as SuppliersLoadSuccess).suppliers.length ~/ _perPage) + 1;

      final paged = await repository.loadSuppliers(event.search, page);

      List<Supplier> allSuppliers;
      if (event.reset || state is SuppliersInitial || state is SuppliersStatus) {
        allSuppliers = paged.suppliers;
      } else {
        allSuppliers = (state as SuppliersLoadSuccess).suppliers + paged.suppliers;
      }
      emit(SuppliersLoadSuccess(
        suppliers: allSuppliers,
        hasReachedMax: !paged.hasMore,
      ));
    } catch (e) {
      emit(SuppliersLoadFailure(e.toString()));
  }
  }
}
