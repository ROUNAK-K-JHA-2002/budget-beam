import 'package:budgetbeam/components/banner_ads_widget.dart';
import 'package:budgetbeam/components/line_graph.dart';
import 'package:budgetbeam/main.dart';
import 'package:budgetbeam/provider/expense_provider.dart';
import 'package:budgetbeam/screens/add_expense.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  ValueNotifier<String> chartViewFrequency = ValueNotifier("0");

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
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

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  Future<void> loadChartViewCount() async {
    String? count = await storage.read(key: "chartViewCount");
    chartViewFrequency.value = count ?? "0";
  }

  Future<void> _incrementChartViewCount() async {
    chartViewFrequency.value =
        (int.parse(chartViewFrequency.value) + 1).toString();
    if (chartViewFrequency.value == "0") {
      showInterstitialAd();
    }
    if (int.parse(chartViewFrequency.value) >= 3) {
      showInterstitialAd();
      chartViewFrequency.value = "0";
    }
    await storage.write(
        key: "chartViewCount", value: chartViewFrequency.toString());
  }

  @override
  Widget build(BuildContext context) {
    final asyncExpenses = ref.watch(expenseProvider);
    final TabController tabController =
        TabController(length: 2, vsync: Scaffold.of(context));
    // late ValueNotifier<String> selectedFilter = ValueNotifier("All");
    late ValueNotifier<String> selectedType = ValueNotifier("Overall");

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
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Container(
                  width: 80.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: TabBar(
                      controller: tabController,
                      onTap: (index) {
                        if (index == 1) {
                          showInterstitialAd();
                          // _incrementChartViewCount();
                        }
                      },
                      indicator: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelColor: kPrimaryColor,
                      splashFactory: InkSplash.splashFactory,
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                            child: Container(
                                width: 80.w,
                                alignment: Alignment.center,
                                child: const Text("List View"))),
                        Tab(
                            child: Container(
                                width: 40.w,
                                alignment: Alignment.center,
                                child: const Text("Chart View"))),
                      ]),
                )),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                ValueListenableBuilder(
                    valueListenable: selectedType,
                    builder: (context, value, child) {
                      return Container(
                        width: 100.w,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        child: Column(
                          children: [
                            // Row(
                            //   children: [
                            //     IconButton(
                            //         onPressed: () {}, icon: Icon(Icons.arrow_back)),
                            //     Text(monthNames[DateTime.now().month - 1])
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    selectedType.value = "Overall";
                                  },
                                  child: Container(
                                    width: 29.w,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedType.value == "Overall"
                                          ? kPrimaryColor.withOpacity(0.12)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: kPrimaryColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const Text("Overall"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    selectedType.value = "Spend";
                                  },
                                  child: Container(
                                    width: 29.w,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedType.value == "Spend"
                                          ? kPrimaryColor.withOpacity(0.12)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: kPrimaryColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const Text("Spend"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    selectedType.value = "Income";
                                  },
                                  child: Container(
                                    width: 29.w,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedType.value == "Income"
                                          ? kPrimaryColor.withOpacity(0.12)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: kPrimaryColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const Text("Income"),
                                  ),
                                ),
                              ],
                            ),
                            const BannerAdsWidget(),
                            SizedBox(
                              height: 65.h,
                              width: 100.w,
                              child: asyncExpenses.when(
                                data: (entities) {
                                  if (entities.isEmpty) {
                                    return const Center(
                                        child: Text("No expenses found"));
                                  } else {
                                    if (selectedType.value == "Overall") {
                                      entities.sort((a, b) => b.dateCreated
                                          .compareTo(a.dateCreated));
                                    } else if (selectedType.value == "Spend") {
                                      entities = entities
                                          .where(
                                            (element) =>
                                                element.type == "spend",
                                          )
                                          .toList();
                                      entities.sort((a, b) =>
                                          a.amount.compareTo(b.amount));
                                    } else {
                                      entities = entities
                                          .where((element) =>
                                              element.type == "income")
                                          .toList();

                                      entities.sort((a, b) =>
                                          b.amount.compareTo(a.amount));
                                    }

                                    return ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 1.h),
                                      itemCount: entities.length,
                                      itemBuilder: (context, index) {
                                        final entity = entities[index];
                                        // final result = generateColorAndAbbreviation(
                                        //     entity.name, entity.id);
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddExpense(
                                                          expense: entity,
                                                        )));
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(bottom: 2.h),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.5.h,
                                                horizontal: 3.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 5,
                                                  spreadRadius: 2,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 2.w),
                                                        alignment:
                                                            Alignment.center,
                                                        height: 5.h,
                                                        width: 5.h,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: categories
                                                                    .firstWhere(
                                                                  (element) {
                                                                    return element[
                                                                            'text'] ==
                                                                        entity
                                                                            .category;
                                                                  },
                                                                  orElse: () =>
                                                                      {
                                                                    'color':
                                                                        kPrimaryColor
                                                                  },
                                                                )['color'][100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                        child: Icon(
                                                          categories.firstWhere(
                                                              (element) {
                                                            return element[
                                                                    'text'] ==
                                                                entity.category;
                                                          },
                                                              orElse: () => {
                                                                    'color':
                                                                        kPrimaryColor
                                                                  })['icon'],
                                                          color: categories
                                                              .firstWhere(
                                                            (element) {
                                                              return element[
                                                                      'text'] ==
                                                                  entity
                                                                      .category;
                                                            },
                                                            orElse: () => {
                                                              'color':
                                                                  kPrimaryColor
                                                            },
                                                          )['color'],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              entity.name.replaceAll(
                                                                  entity
                                                                      .name[0],
                                                                  entity.name[0]
                                                                      .toUpperCase()),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          Text(
                                                            entity.category,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    13.sp),
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
                                                              color: entity
                                                                          .type ==
                                                                      "income"
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      Text(
                                                        formatDate(
                                                            entity.dateCreated),
                                                        style: TextStyle(
                                                          fontSize: 13.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                                error: (error, stack) =>
                                    Center(child: Text("Error: $error")),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                // ,
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
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
