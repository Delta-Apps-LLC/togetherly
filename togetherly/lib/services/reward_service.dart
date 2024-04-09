import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/reward.dart';

class RewardService {
  static const String _rewardTable = "reward";

  RewardService([SupabaseClient? supabaseClient])
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  Future<List<Reward>> getRewardsByFamily(int familyId) async {
    var result = await _supabaseClient
        .from(_rewardTable)
        .select("id, title, description, points, quantity")
        .eq("family_id", familyId);
    return result.map(_mapToReward).toList();
  }

  Future<Reward> insertReward(int familyId, Reward reward) async {
    return _mapToReward(
      (await _supabaseClient
              .from(_rewardTable)
              .insert(_rewardToMap(reward, familyId))
              .select())
          .single,
    );
  }

  Future<void> deleteReward(Reward reward) async {
    await _supabaseClient.from(_rewardTable).delete().match({'id': reward.id});
  }

  Future<void> updateReward(Reward reward) async {
    await _supabaseClient
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
      );

  Map<String, dynamic> _rewardToMap(Reward reward, [int? familyId]) => {
        if (familyId != null) 'family_id': familyId,
        'title': reward.title,
        'description': reward.description,
        'points': reward.points,
        'quantity': reward.quantity,
      };
}
