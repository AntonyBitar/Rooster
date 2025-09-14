import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controllers/home_controller.dart';
import '../Widgets/table_item.dart';
import '../const/colors.dart';

class ReusableItemRow extends StatelessWidget {
  const ReusableItemRow({
    super.key,
    required this.product,
    required this.index,
  });
  final Map product;
  final int index;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: (index % 2 == 0) ? Primary.p10 : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TableItem(
            text: '${product['item_name'] ?? ''}',
            width:
            homeController.isMobile.value
                ? 140
                : MediaQuery.of(context).size.width * 0.1,
          ),
          TableItem(
            text: '${product['quantity'] ?? ''}',
            width:
            homeController.isMobile.value
                ? 140
                : MediaQuery.of(context).size.width * 0.1,
          ),
          TableItem(
            text:
            '${product['price_after_tax'] ?? ''} (${product['price_currency']['name']})',
            width:
            homeController.isMobile.value
                ? 140
                : MediaQuery.of(context).size.width * 0.1,
          ),
          TableItem(
            text: '${product['item_discount'] ?? '0'}',
            width:
            homeController.isMobile.value
                ? 140
                : MediaQuery.of(context).size.width * 0.1,
          ),
        ],
      ),
    );

    //   Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       children: [
    //         Text(
    //           '${product['item_name'] ?? ''} ',
    //           style: const TextStyle(
    //             fontSize: 15,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ],
    //     ),
    //     //Text(
    //     //                 widget.product['posCurrency'] != null
    //     //                     ? ' ${
    //     //                     widget.product['posCurrency']['symbol']=='\$'?usdPrice:otherCurrencyPrice
    //     //                     // numberWithComma('${widget.product['unitPrice']?? ''}' )
    //     //                      }'
    //     //                     '${ ' ${widget.product['posCurrency']['symbol'] ?? ''}' }': '',
    //     //               ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Row(
    //           children: [
    //             SizedBox(
    //               width: Sizes.deviceWidth * 0.15,
    //               child: Text(
    //                 '${product['quantity']} ${'units'.tr} '
    //                 'x ${product['price_after_tax']} '
    //                 '${product['price_currency']['name']}/${'units'.tr}',
    //                 style: const TextStyle(
    //                   fontSize: 12,
    //                 ),
    //               ),
    //             ),
    //             // controller.discountValuesMap.containsKey(product['id'])
    //             product['item_discount'] != null
    //                 ? Text(
    //                     '     W/ ${product['item_discount']}%',
    //                     // 'W/ ${controller.discountValuesMap[product['id']]}${'discount'.tr}',
    //                     style: const TextStyle(
    //                         fontSize: 12, fontWeight: FontWeight.bold),
    //                   )
    //                 : const SizedBox()
    //           ],
    //         ),
    //         SizedBox(
    //           width: Sizes.deviceWidth * 0.07,
    //           child: Text(
    //             '${double.parse(product['price_after_tax'])*double.parse(product['quantity'])}',
    //             // '${(product['unitPrice']+tax) * controller.orderItemsQuantities[product['id']]} ${product['priceCurrency']['symbol']}',
    //             textAlign: TextAlign.end,
    //             style: const TextStyle(
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.black),
    //           ),
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }
}
