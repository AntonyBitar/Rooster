import '../CostCenter/CostCenterModel.dart';

class PaginatedCostCenter {
  final List<CostCenterModel> costCenters;
  final bool hasMore;
  PaginatedCostCenter({required this.costCenters, required this.hasMore});
}
