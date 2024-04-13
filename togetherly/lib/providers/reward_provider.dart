import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/models/reward_redemption.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/reward_redemption_service.dart';
import 'package:togetherly/services/reward_service.dart';

import '../models/child.dart';

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
    if(reward.quantity > quantity) {
      await updateReward(reward.copyWith(quantity: (reward.quantity - quantity)));
    } else if(reward.quantity == quantity) {
      await _service.deleteReward(reward);
    }
    await _personProvider.updatePerson(child.copyWith(totalPoints: child.totalPoints - (quantity * reward.points)));
    await _redemptionService.insertRewardRedemption(RewardRedemption(rewardId: reward.id!, childId: child.id!, quantity: quantity, timestamp: DateTime.now()));
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
