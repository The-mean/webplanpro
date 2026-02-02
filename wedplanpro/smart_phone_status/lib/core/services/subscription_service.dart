import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import 'local_store.dart';

class SubscriptionService {
  SubscriptionService(this._store);

  final LocalStore _store;
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];
  bool _available = false;

  static const Set<String> productIds = {
    'smart_phone_status_monthly',
    'smart_phone_status_yearly',
  };

  bool get isPro => _store.isPro;
  List<ProductDetails> get products => _products;

  Future<void> init() async {
    _available = await _iap.isAvailable();
    if (_available) {
      _subscription = _iap.purchaseStream.listen(
        _handlePurchaseUpdates,
        onError: (_) {},
      );
      await fetchProducts();
    }
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  Future<List<ProductDetails>> fetchProducts() async {
    if (!_available) {
      return [];
    }
    final response = await _iap.queryProductDetails(productIds);
    _products = response.productDetails;
    return _products;
  }

  Future<void> buy(ProductDetails product) async {
    final purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  Future<bool> checkEntitlementIfNeeded() async {
    final now = DateTime.now();
    final lastCheck = _store.lastEntitlementCheckMillis;
    final validUntil = _store.proValidUntilMillis;
    final nowMs = now.millisecondsSinceEpoch;
    final cachedValid =
        _store.isPro && validUntil != null && nowMs < validUntil;
    final needsCheck = lastCheck == null ||
        nowMs - lastCheck > const Duration(days: 7).inMilliseconds ||
        !cachedValid;

    if (!needsCheck) {
      return _store.isPro;
    }

    if (!_available) {
      _setEntitlement(_store.isPro, now);
      return _store.isPro;
    }

    var pro = false;
    final response = await _iap.queryPastPurchases();
    for (final purchase in response.pastPurchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        pro = true;
        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
        break;
      }
    }
    _setEntitlement(pro, now);
    return pro;
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        _setEntitlement(true, DateTime.now());
      }
      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }

  void _setEntitlement(bool isPro, DateTime now) {
    _store.isPro = isPro;
    _store.lastEntitlementCheckMillis = now.millisecondsSinceEpoch;
    _store.proValidUntilMillis =
        isPro ? now.add(const Duration(days: 7)).millisecondsSinceEpoch : null;
  }
}
