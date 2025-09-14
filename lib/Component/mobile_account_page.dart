import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rooster_app/Component/supplier_as_row_in_table.dart';

import '../Backend/ClientsBackend/delete_client.dart';
import '../Controllers/client_controller.dart';
import '../Controllers/home_controller.dart';
import '../Locale_Memory/save_user_info_locally.dart';
import '../Screens/Client/accounts_page.dart';
import '../Screens/Products/products_page.dart';
import '../Widgets/custom_snak_bar.dart';
import '../Widgets/loading.dart';
import '../Widgets/page_title.dart';
import '../Widgets/reusable_btn.dart';
import '../Widgets/reusable_more.dart';
import '../Widgets/reusable_text_field.dart';
import '../Widgets/table_title.dart';
import '../const/Sizes.dart';
import '../const/colors.dart';
class MobileAccountsPage extends StatefulWidget {
  const MobileAccountsPage({super.key});

  @override
  State<MobileAccountsPage> createState() => _MobileAccountsPageState();
}
class _MobileAccountsPageState extends State<MobileAccountsPage> {
  final TextEditingController filterController = TextEditingController();
  FilterItems? selectedFilterItem;
  // GlobalKey filterKey = GlobalKey();
  bool isGridClicked = false;

  final HomeController homeController = Get.find();
  List tabsList = ['general', 'transactions'];
  int selectedTabIndex = 0;
  double generalListViewLength = 100;
  double transactionListViewLength = 100;
  String selectedNumberOfRowsInGeneralTab = '10';
  int selectedNumberOfRowsInGeneralTabAsInt = 10;
  String selectedNumberOfRowsInTransactionsTab = '10';
  int selectedNumberOfRowsInTransactionsTabAsInt = 10;
  int startInGeneral = 1;
  bool isArrowBackClickedInGeneral = false;
  bool isArrowForwardClickedInGeneral = false;
  int startInTransactions = 1;
  bool isArrowBackClickedInTransactions = false;
  bool isArrowForwardClickedInTransactions = false;

  ClientController clientController = Get.find();

  String searchValue = '';
  Timer? searchOnStoppedTyping;
  _onChangeHandler(value) {
    const duration = Duration(
      milliseconds: 800,
    ); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(
          () => searchOnStoppedTyping = Timer(duration, () => search(value)),
    );
  }

  search(value) async {
    if (selectedTabIndex == 0) {
      setState(() {
        searchValue = value;
        clientController.setIsClientsFetched(false);
        clientController.setAccounts([]);
      });
      await clientController.getAllClientsFromBack();
    } else {
      setState(() {
        searchValue = value;
        clientController.setIsTransactionsFetched(false);
        clientController.setTransactionsOrders([]);
        clientController.setTransactionsQuotations([]);
      });
      await clientController.getTransactionsFromBack();
    }
  }
  int? selectedId;

  String primaryCurr='';
  getCurrency() async {
    var curr=await getCompanyPrimaryCurrencyFromPref();
    primaryCurr=curr;
  }
  // TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    getCurrency();
    clientController.getAllClientsFromBack();
    selectedNumberOfRowsInGeneralTabAsInt =
    clientController.accounts.length < 10
        ? clientController.accounts.length
        : 10;
    generalListViewLength =
    clientController.accounts.length < 10
        ? Sizes.deviceHeight * (0.09 * clientController.accounts.length)
        : Sizes.deviceHeight * (0.09 * 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientController>(
      builder: (clientCont) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          height: MediaQuery.of(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(text: 'list_of_clients'.tr),
                gapH10,
                ReusableButtonWithColor(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 45,
                  onTapFunction: () {
                    homeController.selectedTab.value = 'add_new_client';
                  },
                  btnText: 'create_new_client'.tr,
                ),
                gapH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ReusableSearchTextField(
                        hint: '${"search".tr}...',
                        textEditingController: clientCont.searchController,
                        onChangedFunc: (val) {
                          _onChangeHandler(val);
                        },
                        validationFunc: () {},
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       isGridClicked = !isGridClicked;
                    //     });
                    //   },
                    //   child: Icon(
                    //     Icons.grid_view_outlined,
                    //     color:
                    //         isGridClicked
                    //             ? Primary.primary
                    //             : TypographyColor.textTable,
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       isGridClicked = !isGridClicked;
                    //     });
                    //   },
                    //   child: Icon(
                    //     Icons.format_list_bulleted,
                    //     color:
                    //         isGridClicked
                    //             ? TypographyColor.textTable
                    //             : Primary.primary,
                    //   ),
                    // ),
                  ],
                ),
                gapH32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 0.0,
                      direction: Axis.horizontal,
                      children:
                      tabsList
                          .map(
                            (element) => _buildTabChipItem(
                          element,
                          // element['id'],
                          // element['name'],
                          tabsList.indexOf(element),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
                selectedTabIndex == 0
                    ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Primary.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      TableTitle(
                                        text: 'code'.tr,
                                        width:
                                        140, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'name'.tr,
                                        width:
                                        140, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'mobile_number'.tr,
                                        width:
                                        140, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'balance_usd'.tr,
                                        width:
                                        140, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: '${'balance'.tr} $primaryCurr',
                                        width:
                                        140, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'more_options'.tr,
                                        width:
                                        200, // MediaQuery.of(context).size.width * 0.13,
                                      ),
                                    ],
                                  ),
                                ),
                                clientCont.isClientsFetched
                                    ? Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: List.generate(
                                    clientCont.accounts.length,
                                        (index) => Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                            color:
                                            clientCont.selectedClientId ==
                                                '${clientCont.accounts[index]['id']}'
                                                ? Primary.primary
                                                .withAlpha(
                                              (0.5 * 255)
                                                  .toInt(),
                                            )
                                                : clientCont
                                                .hoveredClientId ==
                                                '${clientCont.accounts[index]['id']}'
                                                ? Primary.primary
                                                .withAlpha(
                                              (0.2 * 255)
                                                  .toInt(),
                                            )
                                                : Colors.white,
                                            child: Row(
                                              children: [
                                                SupplierAsRowInTable(
                                                  isSelected: selectedId == '${clientCont.accounts[index]['id']}' as int,
                                                  onTap: (){
                                                    setState(() {
                                                      selectedId = '${clientCont.accounts[index]['id']}' as int ;
                                                    });
                                                  },
                                                  supplier:
                                                  clientCont
                                                      .accounts[index],
                                                  isDesktop: false,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: ReusableMore(
                                                    itemsList: [
                                                      PopupMenuItem<
                                                          String
                                                      >(
                                                        value: '1',
                                                        onTap: () async {
                                                          var res =
                                                          await deleteClient(
                                                            '${clientCont.accounts[index]['id']}',
                                                          );
                                                          var p = json
                                                              .decode(
                                                            res.body,
                                                          );
                                                          if (res.statusCode ==
                                                              200) {
                                                            CommonWidgets.snackBar(
                                                              '',
                                                              p['message'],
                                                            );
                                                            setState(() {
                                                              selectedNumberOfRowsInGeneralTabAsInt =
                                                                  selectedNumberOfRowsInGeneralTabAsInt -
                                                                      1;
                                                              clientCont
                                                                  .accounts
                                                                  .removeAt(
                                                                index,
                                                              );
                                                              generalListViewLength =
                                                                  generalListViewLength -
                                                                      0.09;
                                                            });
                                                          } else {
                                                            CommonWidgets.snackBar(
                                                              'error',
                                                              p['message'],
                                                            );
                                                          }
                                                        },
                                                        child: Text(
                                                          'delete'.tr,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                    : const CircularProgressIndicator(),
                                // gapH4,
                                // clientCont.accounts.isNotEmpty
                                //     ? Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           '${'rows_per_page'.tr}:  ',
                                //           style: const TextStyle(
                                //             fontSize: 13,
                                //             color: Colors.black54,
                                //           ),
                                //         ),
                                //         Container(
                                //           width: 60,
                                //           height: 30,
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(6),
                                //             border: Border.all(
                                //               color: Colors.black,
                                //               width: 2,
                                //             ),
                                //           ),
                                //           child: Center(
                                //             child: DropdownButtonHideUnderline(
                                //               child: DropdownButton<String>(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                       0,
                                //                     ),
                                //                 items:
                                //                     [
                                //                       '10',
                                //                       '20',
                                //                       '50',
                                //                       'all'.tr,
                                //                     ].map((String value) {
                                //                       return DropdownMenuItem<
                                //                         String
                                //                       >(
                                //                         value: value,
                                //                         child: Text(
                                //                           value,
                                //                           style:
                                //                               const TextStyle(
                                //                                 fontSize:
                                //                                     12,
                                //                                 color:
                                //                                     Colors
                                //                                         .grey,
                                //                               ),
                                //                         ),
                                //                       );
                                //                     }).toList(),
                                //                 value:
                                //                     selectedNumberOfRowsInGeneralTab,
                                //                 onChanged: (val) {
                                //                   setState(() {
                                //                     selectedNumberOfRowsInGeneralTab =
                                //                         val!;
                                //                     if (val == '10') {
                                //                       generalListViewLength =
                                //                           clientCont
                                //                                       .accounts
                                //                                       .length <
                                //                                   10
                                //                               ? Sizes.deviceHeight *
                                //                                   (0.09 *
                                //                                       clientCont
                                //                                           .accounts
                                //                                           .length)
                                //                               : Sizes.deviceHeight *
                                //                                   (0.09 *
                                //                                       10);
                                //                       selectedNumberOfRowsInGeneralTabAsInt =
                                //                           clientCont
                                //                                       .accounts
                                //                                       .length <
                                //                                   10
                                //                               ? clientCont
                                //                                   .accounts
                                //                                   .length
                                //                               : 10;
                                //                     }
                                //                     if (val == '20') {
                                //                       generalListViewLength =
                                //                           clientCont
                                //                                       .accounts
                                //                                       .length <
                                //                                   20
                                //                               ? Sizes.deviceHeight *
                                //                                   (0.09 *
                                //                                       clientCont
                                //                                           .accounts
                                //                                           .length)
                                //                               : Sizes.deviceHeight *
                                //                                   (0.09 *
                                //                                       20);
                                //                       selectedNumberOfRowsInGeneralTabAsInt =
                                //                           clientCont
                                //                                       .accounts
                                //                                       .length <
                                //                                   20
                                //                               ? clientCont
                                //                                   .accounts
                                //                                   .length
                                //                               : 20;
                                //                     }
                                //                     if (val == '50') {
                                //                       generalListViewLength =
                                //                           clientCont
                                //                                       .accounts
                                //                                       .length <
                                //                                   50
                                //                               ? Sizes.deviceHeight *
                                //                                   (0.09 *
                                //                                       clientCont
                                //                                           .accounts
                                //                                           .length)
                                //                               : Sizes.deviceHeight *
                                //                                   (0.09 *
                                //                                       50);
                                //                       selectedNumberOfRowsInGeneralTabAsInt =
                                //                           clientCont
                                //                                       .accounts
                                //                                       .length <
                                //                                   50
                                //                               ? clientCont
                                //                                   .accounts
                                //                                   .length
                                //                               : 50;
                                //                     }
                                //                     if (val == 'all'.tr) {
                                //                       generalListViewLength =
                                //                           Sizes
                                //                               .deviceHeight *
                                //                           (0.09 *
                                //                               clientCont
                                //                                   .accounts
                                //                                   .length);
                                //                       selectedNumberOfRowsInGeneralTabAsInt =
                                //                           clientCont
                                //                               .accounts
                                //                               .length;
                                //                     }
                                //                   });
                                //                 },
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //         gapW16,
                                //         Text(
                                //           selectedNumberOfRowsInGeneralTab ==
                                //                   'all'.tr
                                //               ? '${'all'.tr} of ${clientCont.accounts.length}'
                                //               : '$startInGeneral-$selectedNumberOfRowsInGeneralTab of ${clientCont.accounts.length}',
                                //           style: const TextStyle(
                                //             fontSize: 13,
                                //             color: Colors.black54,
                                //           ),
                                //         ),
                                //         gapW16,
                                //         InkWell(
                                //           onTap: () {
                                //             setState(() {
                                //               isArrowBackClickedInGeneral =
                                //                   !isArrowBackClickedInGeneral;
                                //               isArrowForwardClickedInGeneral =
                                //                   false;
                                //             });
                                //           },
                                //           child: Row(
                                //             children: [
                                //               Icon(
                                //                 Icons.skip_previous,
                                //                 color:
                                //                     isArrowBackClickedInGeneral
                                //                         ? Colors.black87
                                //                         : Colors.grey,
                                //               ),
                                //               Icon(
                                //                 Icons.navigate_before,
                                //                 color:
                                //                     isArrowBackClickedInGeneral
                                //                         ? Colors.black87
                                //                         : Colors.grey,
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         gapW10,
                                //         InkWell(
                                //           onTap: () {
                                //             setState(() {
                                //               isArrowForwardClickedInGeneral =
                                //                   !isArrowForwardClickedInGeneral;
                                //               isArrowBackClickedInGeneral =
                                //                   false;
                                //             });
                                //           },
                                //           child: Row(
                                //             children: [
                                //               Icon(
                                //                 Icons.navigate_next,
                                //                 color:
                                //                     isArrowForwardClickedInGeneral
                                //                         ? Colors.black87
                                //                         : Colors.grey,
                                //               ),
                                //               Icon(
                                //                 Icons.skip_next,
                                //                 color:
                                //                     isArrowForwardClickedInGeneral
                                //                         ? Colors.black87
                                //                         : Colors.grey,
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         gapW40,
                                //       ],
                                //     )
                                //     : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // Column(
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 5, vertical: 15),
                //       decoration: BoxDecoration(
                //           color: Primary.primary,
                //           borderRadius:
                //           const BorderRadius.all(Radius.circular(6))),
                //       child: Row(
                //         children: [
                //           TableTitle(
                //             text: 'code'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'name'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: '',
                //             width: MediaQuery.of(context).size.width * 0.15,
                //           ),
                //           TableTitle(
                //             text: 'phone_number'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'balance_usd'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'balance_lbp'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'more_options'.tr,
                //             width: MediaQuery.of(context).size.width * 0.13,
                //           ),
                //         ],
                //       ),
                //     ),
                //     isClientsFetched
                //         ? Container(
                //       color: Colors.white,
                //       height: generalListViewLength,
                //       child: ListView.builder(
                //         itemCount:
                //         selectedNumberOfRowsInGeneralTabAsInt,
                //         itemBuilder: (context, index) => Column(
                //           children: [
                //             Row(
                //               children: [
                //                 ClientAsRowInTable(
                //                   info: accounts[index],
                //                   index: index,
                //                 ),
                //                 SizedBox(
                //                   width: MediaQuery.of(context)
                //                       .size
                //                       .width *
                //                       0.13,
                //                   child: Row(
                //                     mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                     children: [
                //                       SizedBox(
                //                         width: MediaQuery.of(context)
                //                             .size
                //                             .width *
                //                             0.03,
                //                         child: const ReusableMore(itemsList: [],),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             const Divider()
                //           ],
                //         ),
                //       ),
                //     )
                //         : const CircularProgressIndicator(),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           '${'rows_per_page'.tr}:  ',
                //           style: const TextStyle(
                //               fontSize: 13, color: Colors.black54),
                //         ),
                //         Container(
                //           width: 60,
                //           height: 30,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(6),
                //               border:
                //               Border.all(color: Colors.black, width: 2)),
                //           child: Center(
                //             child: DropdownButtonHideUnderline(
                //               child: DropdownButton<String>(
                //                 borderRadius: BorderRadius.circular(0),
                //                 items: ['10', '20', '50', 'all'.tr]
                //                     .map((String value) {
                //                   return DropdownMenuItem<String>(
                //                     value: value,
                //                     child: Text(
                //                       value,
                //                       style: const TextStyle(
                //                           fontSize: 12, color: Colors.grey),
                //                     ),
                //                   );
                //                 }).toList(),
                //                 value: selectedNumberOfRowsInGeneralTab,
                //                 onChanged: (val) {
                //                   setState(() {
                //                     selectedNumberOfRowsInGeneralTab = val!;
                //                     if (val == '10') {
                //                       generalListViewLength =
                //                       accounts.length < 10
                //                           ? Sizes.deviceHeight *
                //                           (0.09 * accounts.length)
                //                           : Sizes.deviceHeight *
                //                           (0.09 * 10);
                //                       selectedNumberOfRowsInGeneralTabAsInt =
                //                       accounts.length < 10
                //                           ? accounts.length
                //                           : 10;
                //                     }
                //                     if (val == '20') {
                //                       generalListViewLength =
                //                       accounts.length < 20
                //                           ? Sizes.deviceHeight *
                //                           (0.09 * accounts.length)
                //                           : Sizes.deviceHeight *
                //                           (0.09 * 20);
                //                       selectedNumberOfRowsInGeneralTabAsInt =
                //                       accounts.length < 20
                //                           ? accounts.length
                //                           : 20;
                //                     }
                //                     if (val == '50') {
                //                       generalListViewLength =
                //                       accounts.length < 50
                //                           ? Sizes.deviceHeight *
                //                           (0.09 * accounts.length)
                //                           : Sizes.deviceHeight *
                //                           (0.09 * 50);
                //                       selectedNumberOfRowsInGeneralTabAsInt =
                //                       accounts.length < 50
                //                           ? accounts.length
                //                           : 50;
                //                     }
                //                     if (val == 'all'.tr) {
                //                       generalListViewLength =
                //                           Sizes.deviceHeight *
                //                               (0.09 * accounts.length);
                //                       selectedNumberOfRowsInGeneralTabAsInt =
                //                           accounts.length;
                //                     }
                //                   });
                //                 },
                //               ),
                //             ),
                //           ),
                //         ),
                //         gapW16,
                //         Text(
                //             '$startInGeneral-$selectedNumberOfRowsInGeneralTab of ${accounts.length}',
                //             style: const TextStyle(
                //                 fontSize: 13, color: Colors.black54)),
                //         gapW16,
                //         InkWell(
                //             onTap: () {
                //               setState(() {
                //                 isArrowBackClickedInGeneral =
                //                 !isArrowBackClickedInGeneral;
                //                 isArrowForwardClickedInGeneral = false;
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.skip_previous,
                //                   color: isArrowBackClickedInGeneral
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //                 Icon(
                //                   Icons.navigate_before,
                //                   color: isArrowBackClickedInGeneral
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //               ],
                //             )),
                //         gapW10,
                //         InkWell(
                //             onTap: () {
                //               setState(() {
                //                 isArrowForwardClickedInGeneral =
                //                 !isArrowForwardClickedInGeneral;
                //                 isArrowBackClickedInGeneral = false;
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.navigate_next,
                //                   color: isArrowForwardClickedInGeneral
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //                 Icon(
                //                   Icons.skip_next,
                //                   color: isArrowForwardClickedInGeneral
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //               ],
                //             )),
                //         gapW40,
                //       ],
                //     )
                //   ],
                // )
                    : SizedBox(
                  // height: 200,
                  child: SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Primary.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      TableTitle(
                                        text: 'date'.tr,
                                        width:
                                        140, //MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'serial'.tr,
                                        width:
                                        140, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'manual_ref'.tr,
                                        width:
                                        140, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'doctype'.tr,
                                        width:
                                        140, //MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text: 'transaction_label'.tr,
                                        width:
                                        250, //MediaQuery.of(context).size.width * 0.09,
                                      ),

                                      TableTitle(
                                        text: '${'value'.tr} (USD)',
                                        width:
                                        150, //MediaQuery.of(context).size.width * 0.09,
                                      ),
                                      TableTitle(
                                        text:
                                        '${'value'.tr} (other currency)',
                                        width:
                                        200, // MediaQuery.of(context).size.width * 0.09,
                                      ),
                                    ],
                                  ),
                                ),
                                clientCont.isTransactionsFetched
                                    ? Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: List.generate(
                                    clientCont
                                        .transactionsOrders
                                        .length +
                                        clientCont
                                            .transactionsQuotations
                                            .length,
                                        (index) =>
                                    index <
                                        clientCont
                                            .transactionsOrders
                                            .length
                                        ? TransactionOrderAsRowInTable(
                                      info:
                                      clientCont
                                          .transactionsOrders[index],
                                      index: index,
                                    )
                                        : TransactionQuotationsAsRowInTable(
                                      info:
                                      clientCont
                                          .transactionsQuotations[index -
                                          clientCont
                                              .transactionsOrders
                                              .length],
                                      index:
                                      index -
                                          clientCont
                                              .transactionsOrders
                                              .length,
                                    ),

                                    //     Container(
                                    //   padding:
                                    //       const EdgeInsets.symmetric(
                                    //         horizontal: 5,
                                    //         vertical: 10,
                                    //       ),
                                    //   decoration: const BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius: BorderRadius.all(
                                    //       Radius.circular(0),
                                    //     ),
                                    //   ),
                                    //   child: Row(
                                    //     children: [
                                    //       TableItem(
                                    //         text:
                                    //             '${clientCont.transactionsOrders[index]['date'] ?? ''}',
                                    //         width:
                                    //             140, //MediaQuery.of(context).size.width * 0.2,
                                    //       ),
                                    //       TableItem(
                                    //         text:
                                    //             '${clientCont.transactionsOrders[index]['serial'] ?? ''}',
                                    //         width:
                                    //             140, // MediaQuery.of(context).size.width * 0.2,
                                    //       ),
                                    //       TableItem(
                                    //         text:
                                    //             '${clientCont.transactionsOrders[index]['manual_ref'] ?? ''}',
                                    //         width:
                                    //             140, // MediaQuery.of(context).size.width * 0.2,
                                    //       ),
                                    //       TableItem(
                                    //         text:
                                    //             '${clientCont.transactionsOrders[index]['doctype'] ?? ''}',
                                    //         width:
                                    //             140, // MediaQuery.of(context).size.width * 0.2,
                                    //       ),
                                    //       TableItem(
                                    //         text:
                                    //             '${clientCont.transactionsOrders[index]['transaction_label'] ?? ''}',
                                    //         width:
                                    //             250, // MediaQuery.of(context).size.width * 0.5,
                                    //       ),
                                    //       TableItem(
                                    //         text:
                                    //             '${clientCont.transactionsOrders[index]['currency'] ?? ''}',
                                    //         width:
                                    //             150, // MediaQuery.of(context).size.width * 0.2,
                                    //       ),
                                    //       TableItem(
                                    //         text:
                                    //             '${clientCont.transactionsOrders[index]['value'] ?? ''}',
                                    //         width:
                                    //             200, // MediaQuery.of(context).size.width * 0.2,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ),
                                )
                                    : loading(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Column(
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 5, vertical: 15),
                //       decoration: BoxDecoration(
                //           color: Primary.primary,
                //           borderRadius:
                //           const BorderRadius.all(Radius.circular(6))),
                //       child: Row(
                //         children: [
                //           TableTitle(
                //             text: 'date'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'serial'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'manual_ref'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'doctype'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: 'transaction_label'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           TableTitle(
                //             text: '',
                //             width: MediaQuery.of(context).size.width * 0.1,
                //           ),
                //           TableTitle(
                //             text: 'currency'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //           // TableTitle(
                //           //   text: 'Debit'.tr,
                //           //   width: MediaQuery.of(context).size.width * 0.09,
                //           // ),
                //           // TableTitle(
                //           //   text: 'Credit'.tr,
                //           //   width: MediaQuery.of(context).size.width * 0.09,
                //           // ),
                //           TableTitle(
                //             text: 'value'.tr,
                //             width: MediaQuery.of(context).size.width * 0.09,
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       color: Colors.white,
                //       height: transactionListViewLength,
                //       child: ListView.builder(
                //         itemCount: selectedNumberOfRowsInTransactionsTabAsInt,
                //         itemBuilder: (context, index) => Column(
                //           children: [
                //             TransactionAsRowInTable(
                //               info: transactions[index],
                //               index: index,
                //             ),
                //             const Divider()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           '${'rows_per_page'.tr}:  ',
                //           style: const TextStyle(
                //               fontSize: 13, color: Colors.black54),
                //         ),
                //         Container(
                //           width: 60,
                //           height: 30,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(6),
                //               border:
                //               Border.all(color: Colors.black, width: 2)),
                //           child: Center(
                //             child: DropdownButtonHideUnderline(
                //               child: DropdownButton<String>(
                //                 borderRadius: BorderRadius.circular(0),
                //                 items: ['10', '20', '50', 'all'.tr]
                //                     .map((String value) {
                //                   return DropdownMenuItem<String>(
                //                     value: value,
                //                     child: Text(
                //                       value,
                //                       style: const TextStyle(
                //                           fontSize: 12, color: Colors.grey),
                //                     ),
                //                   );
                //                 }).toList(),
                //                 value: selectedNumberOfRowsInTransactionsTab,
                //                 onChanged: (val) {
                //                   setState(() {
                //                     selectedNumberOfRowsInTransactionsTab =
                //                     val!;
                //                     if (val == '10') {
                //                       transactionListViewLength =
                //                       transactions.length < 10
                //                           ? Sizes.deviceHeight *
                //                           (0.09 * transactions.length)
                //                           : Sizes.deviceHeight *
                //                           (0.09 * 10);
                //                       selectedNumberOfRowsInTransactionsTabAsInt =
                //                       transactions.length < 10
                //                           ? transactions.length
                //                           : 10;
                //                     }
                //                     if (val == '20') {
                //                       transactionListViewLength =
                //                       transactions.length < 20
                //                           ? Sizes.deviceHeight *
                //                           (0.09 * transactions.length)
                //                           : Sizes.deviceHeight *
                //                           (0.09 * 20);
                //                       selectedNumberOfRowsInTransactionsTabAsInt =
                //                       transactions.length < 20
                //                           ? transactions.length
                //                           : 20;
                //                     }
                //                     if (val == '50') {
                //                       transactionListViewLength =
                //                       transactions.length < 50
                //                           ? Sizes.deviceHeight *
                //                           (0.09 * transactions.length)
                //                           : Sizes.deviceHeight *
                //                           (0.09 * 50);
                //                       selectedNumberOfRowsInTransactionsTabAsInt =
                //                       transactions.length < 50
                //                           ? transactions.length
                //                           : 50;
                //                     }
                //                     if (val == 'all'.tr) {
                //                       transactionListViewLength =
                //                           Sizes.deviceHeight *
                //                               (0.09 * transactions.length);
                //                       selectedNumberOfRowsInTransactionsTabAsInt =
                //                           transactions.length;
                //                     }
                //                   });
                //                 },
                //               ),
                //             ),
                //           ),
                //         ),
                //         gapW16,
                //         Text(
                //             '$startInTransactions-$selectedNumberOfRowsInTransactionsTab of ${transactions.length}',
                //             style: const TextStyle(
                //                 fontSize: 13, color: Colors.black54)),
                //         gapW16,
                //         InkWell(
                //             onTap: () {
                //               setState(() {
                //                 isArrowBackClickedInTransactions =
                //                 !isArrowBackClickedInTransactions;
                //                 isArrowForwardClickedInTransactions = false;
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.skip_previous,
                //                   color: isArrowBackClickedInTransactions
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //                 Icon(
                //                   Icons.navigate_before,
                //                   color: isArrowBackClickedInTransactions
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //               ],
                //             )),
                //         gapW10,
                //         InkWell(
                //             onTap: () {
                //               setState(() {
                //                 isArrowForwardClickedInTransactions =
                //                 !isArrowForwardClickedInTransactions;
                //                 isArrowBackClickedInTransactions = false;
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.navigate_next,
                //                   color: isArrowForwardClickedInTransactions
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //                 Icon(
                //                   Icons.skip_next,
                //                   color: isArrowForwardClickedInTransactions
                //                       ? Colors.black87
                //                       : Colors.grey,
                //                 ),
                //               ],
                //             )),
                //         gapW40,
                //       ],
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabChipItem(String name, int index) {
    return GetBuilder<ClientController>(
      builder: (cont) {
        return GestureDetector(
          onTap:
          cont.selectedClientId == '' && index == 1
              ? null
              : () {
            setState(() {
              clientController.searchController.clear();
              clientController.getAllClientsFromBack();
              // clientController.getAllOrdersFromBack();
              selectedTabIndex = index;
            });
            if (index == 1) {
              cont.getTransactionsFromBack();
            }
          },
          child: ClipPath(
            clipper: const ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
            ),
            child: Container(
              // width: MediaQuery.of(context).size.width * 0.25,
              // height: MediaQuery.of(context).size.height * 0.07,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                color: selectedTabIndex == index ? Primary.p20 : Colors.white,
                border:
                selectedTabIndex == index
                    ? Border(
                  top: BorderSide(color: Primary.primary, width: 3),
                )
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
                    fontWeight: FontWeight.bold,
                    color: Primary.primary,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}