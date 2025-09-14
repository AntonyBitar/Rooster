import 'package:flutter/cupertino.dart';
import '../Controllers/client_controller.dart';
import '../Controllers/home_controller.dart';
import '../Screens/Client/accounts_page.dart';
import '../Widgets/page_title.dart';
import '../Widgets/table_title.dart';
import '../const/Sizes.dart';
import '../const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UpdateTransactionOrderDialog extends StatelessWidget {
  const UpdateTransactionOrderDialog({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return GetBuilder<ClientController>(
      builder: (cont) {
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.9,
          margin: EdgeInsets.symmetric(
            horizontal: homeController.isMobile.value ? 0 : 50,
            vertical: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PageTitle(
                      text: cont.transactionsOrders[index]['orderNumber'],
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
                ReusableInfoText(
                  keyText: 'Status',
                  value: cont.transactionsOrders[index]['status'],
                ),
                gapH10,
                ReusableInfoText(
                  keyText: 'Note',
                  value: cont.transactionsOrders[index]['note'] ?? '',
                ),
                gapH10,
                ReusableInfoText(
                  keyText: 'Opened At',
                  value: cont.transactionsOrders[index]['date'],
                ),
                gapH10,
                ReusableInfoText(
                  keyText: 'Closed At',
                  value: cont.transactionsOrders[index]['closedAt'] ?? '',
                ),
                gapH10,
                ReusableInfoText(
                  keyText: 'Total',
                  value:
                  '${cont.transactionsOrders[index]['usdTotal'] ?? '0'} (USD)       '
                      '${cont.transactionsOrders[index]['otherCurrencyTotal'] ?? '0'} (LBP)',
                  // value: cont.transactionsOrders[index]['usdTotal'].toString(),
                ),
                gapH10,
                // ReusableInfoText(
                //   keyText: 'Total (LBP)',
                //   value: cont.transactionsOrders[index]['otherCurrencyTotal']
                //       .toString(),
                // ),
                ReusableInfoText(
                  keyText: 'Discount',
                  value:
                  '${cont.transactionsOrders[index]['usdDiscountValue'] ?? '0'} (USD)       '
                      '${cont.transactionsOrders[index]['otherCurrencyDiscountValue'] ?? '0'} (LBP)',
                  // value: cont.transactionsOrders[index]['usdDiscountValue']
                  //     .toString(),
                ),
                gapH10,
                // ReusableInfoText(
                //   keyText: 'Discount (LBP)',
                //   value: cont.transactionsOrders[index]
                //           ['otherCurrencyDiscountValue']
                //       .toString(),
                // ),
                ReusableInfoText(
                  keyText: 'Tax',
                  value:
                  '${cont.transactionsOrders[index]['usdTaxValue'] ?? '0'} (USD)       '
                      '${cont.transactionsOrders[index]['otherCurrencyTaxValue'] ?? '0'} (LBP)',
                ),
                gapH10,
                // ReusableInfoText(
                //   keyText: 'Tax (LBP)',
                //   value: cont.transactionsOrders[index]['otherCurrencyTaxValue']
                //       .toString(),
                // ),
                ReusableInfoText(
                  keyText: 'Cashier',
                  value: cont.transactionsOrders[index]['cashier'],
                ),
                gapH10,
                ReusableInfoText(
                  keyText: 'Finished By',
                  value: cont.transactionsOrders[index]['finishedBy'],
                ),
                gapH10,
                ReusableInfoText(
                  keyText: 'DOC Number',
                  value: cont.transactionsOrders[index]['docNumber'],
                ),
                gapH10,
                ReusableInfoText(
                  keyText: 'Discount Type',
                  value: cont.transactionsOrders[index]['discountType'] ?? '',
                ),
                gapH10,
                const Text(
                  'Items: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                homeController.isMobile.value
                    ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    // horizontal: 10,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Primary.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      TableTitle(
                                        text: 'item_name'.tr,
                                        width: 140,
                                      ),
                                      TableTitle(
                                        text: 'quantity'.tr,
                                        width: 140,
                                      ),
                                      TableTitle(
                                        text: '${'price'.tr} (after tax)',
                                        width: 140,
                                      ),
                                      TableTitle(
                                        text: '${'discount'.tr}%',
                                        width: 140,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: List.generate(
                                      cont
                                          .transactionsOrders[index]['orderItems']
                                          .length,
                                          (ind) => ReusableItemRow(
                                        index: ind,
                                        product:
                                        cont.transactionsOrders[index]['orderItems'][ind],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : Container(
                  width: 4 * MediaQuery.of(context).size.width * 0.1,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Primary.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TableTitle(
                        text: 'item_name'.tr,
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      TableTitle(
                        text: 'quantity'.tr,
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      TableTitle(
                        text: '${'price'.tr} (after tax)',
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      TableTitle(
                        text: '${'discount'.tr}%',
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: 4 * MediaQuery.of(context).size.width * 0.1,
                  child: ListView.builder(
                    itemCount:
                    cont
                        .transactionsOrders[index]['orderItems']
                        .length, //products is data from back res
                    itemBuilder:
                        (context, ind) => ReusableItemRow(
                      index: ind,
                      product:
                      cont.transactionsOrders[index]['orderItems'][ind],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 500,
                //     width: 500,
                //     child: ListView.builder(
                //   itemCount: cont.transactionsOrders[index]['orderItems'].length,
                //   itemBuilder: (context, index) => ReusableItemRow(
                //     product: cont.transactionsOrders[index]['orderItems'][index],
                //   ),
                // ))
              ],
            ),
          ),
        );
      },
    );
  }
}
