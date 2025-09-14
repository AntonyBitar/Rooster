import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rooster_app/Blocs/City/Bloc/CityBloc.dart';
import 'package:rooster_app/Blocs/Countries/Bloc/CountryBloc.dart';
import 'package:rooster_app/Blocs/Countries/Events/CountryEvent.dart';
import 'package:rooster_app/Blocs/Countries/Repository/CountryRepository.dart';
import 'package:rooster_app/Blocs/SupplierCreation/ApiProvider/SupplierApi.dart';
import 'package:rooster_app/Blocs/SupplierCreation/Bloc/SupplierBloc.dart';
import 'package:rooster_app/Blocs/SupplierCreation/Events/SupplierEvent.dart';
import 'package:rooster_app/Blocs/SupplierCreation/Repository/SupplierRepository.dart';
import 'package:rooster_app/Screens/AccountSettings/RolesAndPermissions/roles.dart';
import 'package:rooster_app/Screens/AccountSettings/RolesAndPermissions/roles_and_permissions.dart';
import 'package:rooster_app/Screens/POS/pos_screen_for_mobile.dart';
import 'package:rooster_app/Screens/PendingDocs/pending_docs.dart';
import 'package:rooster_app/Screens/PosReports/cash_trays/cash_tray_filter.dart';
import 'package:rooster_app/Screens/Supplier/accounts_page.dart';
import 'package:rooster_app/Screens/Supplier/add_new_supplier.dart';
import 'package:rooster_app/Screens/SupplierOrder/new_supplier_order.dart';
import 'package:rooster_app/Screens/SupplierOrder/supplier_order_summary.dart';
import 'package:rooster_app/Screens/Transfers/transfer_details.dart';
import 'package:rooster_app/Screens/Warehouses/warehouses.dart';
import 'package:rooster_app/const/colors.dart';
import 'package:rooster_app/const/sizes.dart';
import '../Blocs/City/ApiProvider/CityApi.dart';
import '../Blocs/City/Repository/CityRepository.dart';
import '../Blocs/Countries/ApiProvider/CountryApi.dart';
import '../Blocs/Supplier/ApiProvider/SupplierApi.dart';
import '../Blocs/Supplier/Bloc/SupplierBloc.dart';
import '../Blocs/Supplier/Events/SupplierEvent.dart';
import '../Blocs/Supplier/Repository/SupplierRepository.dart';
import '../Controllers/home_controller.dart';
import '../Cubits/CheckBoxStates.dart';
import 'Combo/ComboSummaryWidgets/combo_data.dart';
import 'Combo/combo_summary.dart';
import 'Delivery/delivery.dart';
import 'Delivery/delivery_summary.dart';
import 'DocsReview/docs_review.dart';
import 'PendingDocs/pending_quotation.dart';
import 'PendingDocs/to_deleiver.dart';
import 'PendingDocs/to_invoice.dart';
import 'PendingDocs/to_sales_order.dart';
import 'SalesInvoice/create_new_sales_invoice.dart';
import 'SalesInvoice/sales_invoice_summary.dart';
import 'SupplierOrder/supliers.dart';
import '../Widgets/HomeWidgets/home_app_bar.dart';
import '../Widgets/HomeWidgets/home_drawer_list_tile.dart';
import 'Client/accounts_page.dart';
import 'Client/add_new_client.dart';
import 'Dashboard/dashboard.dart';
import 'Inventory/counting_form.dart';
import 'Inventory/physical_inventory.dart';
import 'POS/pos_screen.dart';
import 'PosReports/SessionsReport/session_details_after_filter.dart';
import 'PosReports/SessionsReport/sessions_details.dart';
import 'PosReports/SessionsReport/sessions_details_after_filter_mobile.dart';
import 'package:http/http.dart' as http;

import 'PosReports/WasteReport/waste_filter.dart';
import 'PosReports/WasteReport/waste_report.dart';
import 'Products/products_page.dart';
import 'PurchaseInvoice/new_purchase_invoice.dart';
import 'PurchaseInvoice/purchase_invoice_summary.dart';
import 'Quotations/create_new_quotation.dart';
import 'Quotations/quotation_data.dart';
import 'Quotations/quotation_summary.dart';
import 'ReturnFromClient/return_from_client.dart';
import 'ReturnFromClient/return_from_client_summary.dart';
import 'ReturnToSupplier/return_to_supplier.dart';
import 'ReturnToSupplier/return_to_supplier_summary.dart';
import 'Transfers/Replenish/create_replenish.dart';
import 'Transfers/Replenish/replenishment.dart';
import 'Transfers/transfer_in.dart';
import 'Transfers/transfer_out.dart';
import 'Transfers/transfers.dart';
import 'AccountSettings/Users/create_user.dart';
import 'AccountSettings/Users/users.dart';
import 'Warehouses/create_warehouse.dart';
import 'client_order/sales_order_summury.dart';
import 'client_order/create_new_sales_order.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        breakpoints: const ScreenBreakpoints(
          tablet: 630,
          desktop: 950,
          watch: 300,
        ),
        mobile: (p0) => const MobileHomeBody(),
        tablet: (p0) => const MobileHomeBody(),
        desktop: (p0) => const HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Map<String, Widget> contentList = {
    'pending_quotation': PendingQuotation(),
    "to_invoice": ToInvoice(),
    'delivery': const CreateDelivery(),
    'new_delivery': const CreateDelivery(),
    'deliveries_summary': const DeliverySummary(),
    'sales_invoice': const CreateNewSalesInvoice(),
    'new_sales_invoice': const CreateNewSalesInvoice(),
    'sales_invoice_summary': const SalesInvoiceSummary(),
    'docs_review': DocsReview(),
    'pending_docs':PendingDocs(),
    'to_sales_order':ToSalesOrder(),
    'to_deliver':ToDeleiver(),
    'cash_tray_report': const CashTrayFilter(),
    'items': const ProductsPage(),
    'stock': const ProductsPage(),
    'combo': const ComboSummary(),
    'combo_summary': ComboSummary(),
    "combo_data": ComboData(),
    'products': const ProductsPage(),
    'quotation': const CreateNewQuotation(),
    'new_quotation': const CreateNewQuotation(),
    'quotation_summary': const QuotationSummary(),
    'add_new_client': const AddNewClient(),

    'accounts': const AccountsPage(),
    'clients': const AccountsPage(),
    'dashboard_summary': const Dashboard(),
    // 'categories':const CategoriesPage(),
    // 'warehouses':const Warehouses(),
    // 'create_warehouse':const CreateWarehouse(),
    'transfers': const Transfers(),
    'transfer_in': const TransferIn(),
    'transfer_details': const TransferDetails(),
    'transfer_out': const TransferOut(),
    'replenish_transfer': const Replenish(),
    'replenishment': const Replenishment(),
    'poss': const PosScreen(),
    'create_users': const AddNewUser(),
    'account_settings': const AddNewUser(),
    'users': const UsersPage(),
    'new_sales_order': const CreateNewClientOrder(),
    'sales_order': const CreateNewClientOrder(),
    'sales_order_summary': const ClientOrderSummary(),
    'supplier_order': const CreateNewSupplierOrder(),
    'new_supplier_order': const CreateNewSupplierOrder(),
    'supplier_order_summary': const SupplierOrderSummary(),
    'return_to_supplier': const CreateNewReturnToSupplier(),
    'return_to_supplier_summary': const ReturnToSupplierSummary(),
    'return_from_client': const CreateNewReturnFromClient(),
    'return_from_client_summary': const ReturnFromClientSummary(),
    'back-office': const RolesAndPermissions(),
    'purchase_invoice': const CreateNewPurchaseInvoice(),
    'new_purchase_invoice': const CreateNewPurchaseInvoice(),
    'purchase_invoice_summary': const PurchaseInvoicesSummary(),
    'roles': const RolesPage(),
    'sessions_details': const SessionDetailsFilter(),
    'pos_reports': const SessionDetailsFilter(),
    'daily_qty_report': const WasteDetailsFilter(),
    'session_details_after_filter': const SessionDetailsAfterFilter(),
    'waste_details_after_filter': const WasteReport(),
    'inventory': const PhysicalInventory(),
    'physical_inventory': const PhysicalInventory(),
    'counting_form': const CountingForm(),
    'quotation_data': const QuotationData(),
    'warehouses': const WarehousesPage(),
    'create_warehouse': const CreateWarehousePage(),
    'sales_and_clients': const AccountsPage(),
    'inventory_management': const PhysicalInventory(),
  };

  final HomeController homeController = Get.find();
  late SuppliersBloc suppliersBloc;
  late BlocProvider<SuppliersBloc> bloc;

  @override
  void initState() {
    homeController.selectedTab.value='dashboard_summary';
    homeController.isOpened.value = true;
    homeController.isMenuOpened = true;
    suppliersBloc = SuppliersBloc(
      SupplierRepository(SupplierApi(http.Client())),
    );
     bloc =BlocProvider<SuppliersBloc>(create: (context) =>suppliersBloc,child: SupplierAccountsPage(),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    contentList.addAll(
      {
        'suppliers':  BlocProvider.value(
          value: suppliersBloc, // reuse the same instance
          child: SupplierAccountsPage(),
        ),
        'purchases_and_suppliers':  BlocProvider.value(
          value: suppliersBloc, // reuse the same instance
          child: SupplierAccountsPage(),
        ),
        'supplierAccounts':  BlocProvider.value(
          value: suppliersBloc, // reuse the same instance
          child: SupplierAccountsPage(),
        ),
        'add_new_supplier': MultiBlocProvider(
          providers: [
            BlocProvider.value( value: suppliersBloc, ),
            BlocProvider<SuppliersCreationBloc>(
              create: (context) => SuppliersCreationBloc(
                SupplierCreationRepository(
                  SupplierCreationApi(http.Client()),
                ),
              )..add(LoadSupplierCreation('',1)),
            ),
            BlocProvider<CountryBloc>(
              create: (context) => CountryBloc(
                CountryRepository(
                  CountryApi(http.Client()),
                ),
              )..add(LoadCountryCreation(search: '',selectedCountry: null,shouldLoad: false,page:  1)),
            ),
            BlocProvider<CitiesBloc>(
              create: (context) => CitiesBloc(
                repository: CityRepository(
                  CityApi(http.Client()),
                ),
                countryBloc: context.read<CountryBloc>(),
              ),
            ),
            BlocProvider<CheckBoxCubit>(
              create: (context) => CheckBoxCubit({"blocked":false, "show_in_POS":false}),
            ),
          ],
          child: AddNewSupplier(),
        ),
        }
    );
    var maxWidth = MediaQuery.of(context).size.width * 0.21;
    var minWidth = MediaQuery.of(context).size.width * 0.045;
    return Obx(
      () => Container(
        color: TypographyColor.searchBar,
        child: Row(
          children: [
            SideBarBasic(
              maxWidth: MediaQuery.of(context).size.width * 0.21,
              minWidth: MediaQuery.of(context).size.width * 0.045,
            ),
            GestureDetector(
              onTap: homeController.hideMenus,
              child: SizedBox(
                // width:MediaQuery.of(context).size.width -homeController. widthAnimation.value,
                width:
                    homeController.isOpened.value
                        ? MediaQuery.of(context).size.width - maxWidth
                        : MediaQuery.of(context).size.width - minWidth,
                child: Column(
                  children: [
                    const HomeAppBar(),
                    gapH56,
                    Expanded(
                      child: contentList[homeController.selectedTab.value] ??
                          const SizedBox(),
                    ),
                  ],
                ),

              ),
            ),
            // )
          ],
        ),
      ),
    );
  }
}

class AppBarClickableText extends StatelessWidget {
  const AppBarClickableText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: TypographyColor.titleTable),
      ),
    );
  }
}

class MobileHomeBody extends StatefulWidget {
  const MobileHomeBody({super.key});

  @override
  State<MobileHomeBody> createState() => _MobileHomeBodyState();
}

class _MobileHomeBodyState extends State<MobileHomeBody> {
  Map<String, Widget> contentList = {
    'items': const MobileProductsPage(),
    'stock': const MobileProductsPage(),
    'products': const MobileProductsPage(),
    // 'quotation': (Platform.isIOS || Platform.isAndroid)?CreateNewQuotationForMobileApp():  MobileCreateNewQuotation(),
    // 'new_quotation': const MobileCreateNewQuotation(),
    // 'quotation_summary': const MobileQuotationSummary(),
    'add_new_client': const MobileAddNewClient(),
    'accounts': const MobileAccountsPage(),
    'clients': const MobileAccountsPage(),
    'dashboard_summary': const MobileDashboard(),
    'create_users': const AddNewUser(),
    'users': const UsersPage(),
    'account_settings': const AddNewUser(),
    'poss': const PosScreenForMobile(),
    'roles': const RolesPage(),
    'back-office': const RolesAndPermissions(),
    'sessions_details': const SessionDetailsFilter(),
    'pos_reports': const SessionDetailsFilter(),
    'session_details_after_filter': const MobileSessionDetailsAfterFilter(),
    'transfers': const MobileTransfersSummary(),
    'transfer_in': const TransferInForMobile(),
    'transfer_details': const MobileTransferDetails(),
    'transfer_out': const MobileTransferOut(),
    'replenish_transfer': const MobileReplenish(),
    'replenishment': const MobileReplenishment(),
    'inventory': const MobilePhysicalInventory(),
    'physical_inventory': const MobilePhysicalInventory(),
    'counting_form': const MobileCountingForm(),
    'quotation_data': const QuotationData(),
    'warehouses': const WarehousesPage(),
    'create_warehouse': const CreateWarehousePage(),
    'sales_and_clients': const MobileAccountsPage(),
    // 'purchases_and_suppliers':const Suppliers(),
    'inventory_management': const MobilePhysicalInventory(),
  };
  final HomeController homeController = Get.find();
  @override
  void initState() {
    homeController.setIsMobile(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [SizedBox(width: 5), AdminSectionInHomeAppBar()],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  color: TypographyColor.searchBar,
                  child: Obx(
                    () => Column(
                      children: [
                        const HomeAppBarMenus(isDesktop: false),
                        gapH24,
                        contentList[homeController.selectedTab.value] ??
                            const SizedBox(),
                        // const ProductsPage()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
