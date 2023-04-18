import 'milestone_dto.dart';

class MilestoneListDto {
  List<MilestoneDto> milestones;

  MilestoneListDto({
    required this.milestones,
  });

  factory MilestoneListDto.fromJson(List<dynamic> json) {
    return MilestoneListDto(
      milestones: json.map((e) => MilestoneDto.fromJson(e)).toList(),
    );
  }
}
