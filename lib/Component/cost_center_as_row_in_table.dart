import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Bloc/CostCenterBloc.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Events/CostCenterEvent.dart';
import 'package:rooster_app/Blocs/Cost%20Center/States/CostCenterState.dart';
import 'package:rooster_app/Component/update_cost_center_dialog.dart';
import '../Models/CostCenter/CostCenterModel.dart';
import 'package:flutter/material.dart';
import '../Widgets/reusable_more.dart';

class CostCenterTreeView extends StatelessWidget {
  final CostCenterModel root; // single object instead of list
  final int index; // single object instead of list

  const CostCenterTreeView({
    super.key,
    required this.root,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // just build the root node and recurse through children
    return _buildNode(context, root);
  }

  Widget _buildNode(
      BuildContext nestedBuildContext,
      CostCenterModel node, {
        double indent = 0,
      }) {
    final children = node.children ?? [];

    Widget mainContent = Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    children.isEmpty
                        ? node.parentId == null
                        ? '${'cost_center_project'.tr} : '
                        : '${'cost_center'.tr} : '
                        : '${'project'.tr} : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      node.name ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (node.description != null && node.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    node.description!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
        ReusableMore(itemsList: [
          PopupMenuItem<String>(
            value: '1',
            onTap: () async {
              (nestedBuildContext.read<CostCenterBloc>())
                  .add(DeleteCostCenterFromBack(costCenterModel: node));
            },
            child: Text('delete'.tr),
          ),
          PopupMenuItem<String>(
            value: 'update',
            onTap: () async {
              showDialog<String>(
                context: nestedBuildContext,
                barrierDismissible: true,
                builder: (BuildContext context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: (nestedBuildContext.read<CostCenterBloc>()),
                    ),
                  ],
                  child: AlertDialog(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(9),
                      ),
                    ),
                    elevation: 0,
                    content: UpdateCostCenterDialog(
                      costCenterModel: findNodeById(
                          (nestedBuildContext.read<CostCenterBloc>().state as CostCentersLoadSuccess)
                              .updateListCostCenters[index], // start from root
                          node.id!) ?? node, // fallback
                    ),
                  ),
                ),
              );
            },
            child: Text('update'.tr),
          ),
        ]),
      ],
    );

    if (children.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: indent),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: mainContent,
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: indent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              initiallyExpanded: false,
              title: mainContent,
              childrenPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              iconColor: Colors.grey,
              collapsedIconColor: Colors.grey,
              shape: const Border(),
              collapsedShape: const Border(),
              children: children
                  .map(
                    (child) => _buildNode(
                  nestedBuildContext,
                  child,
                  indent: indent + 20,
                ),
              )
                  .toList(),
            ),
          ],
        ),
      );
    }
  }
  CostCenterModel? findNodeById(CostCenterModel root, int id) {
    if (root.id == id) return root;
    if (root.children != null) {
      for (var child in root.children!) {
        final found = findNodeById(child, id);
        if (found != null) return found;
      }
    }
    return null;
  }
}
