import 'package:budgetbeam/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

BannerAd bannerAd = BannerAd(
  size: AdSize.banner,
  adUnitId: bannerAdsId,
  request: const AdRequest(),
  listener: BannerAdListener(onAdLoaded: (ad) {
    print("Banner Ad Loaded");
  }, onAdFailedToLoad: (ad, error) {
    print("Banner Ad Failed to Load");
  }),
);
