import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/home_controller.dart';
import '../Models/Supplier/SupplierModel.dart';
import '../Widgets/table_item.dart';
import '../const/colors.dart';

class SupplierAsRowInTable extends StatefulWidget {
  const SupplierAsRowInTable({
    super.key,
    required this.isSelected,
    required this.supplier,
    required this.onTap,
    this.isDesktop = true,
  });

  final VoidCallback onTap;
  final Supplier supplier;
  final bool isSelected;
  final bool isDesktop;

  @override
  State<SupplierAsRowInTable> createState() => _SupplierAsRowInTableState();
}

class _SupplierAsRowInTableState extends State<SupplierAsRowInTable> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final HomeController homeCont = Get.find<HomeController>();

    double bigWidth = homeCont.isMenuOpened
        ? MediaQuery.of(context).size.width * 0.25
        : MediaQuery.of(context).size.width * 0.28;

    double smallWidth = homeCont.isMenuOpened
        ? MediaQuery.of(context).size.width * 0.09
        : MediaQuery.of(context).size.width * 0.12;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isDesktop ? 5 : 0,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected?
              Primary.primary
              .withAlpha(
              (0.5 * 255)
              .toInt())
                : _isHovered
                ? Primary.primary
                .withAlpha(
                (0.2 * 255)
                    .toInt())
                : Colors.white, // Default
            borderRadius: const BorderRadius.all(Radius.circular(0)),
          ),
          child: Row(
            children: [
              TableItem(
                isCentered: false,
                text: '${widget.supplier.supplierNumber}',
                width: widget.isDesktop ? smallWidth : 140,
              ),
              TableItem(
                isCentered: false,
                text: '${widget.supplier.name}',
                width: widget.isDesktop ? bigWidth : 140,
              ),
              TableItem(
                text: widget.supplier.mobileNumber != null
                    ? '${widget.supplier.mobileCode}-${widget.supplier.mobileNumber}'
                    : '',
                width: widget.isDesktop ? smallWidth : 140,
              ),
              TableItem(
                text: '',
                width: widget.isDesktop ? smallWidth : 140,
              ),
              TableItem(
                text: '',
                width: widget.isDesktop ? smallWidth : 140,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
