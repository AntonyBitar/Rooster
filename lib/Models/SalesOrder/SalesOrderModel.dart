import '../CashingMethod/CashingMethodModel.dart';
import '../Client/ClientModel.dart';
import '../CommisitonMethod/CommistionMethod.dart';
import '../Company/CompanyModel.dart';
import '../Currency/CurrencyModel.dart';
import '../PaymentTerm/PaymentTermModel.dart';
import '../PriceList/PriceListModel.dart';
import '../Quotation/QuotationModel.dart';
import '../User/UserModel.dart';
import '../orderLineSalesOrder/OrderLineSalesOrderModel.dart';

class SalesOrder {
  int? id;
  Company? company;
  int? companyId;
  Client? client;
  int? clientId;
  PaymentTerm? paymentTerm;
  int? paymentTermId;
  Pricelist? pricelist;
  int? pricelistId;
  User? salesperson;
  int? salespersonId;
  CommissionMethod? commissionMethod;
  int? commissionMethodId;
  CashingMethod? cashingMethod;
  int? cashingMethodId;
  Currency? currency;
  int? currencyId;
  Quotation? quotation;
  int? quotationId;
  String? salesOrderNumber;
  String? reference;
  String? validity;
  String? termsAndConditions;
  double? commissionRate;
  double? commissionTotal;
  double? specialDiscount;
  double? specialDiscountAmount;
  double? globalDiscount;
  double? globalDiscountAmount;
  double? vat;
  double? vatLebanese;
  double? total;
  String? status;
  double? totalBeforeVat;
  bool? vatExempt;
  bool? notPrinted;
  bool? printedAsVatExempt;
  bool? printedAsPercentage;
  bool? vatInclusivePrices;
  bool? beforeVatPrices;
  String? code;
  String? title;
  String? inputDate;

  List<OrderLineSalesOrder>? orderLines;

  SalesOrder({
    this.id,
    this.company,
    this.companyId,
    this.client,
    this.clientId,
    this.paymentTerm,
    this.paymentTermId,
    this.pricelist,
    this.pricelistId,
    this.salesperson,
    this.salespersonId,
    this.commissionMethod,
    this.commissionMethodId,
    this.cashingMethod,
    this.cashingMethodId,
    this.currency,
    this.currencyId,
    this.quotation,
    this.quotationId,
    this.salesOrderNumber,
    this.reference,
    this.validity,
    this.termsAndConditions,
    this.commissionRate,
    this.commissionTotal,
    this.specialDiscount,
    this.specialDiscountAmount,
    this.globalDiscount,
    this.globalDiscountAmount,
    this.vat,
    this.vatLebanese,
    this.total,
    this.status,
    this.totalBeforeVat,
    this.vatExempt,
    this.notPrinted,
    this.printedAsVatExempt,
    this.printedAsPercentage,
    this.vatInclusivePrices,
    this.beforeVatPrices,
    this.code,
    this.title,
    this.inputDate,
    this.orderLines,
  });

  factory SalesOrder.fromJson(Map<String, dynamic> json) {
    return SalesOrder(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      companyId: json['company_id'],
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      clientId: json['client_id'],
      paymentTerm: json['paymentTerm'] != null ? PaymentTerm.fromJson(json['paymentTerm']) : null,
      paymentTermId: json['payment_term_id'],
      pricelist: json['pricelist'] != null ? Pricelist.fromJson(json['pricelist']) : null,
      pricelistId: json['pricelist_id'],
      salesperson: json['salesperson'] != null ? User.fromJson(json['salesperson']) : null,
      salespersonId: json['salesperson_id'],
      commissionMethod: json['commissionMethod'] != null ? CommissionMethod.fromJson(json['commissionMethod']) : null,
      commissionMethodId: json['commission_method_id'],
      cashingMethod: json['cashingMethod'] != null ? CashingMethod.fromJson(json['cashingMethod']) : null,
      cashingMethodId: json['cashing_method_id'],
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      currencyId: json['currency_id'],
      quotation: json['quotation'] != null ? Quotation.fromJson(json['quotation']) : null,
      quotationId: json['quotation_id'],
      salesOrderNumber: json['sales_order_number'],
      reference: json['reference'],
      validity: json['validity'],
      termsAndConditions: json['terms_and_conditions'],
      commissionRate: json['commission_rate']?.toDouble(),
      commissionTotal: json['commission_total']?.toDouble(),
      specialDiscount: json['special_discount']?.toDouble(),
      specialDiscountAmount: json['special_discount_amount']?.toDouble(),
      globalDiscount: json['global_discount']?.toDouble(),
      globalDiscountAmount: json['global_discount_amount']?.toDouble(),
      vat: json['vat']?.toDouble(),
      vatLebanese: json['vat_lebanese']?.toDouble(),
      total: json['total']?.toDouble(),
      status: json['status'],
      totalBeforeVat: json['total_before_vat']?.toDouble(),
      vatExempt: json['vat_exempt'],
      notPrinted: json['not_printed'],
      printedAsVatExempt: json['printed_as_vat_exempt'],
      printedAsPercentage: json['printed_as_percentage'],
      vatInclusivePrices: json['vat_inclusive_prices'],
      beforeVatPrices: json['before_vat_prices'],
      code: json['code'],
      title: json['title'],
      inputDate: json['input_date'],
      orderLines: json['orderLines'] != null
          ? List<OrderLineSalesOrder>.from(json['orderLines'].map((x) => OrderLineSalesOrder.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'company_id': companyId,
      'client': client?.toJson(),
      'client_id': clientId,
      'paymentTerm': paymentTerm?.toJson(),
      'payment_term_id': paymentTermId,
      'pricelist': pricelist?.toJson(),
      'pricelist_id': pricelistId,
      'salesperson': salesperson?.toJson(),
      'salesperson_id': salespersonId,
      'commissionMethod': commissionMethod?.toJson(),
      'commission_method_id': commissionMethodId,
      'cashingMethod': cashingMethod?.toJson(),
      'cashing_method_id': cashingMethodId,
      'currency': currency?.toJson(),
      'currency_id': currencyId,
      'quotation': quotation?.toJson(),
      'quotation_id': quotationId,
      'sales_order_number': salesOrderNumber,
      'reference': reference,
      'validity': validity,
      'terms_and_conditions': termsAndConditions,
      'commission_rate': commissionRate,
      'commission_total': commissionTotal,
      'special_discount': specialDiscount,
      'special_discount_amount': specialDiscountAmount,
      'global_discount': globalDiscount,
      'global_discount_amount': globalDiscountAmount,
      'vat': vat,
      'vat_lebanese': vatLebanese,
      'total': total,
      'status': status,
      'total_before_vat': totalBeforeVat,
      'vat_exempt': vatExempt,
      'not_printed': notPrinted,
      'printed_as_vat_exempt': printedAsVatExempt,
      'printed_as_percentage': printedAsPercentage,
      'vat_inclusive_prices': vatInclusivePrices,
      'before_vat_prices': beforeVatPrices,
      'code': code,
      'title': title,
      'input_date': inputDate,
      'orderLines': orderLines?.map((x) => x.toJson()).toList(),
    };
  }
}
