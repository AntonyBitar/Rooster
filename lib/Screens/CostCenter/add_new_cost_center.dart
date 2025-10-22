import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rooster_app/Blocs/Cost Center/Bloc/CostCenterBloc.dart';
import 'package:rooster_app/Blocs/Cost Center/Events/CostCenterEvent.dart';
import 'package:rooster_app/Blocs/Cost Center/States/CostCenterState.dart';
import 'package:rooster_app/Models/CostCenter/CostCenterModel.dart';

import '../../Component/reusable_button_with_color.dart';
import '../../Controllers/home_controller.dart';
import '../../Widgets/custom_snak_bar.dart';

class AddNewCostCenter extends StatefulWidget {
  const AddNewCostCenter({super.key});

  static const Color primary = Color(0xff417D7A);

  @override
  State<AddNewCostCenter> createState() => _AddNewCostCenterState();
}

class _AddNewCostCenterState extends State<AddNewCostCenter> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<CostCenterBloc>().add(
      AddCostCenterStore(costCenter: CostCenterModel()),
    );
  }

  Widget _buildStep(
      CostCenterModel node,
      List<int> path,
      int level,
      CostCenterBloc bloc,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AddNewCostCenter.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$level',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (node.children.isNotEmpty)
                  Container(
                    width: 2,
                    height: 60,
                    color: AddNewCostCenter.primary.withOpacity(0.5),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AddNewCostCenter.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AddNewCostCenter.primary),
                    ),
                    child: Text(
                      node.name?.isEmpty ?? true ? 'cost_center'.tr : node.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'name'.tr,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    onChanged: (val) => node.name = val,
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'description'.tr,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    onChanged: (val) => node.description = val,
                  ),
                  Row(
                    children: [
                      if (level < 4)
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: AddNewCostCenter.primary,
                          ),
                          onPressed: () => bloc.add(AddCostCenterStore(
                            costCenter: CostCenterModel(),
                            parentPath: path,
                          )),
                        ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => bloc.add(RemoveCostCenterStore(
                          costCenterPath: path,
                        )),
                      ),
                    ],
                  ),
                  if (node.children.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: node.children
                            .asMap()
                            .entries
                            .map((entry) => _buildStep(
                          entry.value,
                          [...path, entry.key],
                          level + 1,
                          bloc,
                        ))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CostCenterBloc>(context);

    return BlocListener<CostCenterBloc, CostCentersState>(
      listener: (context, state) {
        if (state is CostCentersStatus) {
          CommonWidgets.snackBar(state.title, state.message);
          if (state.statusCode != 200) return;
          final HomeController homeController = Get.find();
          homeController.selectedTab.value = "cost_center_page";
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("add_new_cost_center".tr),
          backgroundColor: AddNewCostCenter.primary,
        ),
        body: BlocBuilder<CostCenterBloc, CostCentersState>(
          builder: (context, state) {
            if (state is CostCentersStoreData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.costCenter
                        .asMap()
                        .entries
                        .map((entry) => _buildStep(
                      entry.value,
                      [entry.key],
                      1,
                      bloc,
                    ))
                        .toList(),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AddNewCostCenter.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => bloc.add(AddCostCenterStore(
                        costCenter: CostCenterModel(),
                      )),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label:Text(
                        "add_new_cost_center".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Visibility(
                      visible: state.costCenter.isNotEmpty,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ReusableButtonWithColorSupplier(
                          btnText: 'save'.tr,
                          width: 100,
                          height: 35,
                          isLoading: _isLoading,
                          onTapFunction: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            (context.read<CostCenterBloc>()).add(StoreCostCenter());
                            await context
                                .read<CostCenterBloc>()
                                .stream
                                .firstWhere((s) => s is CostCentersLoadSuccess);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}
