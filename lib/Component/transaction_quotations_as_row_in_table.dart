import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../Controllers/home_controller.dart';
import '../Screens/Client/accounts_page.dart';
import '../Widgets/table_item.dart';
class TransactionQuotationsAsRowInTable extends StatelessWidget {
  const TransactionQuotationsAsRowInTable({
    super.key,
    required this.info,
    required this.index,
  });
  final Map info;
  final int index;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return InkWell(
      onTap: () {
        showDialog<String>(
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(9)),
            ),
            elevation: 0,
            content:homeController.isMobile.value?MobileUpdateTransactionQuotationDialog(quotationIndex: index,): UpdateTransactionQuotationDialog(
              quotationIndex: index,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        child: GetBuilder<HomeController>(
            builder: (homeCont) {
              double bigWidth=homeCont.isMenuOpened? MediaQuery.of(context).size.width * 0.12:MediaQuery.of(context).size.width * 0.16;
              double smallWidth=homeCont.isMenuOpened? MediaQuery.of(context).size.width * 0.09:MediaQuery.of(context).size.width * 0.11;
              return Row(
                children: [
                  TableItem(
                    text: '${info['createdAtDate'] ?? ''}',
                    width:
                    homeController.isMobile.value
                        ? 140
                        : smallWidth,
                  ),
                  TableItem(
                    text: '${info['quotationNumber'] ?? ''}',
                    width:
                    homeController.isMobile.value
                        ? 140
                        : smallWidth,
                  ),
                  TableItem(
                    text: '${info['reference'] ?? ''}',
                    width:
                    homeController.isMobile.value
                        ? 140
                        : smallWidth,
                  ),
                  TableItem(
                    text: 'quotation',
                    width:
                    homeController.isMobile.value
                        ? 140
                        : smallWidth,
                  ),
                  TableItem(
                    text: '', // '${info['transaction_label'] ?? ''}',
                    width:
                    homeController.isMobile.value
                        ? 250
                        : smallWidth,
                  ),
                  TableItem(
                    text:
                    info['currency']['name'] == 'USD'
                        ? '${info['total'] ?? ''}'
                        : '',
                    width:
                    homeController.isMobile.value
                        ? 150
                        : bigWidth,
                  ),
                  TableItem(
                    text:
                    info['currency']['name'] == 'USD'
                        ? ''
                        : '${info['total'] ?? ''} ${info['currency']['name'] ?? ''}',
                    width:
                    homeController.isMobile.value
                        ? 200
                        : bigWidth,
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
