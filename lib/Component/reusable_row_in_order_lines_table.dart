import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Backend/ProductsBackend/get_an_item.dart';
import '../Controllers/home_controller.dart';
import '../Widgets/TransferWidgets/reusable_show_info_card.dart';

class ReusableRowInOrderLinesTable extends StatefulWidget {
  const ReusableRowInOrderLinesTable({
    super.key,
    required this.info,
    required this.index,
  });
  final Map info;
  final int index;

  @override
  State<ReusableRowInOrderLinesTable> createState() =>
      _ReusableRowInOrderLinesTableState();
}
class _ReusableRowInOrderLinesTableState extends State<ReusableRowInOrderLinesTable> {
  String itemCode = '';
  getItemFromBack() async {
    var res = await getAnItem('${widget.info['item_id']}');
    if (res['success'] == true) {
      setState(() {
        itemCode = res['data']['mainCode'];
      });
    }
  }
  HomeController homeController=Get.find();
  @override
  void initState() {
    if (widget.info['line_type_id'] == 2) {
      getItemFromBack();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child:
      widget.info['line_type_id'] == 2
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: homeController.isMobile.value?20:MediaQuery.of(context).size.width * 0.02,
            height: 20,
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/newRow.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          ReusableShowInfoCard(
            text: itemCode,
            width:homeController.isMobile.value?140: MediaQuery.of(context).size.width * 0.1,
          ),
          ReusableShowInfoCard(
            text: '${widget.info['item_description'] ?? ''}',
            width:homeController.isMobile.value?140: MediaQuery.of(context).size.width * 0.3,
          ),
          ReusableShowInfoCard(
            text: '${widget.info['item_quantity'] ?? '0'}',
            width: homeController.isMobile.value?140:MediaQuery.of(context).size.width * 0.1,
          ),
          ReusableShowInfoCard(
            text: '${widget.info['item_unit_price'] ?? '0'}',
            width:homeController.isMobile.value?140: MediaQuery.of(context).size.width * 0.1,
          ),
          ReusableShowInfoCard(
            text: '${widget.info['item_discount'] ?? '0'}',
            width: homeController.isMobile.value?140:MediaQuery.of(context).size.width * 0.1,
          ),
          ReusableShowInfoCard(
            text: '${widget.info['item_total'] ?? '0'}',
            width:homeController.isMobile.value?140: MediaQuery.of(context).size.width * 0.1,
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: homeController.isMobile.value?20:MediaQuery.of(context).size.width * 0.02,
            height: 20,
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/newRow.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.82,
            height: 47,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withAlpha((0.1 * 255).toInt()),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text('      ${widget.info['title'] ?? ''}')],
            ),
          ),
          // ReusableShowInfoCard(text:,width:MediaQuery.of(context).size.width* 0.81 ,),
        ],
      ),
    );
  }
}
