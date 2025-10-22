import 'package:rooster_app/Models/CostCenter/CostCenterModel.dart';
import 'package:rooster_app/Models/Supplier/SupplierModel.dart';

abstract class CostCentersState {}

class CostCentersInitial extends CostCentersState {}


class CostCentersLoadSuccess extends CostCentersState {
  final List<CostCenterModel> originalCostCenters;
  final List<CostCenterModel> updateListCostCenters;

  final bool hasReachedMax;

  CostCentersLoadSuccess({
    required this.originalCostCenters,
    required this.updateListCostCenters,
    required this.hasReachedMax,
  });

  CostCentersLoadSuccess copyWith({
    List<CostCenterModel>? originalCostCenters,
    List<CostCenterModel>? updateListCostCenters,
    bool? hasReachedMax,
  }) {
    return CostCentersLoadSuccess(
      originalCostCenters: originalCostCenters ?? this.originalCostCenters,
      updateListCostCenters: updateListCostCenters ?? this.updateListCostCenters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class CostCentersStoreData extends CostCentersState {
  final List<CostCenterModel> costCenter;
  CostCentersStoreData({required this.costCenter});
  CostCentersStoreData copyWith({List<CostCenterModel>? costCenter}) {
    return CostCentersStoreData(
      costCenter: costCenter ?? this.costCenter,
    );
  }
}

class CostCentersLoadFailure extends CostCentersState {
  final String error;

  CostCentersLoadFailure(this.error);
}
class CostCentersStatus extends CostCentersState {
  final String message;
  final String title;
  final int statusCode;

  CostCentersStatus(this.message,this.title,this.statusCode);
}
