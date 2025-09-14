import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Component/reusable_contact_section.dart';
import '../Models/Supplier/SupplierAddressModel.dart';
import '../Widgets/reusable_add_card.dart';
import '../const/Sizes.dart';

class ContactsAndAddressesSection extends StatefulWidget {
  final List<SupplierAddress> supplierAddresses;

  const ContactsAndAddressesSection({
    super.key,
    required this.supplierAddresses,
  });

  @override
  State<ContactsAndAddressesSection> createState() =>
      _ContactsAndAddressesSectionState();
}

class _ContactsAndAddressesSectionState
    extends State<ContactsAndAddressesSection> {

  void addNewContact() {
    setState(() {
      widget.supplierAddresses.add(SupplierAddress());
    });
  }

  void removeContact(int index) {
    setState(() {
      widget.supplierAddresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.supplierAddresses.isEmpty ? 20 : 420,
          child: ListView.builder(
            itemCount: widget.supplierAddresses.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ReusableContactSectionSupplier(supplierAddress:widget.supplierAddresses[index],onRemove:() => removeContact(index)),
          ),
        ),
        gapH16,
        ReusableAddCard(
          text: 'add_new_contact'.tr,
          onTap: addNewContact,
        ),
      ],
    );
  }
}
