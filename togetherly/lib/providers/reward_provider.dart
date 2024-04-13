import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/models/reward_redemption.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/reward_redemption_service.dart';
import 'package:togetherly/services/reward_service.dart';

class RewardProvider with ChangeNotifier {
  RewardProvider(
    this._service,
    this._redemptionService,
    this._userIdentityProvider,
    this._personProvider,
  ) {
    log("RewardProvider created");
    refresh();
  }

  final RewardService _service;
  final RewardRedemptionService _redemptionService;

  UserIdentityProvider _userIdentityProvider;
  PersonProvider _personProvider;

  List<Reward> _rewards = [];
  Iterable<Reward> get rewards => _rewards;

  Future<void> addReward(Reward reward) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      await _service.insertReward(familyId, reward);
      await refresh();
    }
  }

  Future<void> deleteReward(Reward reward) async {
    await _service.deleteReward(reward);
    await refresh();
  }

  Future<void> updateReward(Reward reward) async {
    await _service.updateReward(reward);
    await refresh();
  }

  Future<void> redeemReward(Reward reward, int quantity, Child child) async {
    final newQuantity = reward.quantity - quantity;
    final newPoints = child.totalPoints - (quantity * reward.points);

    if (newQuantity >= 0 && newPoints >= 0) {
      await updateReward(reward.copyWith(quantity: newQuantity));
      await _personProvider
          .updatePerson(child.copyWith(totalPoints: newPoints));
      await _redemptionService.insertRewardRedemption(RewardRedemption(
        rewardId: reward.id!,
        childId: child.id!,
        quantity: quantity,
        timestamp: DateTime.now(),
      ));
      refresh();
    } else if (newPoints >= 0) {
      throw Exception("Not enough quantity remaining");
    } else {
      throw Exception("Not enough points available");
    }
  }

  Future<void> refresh() async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      _rewards = await _service.getRewardsByFamily(familyId);
    } else {
      _rewards = [];
    }
    notifyListeners();
    log("RewardProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider,
      PersonProvider personProvider) {
    _userIdentityProvider = userIdentityProvider;
    _personProvider = personProvider;
    refresh();
  }
}
