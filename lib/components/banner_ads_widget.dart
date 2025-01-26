import 'package:budgetbeam/services/ads_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BannerAdsWidget extends StatefulWidget {
  // ignore: use_super_parameters
  const BannerAdsWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      alignment: Alignment.center,
      child: AdWidget(ad: bannerAd..load()),
    );
  }
}
