import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/reward_redemption.dart';

class RewardRedemptionService {
  static const String _rewardRedemptionTable = "redeemed_reward";
  static const String _familyRewardRedemptionView = "family_redeemed_reward";

  RewardRedemptionService([SupabaseClient? supabaseClient])
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  Future<List<RewardRedemption>> getRewardRedemptionsByFamily(
      int familyId) async {
    var result = await _supabaseClient
        .from(_familyRewardRedemptionView)
        .select('id, person_id, reward_id, quantity, timestamp')
        .eq("family_id", familyId);
    return result.map(_mapToRedeemedReward).toList();
  }

  Future<RewardRedemption> insertRewardRedemption(
      RewardRedemption redemption) async {
    return _mapToRedeemedReward(
      (await _supabaseClient
              .from(_rewardRedemptionTable)
              .insert(_rewardRedemptionToMap(redemption))
              .select())
          .single,
    );
  }

  Future<void> deleteRewardRedemption(RewardRedemption redemption) async {
    await _supabaseClient
        .from(_rewardRedemptionTable)
        .delete()
        .match({'id': redemption.id});
  }

  Future<void> updateRewardRedemption(RewardRedemption redemption) async {
    await _supabaseClient
        .from(_rewardRedemptionTable)
        .update(_rewardRedemptionToMap(redemption))
        .match({'id': redemption.id});
  }

  RewardRedemption _mapToRedeemedReward(Map<String, dynamic> map) =>
      RewardRedemption(
        id: map['id'],
        rewardId: map['reward_id'],
        childId: map['person_id'],
        quantity: map['quantity'],
        timestamp: DateTime.parse(map['timestamp']),
      );

  Map<String, dynamic> _rewardRedemptionToMap(RewardRedemption redemption) => {
        'reward_id': redemption.rewardId,
        'person_id': redemption.childId,
        'quantity': redemption.quantity,
        'timestamp': redemption.timestamp.toString(),
      };
}
