import 'package:budgetbeam/provider/expense_provider.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncExpenses = ref.watch(expenseProvider);
    final TabController tabController =
        TabController(length: 2, vsync: Scaffold.of(context));
    // late ValueNotifier<String> selectedFilter = ValueNotifier("All");
    late ValueNotifier<String> selectedType = ValueNotifier("All Transactions");
    return Scaffold(
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
                            child: const Text("ListView"))),
                    Tab(
                        child: Container(
                            width: 40.w,
                            alignment: Alignment.center,
                            child: const Text("Analyze"))),
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
                          const Icon(Icons.filter_list),
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
                                itemCount:
                                    entities.length > 4 ? 4 : entities.length,
                                itemBuilder: (context, index) {
                                  entities.sort((a, b) =>
                                      b.dateCreated.compareTo(a.dateCreated));
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
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(entity.name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)),
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
                                                  Text(formatDate(
                                                      entity.dateCreated))
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                              "${entity.type == "income" ? "+" : "-"} ₹${entity.amount}",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: entity.type == "income"
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontWeight: FontWeight.w600))
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
                Container(
                  width: 100.w,
                  height: 50.h,
                  child: Text("Analyze"),
                )
              ]),
            )
          ],
        ),
      )),
    );
  }
}
