import 'package:budgetbeam/components/line_graph.dart';
import 'package:budgetbeam/components/pie_chart_graph.dart';
import 'package:budgetbeam/provider/expense_provider.dart';
import 'package:budgetbeam/services/ads_service.dart';
import 'package:budgetbeam/services/chart_services.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinanceScreen extends ConsumerStatefulWidget {
  const FinanceScreen({super.key});

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends ConsumerState<FinanceScreen> {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('${ad.adUnitId} loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 3) {
              createInterstitialAd();
            }
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    createInterstitialAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  Widget build(BuildContext context) {
    final asyncExpenses = ref.watch(expenseProvider);
    final TabController tabController =
        TabController(length: 2, vsync: Scaffold.of(context));
    // late ValueNotifier<String> selectedFilter = ValueNotifier("All");
    late ValueNotifier<String> selectedType = ValueNotifier("All Transactions");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Navigator.pushNamed(context, '/add-expense');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: SafeArea(
          child: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Container(
            //   width: 100.w,
            //   height: 10.h,
            //   alignment: Alignment.center,
            //   decoration: const BoxDecoration(
            //     color: kPrimaryColor,
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(20),
            //       bottomRight: Radius.circular(20),
            //     ),
            //   ),
            //   child: Text("Finance", style: TextStyle(fontSize: 20.sp)),
            // ),
            // bannerAdWidget(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelColor: Colors.white,
                  splashFactory: InkSplash.splashFactory,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                        child: Container(
                            width: 50.w,
                            alignment: Alignment.center,
                            child: const Text("List View"))),
                    Tab(
                        child: Container(
                            width: 40.w,
                            alignment: Alignment.center,
                            child: const Text("Chart View"))),
                  ]),
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                Container(
                  width: 100.w,
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // showDragHandle: false,
                                    elevation: 5,
                                    context: context,
                                    builder: (context) => Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w, vertical: 2.h),
                                          height: 20.h,
                                          width: 100.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "Select the type of transaction",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  selectedType.value =
                                                      "All Transactions";
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "All Transactions",
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  selectedType.value = "Income";
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Income",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  selectedType.value =
                                                      "Expense";
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Expense",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              )
                                            ],
                                          ),
                                        ));
                              },
                              child: Row(
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: selectedType,
                                      builder: (context, value, child) {
                                        return Text(value,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600));
                                      }),
                                  const Icon(Icons.keyboard_arrow_down)
                                ],
                              )),
                          GestureDetector(
                            onTap: () {
                              _showInterstitialAd();
                            },
                            child: const Icon(Icons.filter_list),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70.h,
                        width: 100.w,
                        child: asyncExpenses.when(
                          data: (entities) {
                            if (entities.isEmpty) {
                              return const Center(
                                  child: Text("No expenses found"));
                            } else {
                              return ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                itemCount: entities.length,
                                itemBuilder: (context, index) {
                                  if (selectedType.value ==
                                      "All Transactions") {
                                    entities.sort((a, b) =>
                                        b.dateCreated.compareTo(a.dateCreated));
                                  }
                                  final entity = entities[index];
                                  // final result = generateColorAndAbbreviation(
                                  //     entity.name, entity.id);
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.5.h, horizontal: 3.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 2.w),
                                                alignment: Alignment.center,
                                                height: 5.h,
                                                width: 5.h,
                                                decoration: BoxDecoration(
                                                    color:
                                                        categories.firstWhere(
                                                      (element) {
                                                        return element[
                                                                'text'] ==
                                                            entity.category;
                                                      },
                                                      orElse: () => {
                                                        'color': kPrimaryColor
                                                      },
                                                    )['color'][100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Icon(
                                                  categories.firstWhere(
                                                      (element) {
                                                    return element['text'] ==
                                                        entity.category;
                                                  },
                                                      orElse: () => {
                                                            'color':
                                                                kPrimaryColor
                                                          })['icon'],
                                                  color: categories.firstWhere(
                                                    (element) {
                                                      return element['text'] ==
                                                          entity.category;
                                                    },
                                                    orElse: () => {
                                                      'color': kPrimaryColor
                                                    },
                                                  )['color'],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      entity.name.replaceAll(
                                                          entity.name[0],
                                                          entity.name[0]
                                                              .toUpperCase()),
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                    entity.category,
                                                    style: TextStyle(
                                                        fontSize: 13.sp),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  "${entity.type == "income" ? "+" : "-"} ₹${entity.amount}",
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: entity.type ==
                                                              "income"
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Text(
                                                formatDate(entity.dateCreated),
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ],
                                          )
                                        ]),
                                  );
                                },
                              );
                            }
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) =>
                              Center(child: Text("Error: $error")),
                        ),
                      )
                    ],
                  ),
                ),
                // ,
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      width: 100.w,
                      // height: 40.h,
                      child: asyncExpenses.when(
                          data: (data) => LineGraph(expenses: data),
                          error: (error, stack) =>
                              Center(child: Text("Error: $error")),
                          loading: () =>
                              const Center(child: CircularProgressIndicator())),
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 3.w),
                    //   width: 100.w,
                    //   height: 50.h,
                    //   // height: 40.h,
                    //   child: asyncExpenses.when(
                    //       data: (data) => PieChartGraph(
                    //             expenses: data,
                    //           ),
                    //       error: (error, stack) =>
                    //           Center(child: Text("Error: $error")),
                    //       loading: () =>
                    //           const Center(child: CircularProgressIndicator())),
                    // )
                  ],
                ))
              ]),
            )
          ],
        ),
      )),
    );
  }
}
