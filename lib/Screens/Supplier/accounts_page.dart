import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Blocs/City/Bloc/CityBloc.dart';
import 'package:rooster_app/Blocs/Countries/Bloc/CountryBloc.dart';
import 'package:rooster_app/Locale_Memory/save_user_info_locally.dart';
import 'package:rooster_app/Screens/Supplier/add_new_supplier.dart';
import '../../Backend/ClientsBackend/delete_client.dart';
import '../../Blocs/City/ApiProvider/CityApi.dart';
import '../../Blocs/City/Repository/CityRepository.dart';
import '../../Blocs/Countries/ApiProvider/CountryApi.dart';
import '../../Blocs/Countries/Events/CountryEvent.dart';
import '../../Blocs/Countries/Repository/CountryRepository.dart';
import '../../Blocs/Supplier/Bloc/SupplierBloc.dart';
import '../../Blocs/Supplier/Events/SupplierEvent.dart';
import '../../Blocs/Supplier/States/SupplierStates.dart';
import '../../Blocs/SupplierCreation/ApiProvider/SupplierApi.dart';
import '../../Component/supplier_as_row_in_table.dart';
import 'package:http/http.dart' as http;

import '../../Component/update_supplier_dialog.dart';
import '../../Controllers/home_controller.dart';
import '../../Cubits/CheckBoxStates.dart';
import '../../Widgets/custom_snak_bar.dart';
import '../../Widgets/page_title.dart';
import '../../Widgets/reusable_btn.dart';
import '../../Widgets/reusable_more.dart';
import '../../Widgets/reusable_text_field.dart';
import '../../Widgets/table_title.dart';
import '../../const/Sizes.dart';
import '../../const/colors.dart';

class SupplierAccountsPage extends StatefulWidget {
  const SupplierAccountsPage({super.key});

  @override
  State<SupplierAccountsPage> createState() => _SupplierAccountsPageState();
}

class _SupplierAccountsPageState extends State<SupplierAccountsPage> {
  final HomeController homeController =Get.find();
  List<String> tabsList = ['general', 'transactions','SOA'];
  int selectedTabIndex = 0;
  int? selectedId;
  bool _isLoadingMore = false;
  String primaryCurr = '';
  Timer? searchOnStoppedTyping;
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCurrency();
    if(context.read<SuppliersBloc>().state is SuppliersInitial){
      context.read<SuppliersBloc>().add(LoadSuppliers(''));
    }
    else{
      context.read<SuppliersBloc>().add(SupplierLoading());
      context.read<SuppliersBloc>().add(LoadSuppliers(''));
    }
    _scrollController.addListener(_onScroll);

  }

  getCurrency() async {
    primaryCurr = await getCompanyPrimaryCurrencyFromPref();
    setState(() {});
  }


  void _onChangeHandler(String value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) searchOnStoppedTyping!.cancel();
    searchOnStoppedTyping = Timer(duration, () {
      context.read<SuppliersBloc>().add(LoadSuppliers(value, reset: true));
    });
  }

  void _onScroll()async {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)&&!_isLoadingMore) {
      _isLoadingMore=true;
      context.read<SuppliersBloc>().add(LoadSuppliers(searchController.text));
      await context.read<SuppliersBloc>().stream.firstWhere((s) => s is SuppliersLoadSuccess);
      _isLoadingMore=false;
    }
  }

  @override
  Widget build(BuildContext originalContext) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageTitle(text: 'list_of_suppliers'.tr),

              ReusableButtonWithColor(
                width: MediaQuery.of(context).size.width * 0.15,
                height: 45,
                onTapFunction: () {
                    homeController.selectedTab.value = 'add_new_supplier';
                },
                btnText: 'create_new_supplier'.tr,
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
                  onChangedFunc: _onChangeHandler,
                  validationFunc: (val) {},
                  isPasswordField: false,
                ),
              ),
            ],
          ),
          SizedBox(height: Sizes.deviceHeight * 0.05),
          Row(
            children: [
              Wrap(
                spacing: 0,
                children: tabsList.map((name) => _buildTabChipItem(name, tabsList.indexOf(name))).toList(),
              ),
            ],
          ),
          SizedBox(height: Sizes.deviceHeight * 0.02),
          selectedTabIndex == 0
              ? Expanded(
            child: BlocBuilder<SuppliersBloc, SuppliersState>(
              builder: (context, state) {
                if (state is SuppliersInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuppliersLoadSuccess) {
                  final suppliers = state.suppliers;
                  double bigWidth = homeController.isMenuOpened
                      ? MediaQuery.of(context).size.width * 0.25
                      : MediaQuery.of(context).size.width * 0.28;
                  double smallWidth = homeController.isMenuOpened
                      ? MediaQuery.of(context).size.width * 0.09
                      : MediaQuery.of(context).size.width * 0.12;

                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        decoration: BoxDecoration(
                          color: Primary.primary,
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Row(
                          children: [
                            TableTitle(text: 'code'.tr, width: smallWidth, isCentered: false),
                            TableTitle(text: 'name'.tr, width: bigWidth, isCentered: false),
                            TableTitle(text: 'mobile_number'.tr, width: smallWidth),
                            TableTitle(text: 'balance_usd'.tr, width: smallWidth),
                            TableTitle(text: 'balance $primaryCurr', width: smallWidth),
                            TableTitle(
                              text: 'more_options'.tr,
                              width: MediaQuery.of(context).size.width * 0.13,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                        Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.hasReachedMax ? suppliers.length : suppliers.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= suppliers.length) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            }
                            final supplier = suppliers[index];
                            return Row(
                              children: [
                                SupplierAsRowInTable(isSelected: selectedId == supplier.id,supplier: supplier,onTap:() {setState(() {
                                  selectedId = supplier.id;
                                });},),
                                SizedBox(
                                  width:
                                  MediaQuery.of(
                                    context,
                                  ).size.width *
                                      0.13,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width:
                                        MediaQuery.of(
                                          context,
                                        ).size.width *
                                            0.03,
                                        child: ReusableMore(
                                          itemsList: [
                                            PopupMenuItem<String>(
                                              value: '1',
                                              onTap: () async {
                                                (context.read<SuppliersBloc>()).add(DeleteSupplier(supplier: supplier));
                                              },
                                              child: Text(
                                                'delete'.tr,
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              value: '2',
                                              onTap: () async {
                                                showDialog<String>(
                                                  context:
                                                  context,
                                                  builder:(BuildContext context,) => MultiBlocProvider(

                                                    providers: [
                                                      BlocProvider<CheckBoxCubit>(
                                                        create: (context) => CheckBoxCubit({"blocked":supplier.isBlocked!, "show_in_POS":supplier.showOnPos!}),
                                                      ),
                                                      BlocProvider.value(
                                                          value: originalContext.read<SuppliersBloc>()),
                                                      BlocProvider<CountryBloc>(
                                                        create: (context) => CountryBloc(
                                                          CountryRepository(
                                                            CountryApi(http.Client()),
                                                          ),
                                                        )..add(LoadCountryCreation(search: '',selectedCountry:supplier.city!=null?supplier.city!.country:supplier.country,shouldLoad: false,page:  1)),
                                                      ),
                                                      BlocProvider<CitiesBloc>(
                                                        create: (context) => CitiesBloc(
                                                          repository: CityRepository(
                                                            CityApi(http.Client()),
                                                          ),
                                                          countryBloc: context.read<CountryBloc>(),
                                                        ),
                                                      ),
                                                      ],
                                                      child: AlertDialog(
                                                        backgroundColor:
                                                        Colors
                                                            .white,
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(
                                                            Radius.circular(
                                                              9,
                                                            ),
                                                          ),
                                                        ),
                                                        elevation:
                                                        0,
                                                        content: UpdateSupplierDialog(
                                                          supplier: (originalContext.read<SuppliersBloc>().state as SuppliersLoadSuccess).suppliers[index],
                                                        ),
                                                      ),
                                                    )
                                                );
                                              },
                                              child: Text(
                                                'update'.tr,
                                              ),
                                            ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),

                                const Divider(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is SuppliersLoadFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

          )
          : Center(child: Text('${tabsList[selectedTabIndex]} tab not implemented yet')),
          BlocListener<SuppliersBloc, SuppliersState>(
            listener: (context, state) {
              if (state is SuppliersStatus) {
                CommonWidgets.snackBar(state.title, state.message);
              }
            },
            child: const SizedBox.shrink(), // invisible child
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
            context.read<SuppliersBloc>().add(SupplierLoading());
            context.read<SuppliersBloc>().add(LoadSuppliers('', reset: true));
          }
        });
      },
      child: ClipPath(
        clipper: const ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          decoration: BoxDecoration(
            color: selectedTabIndex == index ? Primary.p20 : Colors.white,
            border: selectedTabIndex == index ? Border(top: BorderSide(color: Primary.primary, width: 3)) : null,
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
              style: TextStyle(fontWeight: FontWeight.bold, color: Primary.primary),
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

