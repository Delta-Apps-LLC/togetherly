import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/reward.dart';

class RewardService {
  static const String _rewardTable = "reward";

  Future<List<Reward>> getRewardsByFamily(int familyId) async {
    var result = await Supabase.instance.client
        .from(_rewardTable)
        .select("id, title, description, points, quantity, icon")
        .eq("family_id", familyId);
    return result.map(_mapToReward).toList();
  }

  Future<Reward> insertReward(int familyId, Reward reward) async {
    return _mapToReward(
      (await Supabase.instance.client
              .from(_rewardTable)
              .insert(_rewardToMap(reward, familyId))
              .select())
          .single,
    );
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
        title: map['title'],
        description: map['description'],
        points: map['points'],
        quantity: map['quantity'],
        icon: (map['icon'] as String).runes.single,
      );

  Map<String, dynamic> _rewardToMap(Reward reward, [int? familyId]) => {
        if (familyId != null) 'family_id': familyId,
        'title': reward.title,
        'description': reward.description,
        'points': reward.points,
        'quantity': reward.quantity,
        'icon': String.fromCharCode(reward.icon),
      };
}
