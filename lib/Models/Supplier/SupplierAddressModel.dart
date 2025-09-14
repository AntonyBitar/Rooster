import '../Company/CompanyModel.dart';
import 'SupplierModel.dart';

class SupplierAddress {
  int? id;
  Supplier? supplier;
  String? type="1";
  String? name;
  String? title;
  String? jobPosition;
  String? phoneCode;
  String? phoneNumber;
  String? extension;
  String? mobileCode;
  String? mobileNumber;
  String? email;
  String? deliveryAddress;
  String? internalNote;
  SupplierAddress copy() {
    return SupplierAddress(

      id: id,
      supplier: supplier, // shallow copy (same supplier reference)
      type: type,
      name: name,
      title: title,
      jobPosition: jobPosition,
      phoneCode: phoneCode,
      phoneNumber: phoneNumber,
      extension: extension,
      mobileCode: mobileCode,
      mobileNumber: mobileNumber,
      email: email,
      deliveryAddress: deliveryAddress,
      internalNote: internalNote,
    );
  }
  SupplierAddress({
    this.id,
    this.supplier,
    this.type,
    this.name,
    this.title,
    this.jobPosition,
    this.phoneCode,
    this.phoneNumber,
    this.extension,
    this.mobileCode,
    this.mobileNumber,
    this.email,
    this.deliveryAddress,
    this.internalNote,
  });


  factory SupplierAddress.fromJson(Map<String, dynamic> json) {
    return SupplierAddress(
      id: json['id'],
      //supplier: json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null,
      type: json['type'].toString(),
      name: json['name'],
      title: json['title'],
      jobPosition: json['jobPosition'],
      phoneCode: json['phoneCode']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
      extension: json['extension']?.toString(),
      mobileCode: json['mobileCode']?.toString(),
      mobileNumber: json['mobileNumber']?.toString(),
      email: json['email'],
      deliveryAddress: json['deliveryAddress'],
      internalNote: json['internalNote'],
    );
  }

  Map<String, dynamic> toJson() {
    print(supplier?.id);
    return {
      'id': id,
      'supplier_id': supplier?.id,
      'type': type,
      'name': name,
      'title': title,
      'job_position': jobPosition,
      'phone_code': phoneCode,
      'phone_number': phoneNumber,
      'extension': extension,
      'mobile_code': mobileCode,
      'mobile_number': mobileNumber,
      'email': email,
      'delivery_address': deliveryAddress,
      'internal_note': internalNote,
    };
  }
}
