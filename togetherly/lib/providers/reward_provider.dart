import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/reward_service.dart';

class RewardProvider with ChangeNotifier {
  RewardProvider(this._service, this._userIdentityProvider, this._personProvider) {
    log("RewardProvider created");
    refresh();
  }

  final RewardService _service;

  UserIdentityProvider _userIdentityProvider;
  PersonProvider _personProvider;

  List<Reward> _rewards = [];
  List<Reward> get rewards => _rewards;

  Future<void> addReward(Reward reward) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      await _service.insertReward(familyId, reward);
      await refresh();
    } else {
      //TODO throw error?
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

  Future<void> redeemReward(Reward reward, int quantity) async {
    if(reward.quantity > quantity) {
      await updateReward(reward.copyWith(quantity: (reward.quantity - quantity)));
    } else if(reward.quantity == quantity){
      await _service.deleteReward(reward);
    } else {
      //TODO: what does the front end want?
      await _service.deleteReward(reward);
    }
    //TODO: add to redeem reward service/table
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

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
