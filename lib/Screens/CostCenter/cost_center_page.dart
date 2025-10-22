import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Bloc/CostCenterBloc.dart';
import 'package:rooster_app/Blocs/Cost%20Center/Events/CostCenterEvent.dart';
import '../../Blocs/Cost Center/States/CostCenterState.dart';
import '../../Component/cost_center_as_row_in_table.dart';
import '../../Controllers/home_controller.dart';
import '../../Widgets/custom_snak_bar.dart';
import '../../Widgets/page_title.dart';
import '../../Widgets/reusable_btn.dart';
import '../../Widgets/reusable_text_field.dart';
import '../../const/Sizes.dart';
import '../../const/colors.dart';

class CostCenterPage extends StatefulWidget {
  const CostCenterPage({super.key});

  @override
  State<CostCenterPage> createState() => _CostCenterPageState();
}

class _CostCenterPageState extends State<CostCenterPage> {
  final HomeController homeController = Get.find();
  List<String> tabsList = [];
  bool _isLoadingMore = false;

  int selectedTabIndex = 0;
  String primaryCurr = '';
  Timer? searchOnStoppedTyping;
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (context.read<CostCenterBloc>().state is CostCentersInitial) {
      context.read<CostCenterBloc>().add(LoadCostCenters(''));
    } else {
      context.read<CostCenterBloc>().add(CostCenterLoading());
      context.read<CostCenterBloc>().add(LoadCostCenters(''));
    }
    _scrollController.addListener(_onScroll);
  }

  void _onChangeHandler(String value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) searchOnStoppedTyping!.cancel();
    searchOnStoppedTyping = Timer(duration, () {
      context
          .read<CostCenterBloc>()
          .add(LoadCostCenters(value, reset: true));
    });
  }

  void _onScroll()async{
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final state = context.read<CostCenterBloc>().state;
    if (currentScroll >= (maxScroll * 0.9) &&
        state is CostCentersLoadSuccess &&
        !state.hasReachedMax&&!_isLoadingMore) {
        _isLoadingMore=true;
      context.read<CostCenterBloc>().add(
        LoadCostCenters(
          searchController.text,
          reset: false,
        ),
      );
        await context.read<CostCenterBloc>().stream.firstWhere((s) => s is CostCentersLoadSuccess);
        _isLoadingMore=false;
    }
  }


  @override
  Widget build(BuildContext originalContext) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageTitle(text: 'list_of_cost_centers'.tr),
              ReusableButtonWithColor(
                width: MediaQuery.of(context).size.width * 0.15,
                height: 45,
                onTapFunction: () {
                  homeController.selectedTab.value = 'add_new_cost_center';
                },
                btnText: 'add_new_cost_center'.tr,
              ),
            ],
          ),
          SizedBox(height: Sizes.deviceHeight * 0.03),

          Row(
            children: [
              Expanded(
                child: ReusableTextField(
                  hint: '${"search".tr}...',
                  textEditingController: searchController,
                  onChangedFunc: (value) =>
                      _onChangeHandler(value),
                  validationFunc: (val) {},
                  isPasswordField: false,
                ),
              ),
            ],
          ),
          SizedBox(height: Sizes.deviceHeight * 0.05),

          /// Tabs (if you want multiple views later)
          Row(
            children: [
              Wrap(
                spacing: 0,
                children: tabsList
                    .map((name) =>
                    _buildTabChipItem(name, tabsList.indexOf(name)))
                    .toList(),
              ),
            ],
          ),
          SizedBox(height: Sizes.deviceHeight * 0.02),
          selectedTabIndex == 0
              ? Expanded(
            child: BlocBuilder<CostCenterBloc, CostCentersState>(
              builder: (context, state) {
                if (state is CostCentersInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (state is CostCentersLoadSuccess) {
                  final costCenters = state.originalCostCenters;

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax
                        ? costCenters.length
                        : costCenters.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= costCenters.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                      final center = costCenters[index];
                      return CostCenterTreeView(
                        root: center,
                        index:index
                      );
                    },
                  );
                }
                else if (state is CostCentersLoadFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )

        : Center(
              child: Text(
                  '${tabsList[selectedTabIndex]} tab not implemented yet')),
          BlocListener<CostCenterBloc, CostCentersState>(
            listener: (context, state) {
              if (state is CostCentersStatus) {
                CommonWidgets.snackBar(state.title, state.message);
              }
            },
            child: const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  Widget _buildTabChipItem(String name, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          searchController.clear();
          selectedTabIndex = index;
          if (index == 0) {
            context.read<CostCenterBloc>().add(CostCenterLoading());
            context
                .read<CostCenterBloc>()
                .add(LoadCostCenters('', reset: true));
          }
        });
      },
      child: ClipPath(
        clipper: const ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9), topRight: Radius.circular(9)),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          decoration: BoxDecoration(
            color: selectedTabIndex == index ? Primary.p20 : Colors.white,
            border: selectedTabIndex == index
                ? Border(top: BorderSide(color: Primary.primary, width: 3))
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                spreadRadius: 9,
                blurRadius: 9,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              name.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Primary.primary),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
