import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/reward.dart';

class RewardService {
  static const String _rewardTable = "reward";

  Future<List<Reward>> getRewardsByFamily(int familyId) async {
    var result = await Supabase.instance.client
        .from(_rewardTable)
        .select("id, family_id, title, description, points, quantity")
        .eq("family_id", familyId);
    return result.map(_mapToReward).toList();
  }

  Future<void> insertReward(Reward reward) async {
    await Supabase.instance.client
        .from(_rewardTable)
        .insert(_rewardToMap(reward));
  }

  Future<void> deleteReward(Reward reward) async {
    await Supabase.instance.client
        .from(_rewardTable)
        .delete()
        .match({'id': reward.id});
  }

  Future<void> updateReward(Reward reward) async {
    await Supabase.instance.client
        .from(_rewardTable)
        .update(_rewardToMap(reward))
        .match({'id': reward.id});
  }

  Reward _mapToReward(Map<String, dynamic> map) => Reward(
        id: map['id'],
        familyId: map['family_id'],
        title: map['title'],
        description: map['description'],
        points: map['points'],
        quantity: map['quantity'],
      );

  Map<String, dynamic> _rewardToMap(Reward reward) => {
        'family_id': reward.familyId,
        'title': reward.title,
        'description': reward.description,
        'points': reward.points,
        'quantity': reward.quantity,
      };
}
