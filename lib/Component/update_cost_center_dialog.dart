import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Bloc/CostCenterBloc.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Events/CostCenterEvent.dart';
import 'package:rooster_app/Blocs/Cost%20Center/States/CostCenterState.dart';
import 'package:rooster_app/Models/CostCenter/CostCenterModel.dart';
import '../Component/reusable_button_with_color.dart';
import '../Controllers/home_controller.dart';
import '../Widgets/custom_snak_bar.dart';

class UpdateCostCenterDialog extends StatefulWidget {
  final CostCenterModel costCenterModel;

  const UpdateCostCenterDialog({
    super.key,
    required this.costCenterModel,
  });

  static const Color primary = Color(0xff417D7A);

  @override
  State<UpdateCostCenterDialog> createState() => _UpdateCostCenterDialogState();
}

class _UpdateCostCenterDialogState extends State<UpdateCostCenterDialog> {
  bool _isLoading = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildStep(
      CostCenterModel node, List<int> path, int level, CostCenterBloc bloc) {
    final nameController = TextEditingController(text: node.name);
    final descriptionController =
    TextEditingController(text: node.description);

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
                    color: UpdateCostCenterDialog.primary,
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
                    color: UpdateCostCenterDialog.primary.withOpacity(0.5),
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
                      color: UpdateCostCenterDialog.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: UpdateCostCenterDialog.primary),
                    ),
                    child: Text(
                      node.name?.isEmpty ?? true ? 'Cost Center' : node.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    onChanged: (val) {
                      node.name = val;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    onChanged: (val) {
                      node.description = val;
                    },
                  ),
                  Row(
                    children: [
                      if (level < 4)
                        IconButton(
                          icon: const Icon(Icons.add_circle,
                              color: UpdateCostCenterDialog.primary),
                          onPressed: () {
                            bloc.add(AddCostCenterUpdate(
                                costCenter: CostCenterModel(isNew: true,parentId: node.id),
                                parentPath: path));
                          },
                        ),
                      if (node.isNew)
                        IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            bloc.add(RemoveCostCenterUpdate(costCenterPath: path));
                          },
                        ),
                    ],
                  ),
                  if (node.children.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: node.children
                            .map((child) =>
                            _buildStep(child, [...path, node.children.indexOf(child)], level + 1, bloc))
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

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.9,
        child: BlocListener<CostCenterBloc, CostCentersState>(
          listener: (context, state) {
            if (state is CostCentersStatus) {
              CommonWidgets.snackBar(state.title, state.message);
              if (state.statusCode != 200) return;
              final HomeController homeController = Get.find();
              homeController.selectedTab.value = "cost_center_page";
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<CostCenterBloc, CostCentersState>(
            builder: (context, state) {
              if (state is CostCentersLoadSuccess) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Update Cost Center',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: CircleAvatar(
                              backgroundColor: UpdateCostCenterDialog.primary,
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
                      const SizedBox(height: 16),
                      _buildStep(
                        widget.costCenterModel,
                        findPathById(state.updateListCostCenters, widget.costCenterModel.id!) ?? <int>[],
                        findPathById(state.updateListCostCenters, widget.costCenterModel.id!)!=null?findPathById(state.updateListCostCenters, widget.costCenterModel.id!)!.length:1,
                        bloc,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ReusableButtonWithColorSupplier(
                          btnText: 'Update',
                          width: 100,
                          height: 35,
                          isLoading: _isLoading,
                          onTapFunction: () async {
                            setState(() { _isLoading = true; });

                            // Use the path in updateListCostCenters
                            final path = findPathById(state.updateListCostCenters, widget.costCenterModel.id!) ?? <int>[];
                            bloc.add(UpdateCostCenter(costCenter: widget.costCenterModel, costCenterPath: path));

                            await bloc.stream.firstWhere((s) => s is CostCentersLoadSuccess);
                            setState(() { _isLoading = false; });
                          },
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
      ),
    );
  }
  List<int>? findPathById(List<CostCenterModel> roots, int targetId) {
    List<int>? helper(List<CostCenterModel> nodes, int id, List<int> pathSoFar) {
      for (int i = 0; i < nodes.length; i++) {
        final node = nodes[i];
        final newPath = [...pathSoFar, i];
        if (node.id == id) {
          return newPath; // 👈 includes the current node itself
        }
        if (node.children != null && node.children!.isNotEmpty) {
          final childPath = helper(node.children!, id, newPath);
          if (childPath != null) return childPath;
        }
      }
      return null;
    }

    return helper(roots, targetId, []);
  }


}
