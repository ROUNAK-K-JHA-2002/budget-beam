import 'package:budgetbeam/components/button.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Upgrade extends StatefulWidget {
  const Upgrade({super.key});

  @override
  State<Upgrade> createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clean up the Razorpay instance
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment

    // You can navigate or show a confirmation
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment failed: ${response.code} | ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    debugPrint("External Wallet selected: ${response.walletName}");
  }

  void openCheckout() {
    var options = {
      'key': dotenv.env['RAZORPAY_TEST_KEY_ID'],
      'amount':
          50000, // Amount in the smallest currency unit (e.g., paise for INR)
      'name': 'Budget Beam',
      'image':
          'https://res.cloudinary.com/dp72bbxe2/image/upload/v1737540709/lirn8tvdxfctxzxdk0sr.png',
      'description': 'One-time Payment',
      'prefill': {
        'contact': '1234567890',
        'email': 'user@example.com',
      },
      'theme': {
        'color': '#5F33E1',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Upgrade to Lifetime Premium",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            "Enjoy an ad-free experience and full access to all features for a one-time payment of just ₹100, with no subscriptions or recurring costs.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(
            "assets/Images/upgrade.png",
            width: 80.w,
            fit: BoxFit.cover,
          ),
          CustomButton(
            text: "Upgrade for Rs. 99",
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              openCheckout();
            },
          ),
          SizedBox(height: 2.h),
          CustomButton(
            isOutlined: true,
            text: "Continue with Free (Ads)",
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
          SizedBox(height: 2.h),
          Text(
            "🔒 100% Secure Payment | One-Time Payment, Lifetime Access",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'By continuing, you agree to our',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 1.w),
              Text(
                'Terms of Service ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(width: 1.w),
              Text(
                'and',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 1.w),
              Text(
                'Privacy Policy.',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
