import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:budgetbeam/provider/expense_provider.dart';
import 'package:budgetbeam/provider/net_balance_provider.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/services/object_box.dart';
import 'package:budgetbeam/services/user_services.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final double budget = 10000;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncExpenses = ref.watch(expenseProvider);
    final netBalance = ref.watch(netBalanceProvider);
    final user = ref.watch(userNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        getUser(FirebaseAuth.instance.currentUser?.uid ?? '', context, ref);
      }
    });

    String getGreeting() {
      DateTime now = DateTime.now();
      int hour = now.hour;
      if (hour >= 5 && hour < 12) {
        return 'Good morning';
      } else if (hour >= 12 && hour < 18) {
        return 'Good afternoon';
      } else {
        return 'Good evening';
      }
    }

    return Scaffold(
        // backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
            backgroundColor: kSecondaryColor,
            onPressed: () {
              Navigator.pushNamed(context, '/add-expense');
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: Container(
          width: 100.w,
          height: 100.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  // color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              Positioned(
                  top: 10,
                  child: SafeArea(
                      child: Container(
                    width: 100.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getGreeting(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              user?.name ?? "Ayoumouns User",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                            ObjectBoxStore.instance.store
                                .box<ExpenseEntity>()
                                .removeAll();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              user?.profilePhoto ??
                                  "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
                              height: 5.h,
                              width: 5.h,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
              Positioned(
                  top: 18.h,
                  left: 2.5.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                    width: 95.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Total Balance",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    SizedBox(width: 1.w),
                                    netBalance.netBalance < 0
                                        ? const Icon(Icons.arrow_downward,
                                            color: Colors.white60)
                                        : const Icon(Icons.arrow_upward,
                                            color: Colors.white60),
                                  ],
                                ),
                                Text(
                                  "₹ ${netBalance.netBalance}",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const Icon(Icons.more_vert, color: Colors.white)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Income",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white60),
                                ),
                                Text(
                                  "₹ ${netBalance.netIncome}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Spendings",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white60),
                                ),
                                Text(
                                  "₹ ${netBalance.netSpend}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              Positioned(
                  top: 45.h,
                  child: Container(
                    width: 100.w,
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        netBalance.netSpend > budget
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 2.h),
                                child: Text(
                                    "!! You have exceeded your daily budget by ₹ ${netBalance.netSpend - budget}",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red)))
                            : const SizedBox(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recent Transactions",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            // Text("See all",
                            //     style: TextStyle(
                            //         fontSize: 16, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                          width: 90.w,
                          child: asyncExpenses.when(
                            data: (entities) {
                              Future.microtask(() {
                                if (context.mounted) {
                                  ref
                                      .read(netBalanceProvider.notifier)
                                      .calculateNetBalance(entities);
                                }
                              });
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
                                        entity.name, index);
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.5.h, horizontal: 3.w),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 2.w),
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
                                                    Text(entity.name,
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
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
                                                    color:
                                                        entity.type == "income"
                                                            ? Colors.green
                                                            : Colors.red,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ]),
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
                  ))
            ],
          ),
        ));
  }
}
