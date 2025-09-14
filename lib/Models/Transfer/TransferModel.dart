import '../TransferItem/TransferItemModel.dart';
import '../User/UserModel.dart';
import '../WareHouse/WareHouseModel.dart';
class Transfer {
  int? id;
  Warehouse? sourceWarehouse;
  Warehouse? destWarehouse;
  User? sendingUser;
  User? receivingUser;
  int? companyId;
  String? status;
  String? transferNumber;
  String? reference;
  double? totalQuantity;
  DateTime? creationDate;
  DateTime? receivingDate;
  String? note;
  List<TransferItem>? transferItems;

  Transfer({
    this.id,
    this.sourceWarehouse,
    this.destWarehouse,
    this.sendingUser,
    this.receivingUser,
    this.companyId,
    this.status,
    this.transferNumber,
    this.reference,
    this.totalQuantity,
    this.creationDate,
    this.receivingDate,
    this.note,
    this.transferItems,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      id: json['id'],
      sourceWarehouse: json['source_warehouse'] != null ? Warehouse.fromJson(json['source_warehouse']) : null,
      destWarehouse: json['dest_warehouse'] != null ? Warehouse.fromJson(json['dest_warehouse']) : null,
      sendingUser: json['sending_user'] != null ? User.fromJson(json['sending_user']) : null,
      receivingUser: json['receiving_user'] != null ? User.fromJson(json['receiving_user']) : null,
      companyId: json['company_id'],
      status: json['status'],
      transferNumber: json['transfer_number'],
      reference: json['reference'],
      totalQuantity: json['total_quantity'] != null ? double.tryParse(json['total_quantity'].toString()) : null,
      creationDate: json['creation_date'] != null ? DateTime.parse(json['creation_date']) : null,
      receivingDate: json['receiving_date'] != null ? DateTime.parse(json['receiving_date']) : null,
      note: json['note'],
      transferItems: json['transfer_items'] != null
          ? List<TransferItem>.from(json['transfer_items'].map((x) => TransferItem.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source_warehouse': sourceWarehouse?.toJson(),
      'dest_warehouse': destWarehouse?.toJson(),
      'sending_user': sendingUser?.toJson(),
      'receiving_user': receivingUser?.toJson(),
      'company_id': companyId,
      'status': status,
      'transfer_number': transferNumber,
      'reference': reference,
      'total_quantity': totalQuantity,
      'creation_date': creationDate?.toIso8601String(),
      'receiving_date': receivingDate?.toIso8601String(),
      'note': note,
      'transfer_items': transferItems?.map((x) => x.toJson()).toList(),
    };
  }
}
