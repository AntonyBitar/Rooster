import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../Controllers/home_controller.dart';
import '../Screens/Client/accounts_page.dart';
import '../Widgets/table_item.dart';
import '../const/functions.dart';
class TransactionOrderAsRowInTable extends StatelessWidget {
  const TransactionOrderAsRowInTable({
    super.key,
    required this.info,
    required this.index,
  });
  final Map info;
  final int index;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    print('info $info');
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
            content: UpdateTransactionOrderDialog(index: index),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        child:  GetBuilder<HomeController>(
            builder: (homeCont) {
              double bigWidth=homeCont.isMenuOpened? MediaQuery.of(context).size.width * 0.12:MediaQuery.of(context).size.width * 0.16;
              double smallWidth=homeCont.isMenuOpened? MediaQuery.of(context).size.width * 0.09:MediaQuery.of(context).size.width * 0.11;
              return Row(
                children: [
                  TableItem(
                    text: '${info['date'] ?? ''}',
                    width:
                    homeController.isMobile.value
                        ? 140
                        : smallWidth,
                  ),
                  TableItem(
                    text: '${info['orderNumber'] ?? ''}',
                    width:
                    homeController.isMobile.value
                        ? 140
                        :smallWidth,
                  ),
                  TableItem(
                    text: '',
                    width:
                    homeController.isMobile.value
                        ? 140
                        : smallWidth,
                  ),
                  TableItem(
                    text: 'order',
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
                    text: numberWithComma('${info['primaryCurrencyTotal'] ?? ''}'),
                    width:
                    homeController.isMobile.value
                        ? 150
                        : bigWidth,
                  ),
                  TableItem(
                    text: '${info['posCurrencyTotal']!=null ? numberWithComma('${info['posCurrencyTotal']}'):''} '
                        '${info['posCurrency']!=null?info['posCurrency']['name']:''}',
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
