import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Events/CostCenterEvent.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Repository/CostCenterRepository.dart';
import 'package:rooster_app/Blocs/Cost%20Center/States/CostCenterState.dart';
import 'package:rooster_app/Models/CostCenter/CostCenterModel.dart';
import 'package:http/http.dart' as http;

class CostCenterBloc extends Bloc<CostCentersEvent, CostCentersState> {
  static const int _perPage = 10;
  final CostCenterRepository repository;

  CostCenterBloc({required this.repository}) : super(CostCentersInitial()) {
    on<LoadCostCenters>(_onLoadCostCenters);
    on<CostCenterLoading>((event, emit) => emit(CostCentersInitial()));
    on<AddCostCenterUpdate>(_handleAddCostCenter);
    on<RemoveCostCenterUpdate>(_handleRemoveCostCenter);
    on<AddCostCenterStore>(_handleAddCostCenterStore);
    on<RemoveCostCenterStore>(_handleRemoveCostCenterStore);
    on<StoreCostCenter>(_handleStoreCostCenter);
    on<DeleteCostCenterFromBack>(_handleDeleteCostCenterFromBack);
    on<UpdateCostCenter>(_handleUpdateCostCenter);
  }
  void _handleRemoveCostCenterStore(
      RemoveCostCenterStore event,
      Emitter<CostCentersState> emit,
      ) {
    if (state is CostCentersStoreData) {
      final currentState = state as CostCentersStoreData;
      List<CostCenterModel> updatedList =
      currentState.costCenter.map((e) => e.copy()).toList();

      if (event.costCenterPath.isNotEmpty) {
        if (event.costCenterPath.length == 1) {
          updatedList.removeAt(event.costCenterPath[0]);
        } else {
          CostCenterModel parent = updatedList[event.costCenterPath[0]];
          for (int i = 1; i < event.costCenterPath.length - 1; i++) {
            parent = parent.children[event.costCenterPath[i]];
          }
          parent.children.removeAt(event.costCenterPath.last);
        }
      }
      emit(currentState.copyWith(costCenter: updatedList));
    }
  }

  Future<void> _onLoadCostCenters(LoadCostCenters event, Emitter<CostCentersState> emit) async {
    try {
      if (!event.reset && state is CostCentersLoadSuccess && (state as CostCentersLoadSuccess).hasReachedMax) return;

      final int page = (event.reset || state is! CostCentersLoadSuccess)
          ? 1
          : ((state as CostCentersLoadSuccess).originalCostCenters.length ~/ _perPage) + 1;

      final paged = await repository.loadCostCenters(event.search, page);

      final allCostCenters = (event.reset || state is! CostCentersLoadSuccess)
          ? paged.costCenters
          : (state as CostCentersLoadSuccess).originalCostCenters + paged.costCenters;

      List<CostCenterModel> updateList = allCostCenters.map((e) => e.copy()).toList();
      emit(CostCentersLoadSuccess(updateListCostCenters: updateList,originalCostCenters: allCostCenters, hasReachedMax: !paged.hasMore));
    } catch (e) {
      emit(CostCentersLoadFailure(e.toString()));
    }
  }

  void _handleRemoveCostCenter(
      RemoveCostCenterUpdate event,
      Emitter<CostCentersState> emit,
      ) {
    if (state is! CostCentersLoadSuccess) return;
    final currentState = state as CostCentersLoadSuccess;

    List<CostCenterModel> updatedList = currentState.updateListCostCenters;

    if (event.costCenterPath.isNotEmpty) {
      if (event.costCenterPath.length == 1) {
        updatedList.removeAt(event.costCenterPath.first);
      } else {
        CostCenterModel parent = updatedList[event.costCenterPath.first];
        for (int i = 1; i < event.costCenterPath.length - 1; i++) {
          parent = parent.children[event.costCenterPath[i]];
        }
        int lastIndex = event.costCenterPath.last;
        parent.children.removeAt(lastIndex);
      }
    }

    emit(currentState.copyWith(updateListCostCenters: updatedList));
  }




  void _handleAddCostCenter(
      AddCostCenterUpdate event,
      Emitter<CostCentersState> emit,
      ) {
    if (state is! CostCentersLoadSuccess) return;
    final currentState = state as CostCentersLoadSuccess;

    // Work on a copy of updateListCostCenters
    List<CostCenterModel> updatedList = currentState.updateListCostCenters;
    if (event.parentPath.isEmpty) {
      updatedList.add(event.costCenter);
    } else {
      CostCenterModel parent = updatedList[event.parentPath.first];
      for (int i = 1; i < event.parentPath.length; i++) {
        parent = parent.children[event.parentPath[i]];
      }
      parent.children.add(event.costCenter);
    }
    print(updatedList[0].children.length);
    emit(currentState.copyWith(updateListCostCenters: updatedList));
  }






  Future<void> _handleUpdateCostCenter(UpdateCostCenter event, Emitter<CostCentersState> emit) async {
    if (state is! CostCentersLoadSuccess) return;
    final currentState = state as CostCentersLoadSuccess;

    final response = await repository.updateCostCenter(event.costCenter);
    final responseBody = jsonDecode(response.body);

    List<CostCenterModel> updatedList = currentState.originalCostCenters;
    final CostCenterModel updatedNode = CostCenterModel.fromJson(responseBody['data']);

    if (event.costCenterPath.length == 1) {
      // Replace at root level
      updatedList[event.costCenterPath.first] = updatedNode;
    } else {
      // Walk down until the parent of the node
      CostCenterModel parent = updatedList[event.costCenterPath.first];
      for (int i = 1; i < event.costCenterPath.length - 1; i++) {
        parent = parent.children[event.costCenterPath[i]];
      }

      // Replace the node at the last index
      int lastIndex = event.costCenterPath.last;
      parent.children[lastIndex] = updatedNode;
    }

    final message = responseBody['message'] ?? 'Unknown error';
    emit(CostCentersStatus(
      message,
      response.statusCode == 200 ? "Success" : "Error",
      response.statusCode,
    ));
    List<CostCenterModel> updateList = currentState.originalCostCenters.map((e) => e.copy()).toList();
    if (response.statusCode == 200) {
      _markAllAsNotNew(currentState.originalCostCenters);
      emit(CostCentersLoadSuccess(
        updateListCostCenters: updateList,
        originalCostCenters: currentState.originalCostCenters,
        hasReachedMax: true,
      ));
    }
  }

  void _markAllAsNotNew(List<CostCenterModel> costCenters) {
    for (var cc in costCenters) {
      cc.isNew = false;
      if (cc.children.isNotEmpty) {
        _markAllAsNotNew(cc.children); // recursive call for children
      }
    }
  }

  Future<void> _handleStoreCostCenter(
      StoreCostCenter event,
      Emitter<CostCentersState> emit,
      ) async {
    if (state is CostCentersStoreData) {
      final currentState = state as CostCentersStoreData;
      http.Response response =
      await repository.storeCostCenter(currentState.costCenter);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String message = responseBody['message'] ?? 'Unknown error';
      emit(CostCentersStatus(
        message,
        response.statusCode == 200 ? "Success" : "error",
        response.statusCode,
      ));
    }
  }

  void _handleAddCostCenterStore(AddCostCenterStore event, Emitter<CostCentersState> emit) {
    if (state is CostCentersLoadSuccess) {
      emit(CostCentersStoreData(costCenter: [event.costCenter]));
      return;
    }

    if (state is CostCentersStoreData) {
      final currentState = state as CostCentersStoreData;
      List<CostCenterModel> updatedList = currentState.costCenter
          .map((e) => e.copy())
          .toList();

      if (event.parentPath.isEmpty) {
        updatedList.add(event.costCenter);
      } else {
        CostCenterModel parent = updatedList[event.parentPath[0]];
        for (int i = 1; i < event.parentPath.length; i++) {
          parent = parent.children[event.parentPath[i]];
        }
        parent.children.add(event.costCenter);
      }
      emit(currentState.copyWith(costCenter: updatedList));
    }
  }

  List<CostCenterModel> _removeNodeRecursively(List<CostCenterModel> nodes, int idToRemove) {
    List<CostCenterModel> updated = [];

    for (var node in nodes) {
      if (node.id != idToRemove) {
        // Copy node to avoid mutating original
        var newNode = node.copy();
        // Recursively remove from children
        newNode.children = _removeNodeRecursively(newNode.children, idToRemove);
        updated.add(newNode);
      }
    }

    return updated;
  }

  Future<void> _handleDeleteCostCenterFromBack(
      DeleteCostCenterFromBack event,
      Emitter<CostCentersState> emit,
      ) async {
    if (state is! CostCentersLoadSuccess) return;
    final currentState = state as CostCentersLoadSuccess;

    final response = await repository.deleteCostCenter(event.costCenterModel.id!);
    final responseBody = jsonDecode(response.body);
    final message = responseBody['message'] ?? 'Unknown error';

    emit(CostCentersStatus(message, response.statusCode == 200 ? "Success" : "Error", response.statusCode));

    if (response.statusCode == 200) {
      final updatedList = _removeNodeRecursively(currentState.originalCostCenters, event.costCenterModel.id!);
      emit(CostCentersLoadSuccess(updateListCostCenters: [],originalCostCenters: updatedList, hasReachedMax: currentState.hasReachedMax));
    }
  }


}
