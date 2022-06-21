import 'package:hive/hive.dart';
part 'social_networks.g.dart';

// to generate model.g.dart run> flutter pub run build_runner build

@HiveType(typeId: 6)
class SocialNetworks {
  SocialNetworks({this.facebook, this.instagram, this.whatsapp, this.youtube});

  @HiveField(0)
  bool? facebook = false;

  @HiveField(1)
  bool? instagram = false;

  @HiveField(2)
  bool? whatsapp = false;

  @HiveField(3)
  bool? youtube = false;

  factory SocialNetworks.fromMap(Map<String, dynamic> json) => SocialNetworks(
      facebook: json['facebook'],
      instagram: json['instagram'],
      whatsapp: json['whatsapp'],
      youtube: json['youtube']);

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'instagram': instagram,
      'whatsapp': whatsapp,
      'youtube': youtube
    };
  }

  void clear() {
    facebook = false;
    instagram = false;
    whatsapp = false;
    youtube = false;
  }

  @override
  String toString() {
    return 'FACEBOOK: $facebook, INSTAGRAM: $instagram, YOUTUBE: $youtube, WHATSAPP: $whatsapp';
  }
}
