import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/reward_service.dart';

class RewardProvider with ChangeNotifier {
  RewardProvider(this._service, this._userIdentityProvider) {
    log("RewardProvider created");
    refresh();
  }

  final RewardService _service;

  UserIdentityProvider _userIdentityProvider;

  List<Reward> _rewards = [];
  List<Reward> get rewards => _rewards;

  Future<void> addReward(Reward reward) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      await _service.insertReward(familyId, reward);
      await refresh();
    } else {
      // TODO: Report some kind of error, possibly.
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

  Future<void> refresh() async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      _rewards = await _service.getRewardsByFamily(familyId);
    } else {
      // TODO: empty this array once service is complete
      _rewards = [
        const Reward(
            title: 'Ice cream treat',
            description: '\u{1F366}',
            points: 20,
            quantity: 10),
        const Reward(
            title: 'Trampoline Park',
            description: '\u{1F9D1}',
            points: 250,
            quantity: 2),
        const Reward(
            title: 'Movie Night',
            description: '\u{1F4FD}',
            points: 50,
            quantity: 5),
        const Reward(
            title: 'Party with friends',
            description: '\u{1F389}',
            points: 200,
            quantity: 2),
      ];
    }
    notifyListeners();
    log("RewardProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
