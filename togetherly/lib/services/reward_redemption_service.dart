import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/reward_redemption.dart';

class RewardRedemptionService {
  static const String _rewardRedemptionTable = "redeemed_reward";
  static const String _familyRedeemedRewardsView = "family_redeemed_rewards";

  Future<List<RewardRedemption>> getRedeemedRewardsByFamily(
      int familyId) async {
    var result = await Supabase.instance.client
        .from(_familyRedeemedRewardsView)
        .select('family_id, person_id, reward_id, quantity, timestamp')
        .eq("family_id", familyId);
    return result.map(_mapToRedeemedReward).toList();
  }

  Future<RewardRedemption> insertReward(
      int familyId, RewardRedemption redemption) async {
    return _mapToRedeemedReward(
      (await Supabase.instance.client
              .from(_rewardRedemptionTable)
              .insert(_rewardToMap(redemption, familyId))
              .select())
          .single,
    );
  }

  Future<void> deleteReward(RewardRedemption redemption) async {
    await Supabase.instance.client
        .from(_rewardRedemptionTable)
        .delete()
        .match({'id': redemption.id});
  }

  Future<void> updateReward(RewardRedemption redemption) async {
    await Supabase.instance.client
        .from(_rewardRedemptionTable)
        .update(_rewardToMap(redemption))
        .match({'id': redemption.id});
  }

  RewardRedemption _mapToRedeemedReward(Map<String, dynamic> map) =>
      RewardRedemption(
        id: map['id'],
        rewardId: map['reward_id'],
        childId: map['person_id'],
        quantity: map['quantity'],
        timestamp: map['timestamp'],
      );

  Map<String, dynamic> _rewardToMap(RewardRedemption redemption,
          [int? familyId]) =>
      {
        if (familyId != null) 'family_id': familyId,
        'id': redemption.id,
        'timestamp': redemption.timestamp,
        'person_id': redemption.childId,
        'reward_id': redemption.rewardId,
        'quantity': redemption.quantity,
      };
}
