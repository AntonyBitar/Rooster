import '../../../Models/CostCenter/CostCenterModel.dart';

abstract class CostCentersEvent {}

// ------------------- Load -------------------
class LoadCostCenters extends CostCentersEvent {
  final String search;
  final bool reset;
  LoadCostCenters(this.search, {this.reset = false});
}

class CostCenterLoading extends CostCentersEvent {}

// ------------------- Add / Remove -------------------
class AddCostCenterUpdate extends CostCentersEvent {
  final CostCenterModel costCenter;
  final List<int> parentPath;

  AddCostCenterUpdate({
    required this.costCenter,
    this.parentPath = const [],
  });
}
class RemoveCostCenterStore extends CostCentersEvent{
  final List<int> costCenterPath;

  RemoveCostCenterStore({required this.costCenterPath});
}

class AddCostCenterStore extends CostCentersEvent{
  final CostCenterModel costCenter;
  final List<int> parentPath;
  AddCostCenterStore({
    required this.costCenter,
    this.parentPath = const [],
  });
}
class RemoveCostCenterUpdate extends CostCentersEvent {
  final List<int> costCenterPath;

  RemoveCostCenterUpdate({required this.costCenterPath});
}

// ------------------- Update -------------------
class UpdateCostCenter extends CostCentersEvent {
  final CostCenterModel costCenter;
  final List<int> costCenterPath;

  UpdateCostCenter({required this.costCenter,required this.costCenterPath});
}

// ------------------- Delete -------------------
class DeleteCostCenterFromBack extends CostCentersEvent {
  final CostCenterModel costCenterModel;
  DeleteCostCenterFromBack({required this.costCenterModel});
}

class DeleteCostCenter extends CostCentersEvent {
  final CostCenterModel costCenter;
  DeleteCostCenter({required this.costCenter});
}

// ------------------- Store -------------------
class StoreCostCenter extends CostCentersEvent {}

// ------------------- Client Example -------------------
class DeleteClientEvent extends CostCentersEvent {
  final String clientId;
  DeleteClientEvent(this.clientId);
}

// Add more client events here if needed, e.g., UpdateClientEvent, etc.
