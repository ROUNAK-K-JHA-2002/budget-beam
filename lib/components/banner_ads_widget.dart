import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/services/ads_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BannerAdsWidget extends ConsumerStatefulWidget {
  // ignore: use_super_parameters
  const BannerAdsWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends ConsumerState<BannerAdsWidget> {
  @override
  void initState() {
    super.initState();
    bannerAd.load();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    print(user);
    return bannerAd.responseInfo == null
        ? const SizedBox.shrink()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 0.5.h),
            width: bannerAd.size.width.toDouble(),
            height: user?.plan != "Premium Plan"
                ? bannerAd.size.height.toDouble()
                : 0,
            alignment: Alignment.center,
            child: user?.plan != "Premium Plan"
                ? AdWidget(ad: bannerAd)
                : const SizedBox.shrink(),
          );
  }
}
