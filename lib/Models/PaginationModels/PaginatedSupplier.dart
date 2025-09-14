
import '../Supplier/SupplierModel.dart';

class PaginatedSuppliers {
  final List<Supplier> suppliers;
  final bool hasMore;
  PaginatedSuppliers({required this.suppliers, required this.hasMore});
}
