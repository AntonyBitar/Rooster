import 'package:flutter/cupertino.dart';
import '../Controllers/client_controller.dart';
import '../Controllers/home_controller.dart';
import '../Screens/Client/accounts_page.dart';
import '../Screens/PurchaseInvoice/purchase_invoice_summary.dart';
import '../Widgets/TransferWidgets/reusable_show_info_card.dart';
import '../Widgets/page_title.dart';
import '../Widgets/table_title.dart';
import '../const/Sizes.dart';
import '../const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MobileUpdateTransactionQuotationDialog extends StatelessWidget {
  const MobileUpdateTransactionQuotationDialog({
    super.key,
    required this.quotationIndex,
  });
  final int quotationIndex;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientController>(
      builder: (cont) {
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.symmetric( vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PageTitle(
                      text:
                      'quotation'
                          .tr, //cont.transactionsQuotations[quotationIndex]['quotationNumber']
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: Primary.primary,
                        radius: 15,
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                gapH40,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Others.divider),
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        cont.transactionsQuotations[quotationIndex]['quotationNumber'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: TypographyColor.titleTable,
                        ),
                      ),
                      gapH6,

                      // : const CircularProgressIndicator(),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ref'.tr),
                            ReusableShowInfoCard(
                              text:
                              cont.transactionsQuotations[quotationIndex]['reference'] ??
                                  '',
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        ),
                      ),
                      gapH6,

                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('currency'.tr),
                            ReusableShowInfoCard(
                              text:
                              cont.transactionsQuotations[quotationIndex]['currency']['name'] ??
                                  '',
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        ),
                      ),
                      gapH6,

                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('validity'.tr),
                            ReusableShowInfoCard(
                              text:
                              cont.transactionsQuotations[quotationIndex]['validity'] ??
                                  '',
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        ),
                      ),
                      gapH6,

                      gapH6,
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('code'.tr),
                            ReusableShowInfoCard(
                              text: cont.selectedClient['clientNumber'],
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        ),
                      ),
                      gapH6,

                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.516,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('name'.tr),
                            ReusableShowInfoCard(
                              text:
                              cont.transactionsQuotations[quotationIndex]['client']['name'] ??
                                  '',
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        ),
                      ),
                      gapH6,
                      Column(
                        children: [
                          SizedBox(
                            // width: MediaQuery.of(context).size.width * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('address'.tr),
                                Text(
                                  ': ${cont.selectedClient['country'] ?? ''}${cont.selectedClient['city'] == null ? '' : '-'} ${cont.selectedClient['city'] ?? ''}',
                                ),
                              ],
                            ),
                          ),
                          gapH6,
                          SizedBox(
                            // width: MediaQuery.of(context).size.width * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('email'.tr),
                                Text(
                                  ': ${cont.selectedClient['email'] ?? ''}',
                                ),
                              ],
                            ),
                          ),
                          gapH6,
                          SizedBox(
                            // width: MediaQuery.of(context).size.width * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('phone'.tr),
                                Text(
                                  cont.selectedClient['phoneNumber'] == null
                                      ? ':'
                                      : ': ${cont.selectedClient['phoneCode'] ?? ''} ${cont.selectedClient['phoneNumber'] ?? ''}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      gapH6,
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Vat exempt'.tr),
                            ReusableShowInfoCard(
                              text:
                              cont.transactionsQuotations[quotationIndex]['vatExempt']
                                  .toString(),
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                gapH20,
                ReusableChip(name: 'order_lines'.tr, isDesktop: false),
                SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.4,
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                          color: Primary.primary,
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Row(
                                        children: [
                                          TableTitle(
                                            text: 'item_code'.tr,
                                            width: 140,
                                          ),
                                          TableTitle(
                                            text: 'description'.tr,
                                            width: 140,
                                          ),
                                          TableTitle(
                                            text: 'quantity'.tr,
                                            width: 140,
                                          ),
                                          TableTitle(
                                            text : 'unit_price'.tr,
                                            width: 140,
                                          ),
                                          TableTitle(
                                            text: '${'discount'.tr}%',
                                            width: 140,
                                          ),
                                          TableTitle(
                                            text: 'total'.tr,
                                            width: 140,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        color: Colors.white,
                                        child:Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children:  List.generate(
                                            cont.transactionsQuotations[quotationIndex]['orderLines']
                                                .length,
                                                (index) => ReusableRowInOrderLinesTable(
                                              index: index,
                                              info:
                                              cont.transactionsQuotations[quotationIndex]['orderLines'][index],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    )),
                // Container(
                //   // width: 4* MediaQuery.of(context).size.width * 0.1,
                //   padding: const EdgeInsets.symmetric(vertical: 15),
                //   decoration: BoxDecoration(
                //     color: Primary.primary,
                //     borderRadius: const BorderRadius.all(Radius.circular(6)),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       TableTitle(
                //         text: 'item_code'.tr,
                //         width: MediaQuery.of(context).size.width * 0.1,
                //       ),
                //       TableTitle(
                //         text: 'description'.tr,
                //         width: MediaQuery.of(context).size.width * 0.3,
                //       ),
                //       TableTitle(
                //         text: 'quantity'.tr,
                //         width: MediaQuery.of(context).size.width * 0.1,
                //       ),
                //       TableTitle(
                //         text: 'unit_price'.tr,
                //         width: MediaQuery.of(context).size.width * 0.1,
                //       ),
                //       TableTitle(
                //         text: '${'discount'.tr}%',
                //         width: MediaQuery.of(context).size.width * 0.1,
                //       ),
                //       TableTitle(
                //         text: 'total'.tr,
                //         width: MediaQuery.of(context).size.width * 0.1,
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   height:200,
                //   // cont.transactionsQuotations[quotationIndex]['orderLines'].length * 75,
                //   // width: 4* MediaQuery.of(context).size.width * 0.1,
                //   child: ListView.builder(
                //     itemCount:
                //     cont
                //         .transactionsQuotations[quotationIndex]['orderLines']
                //         .length, //products is data from back res
                //     itemBuilder:
                //         (context, index) => ReusableRowInOrderLinesTable(
                //       index: index,
                //       info:
                //       cont.transactionsQuotations[quotationIndex]['orderLines'][index],
                //     ),
                //   ),
                // ),
                gapH24,
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'terms_conditions'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          color: TypographyColor.titleTable,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapH16,
                      ReusableShowInfoCard(
                        text:
                        cont.transactionsQuotations[quotationIndex]['termsAndConditions']??'',
                        // .toString(),
                        width: MediaQuery.of(context).size.width,
                      ),
                      gapH16,
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Primary.p20,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('total_before_vat'.tr),
                          // ReusableShowInfoCard(text: '${quotationController.totalQuotation}', width: MediaQuery.of(context).size.width * 0.1),
                          ReusableShowInfoCard(
                            text:
                            cont.transactionsQuotations[quotationIndex]['totalBeforeVat']
                                .toString()
                                .toString(),
                            width:
                            MediaQuery.of(context).size.width * 0.15,
                          ),
                        ],
                      ),
                      gapH6,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('global_disc'.tr),
                          Row(
                            children: [
                              SizedBox(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                                child: ReusableShowInfoCard(
                                  text:
                                  cont.transactionsQuotations[quotationIndex]['globalDiscount']
                                      .toString()
                                      .toString(),
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.15,
                                ),
                              ),
                              gapW10,
                              ReusableShowInfoCard(
                                text:
                                cont.transactionsQuotations[quotationIndex]['globalDiscountAmount']
                                    .toString(),
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      gapH6,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('special_disc'.tr),
                          Row(
                            children: [
                              SizedBox(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                                child: ReusableShowInfoCard(
                                  text:
                                  cont.transactionsQuotations[quotationIndex]['specialDiscount']
                                      .toString()
                                      .toString(),
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.15,
                                ),
                              ),
                              gapW10,
                              ReusableShowInfoCard(
                                text:
                                cont.transactionsQuotations[quotationIndex]['specialDiscountAmount']
                                    .toString(),
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      gapH6,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('vat_11'.tr),
                          Row(
                            children: [
                              ReusableShowInfoCard(
                                text:
                                cont.transactionsQuotations[quotationIndex]['vat']
                                    .toString(),
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                              ),
                              gapW10,
                              ReusableShowInfoCard(
                                text:
                                cont.transactionsQuotations[quotationIndex]['vatLebanese']
                                    .toString(),
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      gapH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'total_amount'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              color: Primary.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            // '${'usd'.tr} 0.00',
                            '${'usd'.tr} ${cont.transactionsQuotations[quotationIndex]['total'].toString()}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Primary.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
