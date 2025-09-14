import '../CashingMethod/CashingMethodModel.dart';
import '../Client/ClientModel.dart';
import '../CommisitonMethod/CommistionMethod.dart';
import '../Company/CompanyModel.dart';
import '../CompanyHeader/CompanyHeaderModel.dart';
import '../Currency/CurrencyModel.dart';
import '../OrderLigneQuotation/OrderLigneQuotationModel.dart';
import '../PaymentTerm/PaymentTermModel.dart';
import '../PriceList/PriceListModel.dart';
import '../SalesOrder/SalesOrderModel.dart';
import '../Task/TaskModel.dart';
import '../TermsAndCondition/TermsAndConditionModel.dart';
import '../User/UserModel.dart';

enum QuotationStatusEnum { Pending, Sent, Cancelled }

class Quotation {
  int? id;
  Company? company;
  Client? client;
  PaymentTerm? paymentTerm;
  Pricelist? pricelist;
  User? salesperson;
  CommissionMethod? commissionMethod;
  CashingMethod? cashingMethod;
  Currency? currency;
  SalesOrder? salesOrder;
  CompanyHeader? companyHeader;

  String? quotationNumber;
  String? reference;
  int? clientId;
  String? validity;
  String? inputDate;
  int? paymentTermId;
  int? pricelistId;
  int? currencyId;
  String? termsAndConditionsText;
  int? salespersonId;
  int? commissionMethodId;
  int? cashingMethodId;
  double? commissionRate;
  double? commissionTotal;
  double? totalBeforeVat;
  double? specialDiscount;
  double? specialDiscountAmount;
  double? globalDiscount;
  double? globalDiscountAmount;
  double? vat;
  double? vatLebanese;
  double? total;
  QuotationStatusEnum? status;
  bool? vatExempt;
  bool? notPrinted;
  bool? printedAsVatExempt;
  bool? printedAsPercentage;
  bool? vatInclusivePrices;
  bool? beforeVatPrices;
  String? code;
  String? title;
  String? chance;
  String? deliveryTerms;
  String? cancellationReason;
  int? companyHeaderId;

  List<OrderLineQuotation>? orderLines;
  List<Task>? tasks;
  List<TermsAndCondition>? termsAndConditions;

  Quotation({
    this.id,
    this.company,
    this.client,
    this.paymentTerm,
    this.pricelist,
    this.salesperson,
    this.commissionMethod,
    this.cashingMethod,
    this.currency,
    this.salesOrder,
    this.companyHeader,
    this.quotationNumber,
    this.reference,
    this.clientId,
    this.validity,
    this.inputDate,
    this.paymentTermId,
    this.pricelistId,
    this.currencyId,
    this.termsAndConditionsText,
    this.salespersonId,
    this.commissionMethodId,
    this.cashingMethodId,
    this.commissionRate,
    this.commissionTotal,
    this.totalBeforeVat,
    this.specialDiscount,
    this.specialDiscountAmount,
    this.globalDiscount,
    this.globalDiscountAmount,
    this.vat,
    this.vatLebanese,
    this.total,
    this.status,
    this.vatExempt,
    this.notPrinted,
    this.printedAsVatExempt,
    this.printedAsPercentage,
    this.vatInclusivePrices,
    this.beforeVatPrices,
    this.code,
    this.title,
    this.chance,
    this.deliveryTerms,
    this.cancellationReason,
    this.companyHeaderId,
    this.orderLines,
    this.tasks,
    this.termsAndConditions,
  });

  factory Quotation.fromJson(Map<String, dynamic> json) {
    return Quotation(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      paymentTerm: json['paymentTerm'] != null ? PaymentTerm.fromJson(json['paymentTerm']) : null,
      pricelist: json['pricelist'] != null ? Pricelist.fromJson(json['pricelist']) : null,
      salesperson: json['salesperson'] != null ? User.fromJson(json['salesperson']) : null,
      commissionMethod: json['commissionMethod'] != null ? CommissionMethod.fromJson(json['commissionMethod']) : null,
      cashingMethod: json['cashingMethod'] != null ? CashingMethod.fromJson(json['cashingMethod']) : null,
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      salesOrder: json['salesOrder'] != null ? SalesOrder.fromJson(json['salesOrder']) : null,
      companyHeader: json['companyHeader'] != null ? CompanyHeader.fromJson(json['companyHeader']) : null,
      quotationNumber: json['quotation_number'],
      reference: json['reference'],
      clientId: json['client_id'],
      validity: json['validity'],
      inputDate: json['input_date'],
      paymentTermId: json['payment_term_id'],
      pricelistId: json['pricelist_id'],
      currencyId: json['currency_id'],
      termsAndConditionsText: json['terms_and_conditions'],
      salespersonId: json['salesperson_id'],
      commissionMethodId: json['commission_method_id'],
      cashingMethodId: json['cashing_method_id'],
      commissionRate: json['commission_rate']?.toDouble(),
      commissionTotal: json['commission_total']?.toDouble(),
      totalBeforeVat: json['total_before_vat']?.toDouble(),
      specialDiscount: json['special_discount']?.toDouble(),
      specialDiscountAmount: json['special_discount_amount']?.toDouble(),
      globalDiscount: json['global_discount']?.toDouble(),
      globalDiscountAmount: json['global_discount_amount']?.toDouble(),
      vat: json['vat']?.toDouble(),
      vatLebanese: json['vat_lebanese']?.toDouble(),
      total: json['total']?.toDouble(),
      status: json['status'] != null ? QuotationStatusEnum.values.byName(json['status']) : null,
      vatExempt: json['vat_exempt'],
      notPrinted: json['not_printed'],
      printedAsVatExempt: json['printed_as_vat_exempt'],
      printedAsPercentage: json['printed_as_percentage'],
      vatInclusivePrices: json['vat_inclusive_prices'],
      beforeVatPrices: json['before_vat_prices'],
      code: json['code'],
      title: json['title'],
      chance: json['chance'],
      deliveryTerms: json['delivery_terms'],
      cancellationReason: json['cancellation_reason'],
      companyHeaderId: json['company_header_id'],
      orderLines: json['orderLines'] != null
          ? List<OrderLineQuotation>.from(json['orderLines'].map((x) => OrderLineQuotation.fromJson(x)))
          : [],
      tasks: json['tasks'] != null ? List<Task>.from(json['tasks'].map((x) => Task.fromJson(x))) : [],
      termsAndConditions: json['termsAndConditions'] != null
          ? List<TermsAndCondition>.from(json['termsAndConditions'].map((x) => TermsAndCondition.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'client': client?.toJson(),
      'paymentTerm': paymentTerm?.toJson(),
      'pricelist': pricelist?.toJson(),
      'salesperson': salesperson?.toJson(),
      'commissionMethod': commissionMethod?.toJson(),
      'cashingMethod': cashingMethod?.toJson(),
      'currency': currency?.toJson(),
      'salesOrder': salesOrder?.toJson(),
      'companyHeader': companyHeader?.toJson(),
      'quotation_number': quotationNumber,
      'reference': reference,
      'client_id': clientId,
      'validity': validity,
      'input_date': inputDate,
      'payment_term_id': paymentTermId,
      'pricelist_id': pricelistId,
      'currency_id': currencyId,
      'terms_and_conditions': termsAndConditionsText,
      'salesperson_id': salespersonId,
      'commission_method_id': commissionMethodId,
      'cashing_method_id': cashingMethodId,
      'commission_rate': commissionRate,
      'commission_total': commissionTotal,
      'total_before_vat': totalBeforeVat,
      'special_discount': specialDiscount,
      'special_discount_amount': specialDiscountAmount,
      'global_discount': globalDiscount,
      'global_discount_amount': globalDiscountAmount,
      'vat': vat,
      'vat_lebanese': vatLebanese,
      'total': total,
      'status': status?.name,
      'vat_exempt': vatExempt,
      'not_printed': notPrinted,
      'printed_as_vat_exempt': printedAsVatExempt,
      'printed_as_percentage': printedAsPercentage,
      'vat_inclusive_prices': vatInclusivePrices,
      'before_vat_prices': beforeVatPrices,
      'code': code,
      'title': title,
      'chance': chance,
      'delivery_terms': deliveryTerms,
      'cancellation_reason': cancellationReason,
      'company_header_id': companyHeaderId,
      'orderLines': orderLines?.map((x) => x.toJson()).toList(),
      'tasks': tasks?.map((x) => x.toJson()).toList(),
      'termsAndConditions': termsAndConditions?.map((x) => x.toJson()).toList(),
    };
  }
}
