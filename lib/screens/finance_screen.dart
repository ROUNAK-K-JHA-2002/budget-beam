import 'package:budgetbeam/provider/expense_provider.dart';
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
    // late ValueNotifier<String> selectedFilter = ValueNotifier("All");
    late ValueNotifier<String> selectedType = ValueNotifier("All Transactions");
    return Scaffold(
      body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/Images/homeBg.svg",
                width: 100.w,
              ),
              Positioned(
                  top: 10.h,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Transactions",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              Positioned(
                top: 20.h,
                child: Container(
                  width: 100.w,
                  height: 80.h,
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                                  final result = generateColorAndAbbreviation(
                                      entity.name, entity.id);
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
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
                                                    color: result['color'],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(
                                                    result['abbreviation'],
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
              ),
            ],
          )),
    );
  }
}
