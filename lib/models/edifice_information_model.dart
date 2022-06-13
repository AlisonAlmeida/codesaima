import 'package:hive_flutter/hive_flutter.dart';
part 'edifice_information_model.g.dart';

@HiveType(typeId: 7)
class EdificeInformation {
  EdificeInformation({
    this.residenceSituation = '',
    this.localizationResidence = '',
    this.supplyWaterSystem = '',
    this.kindConstruction = '',
    this.kindFloor = '',
    this.garbageCollection = '',
    this.electricalNetwork = '',
    this.sewerage = '',
    this.hasInternalBathroom = '',
    this.numberFamiliesLiveResidence = '',
    this.numberResidentFamiliarLiveResidence = '',
    this.numberRoomResidence = '',
    this.kindResidence = '',
    this.reformNeed = '',
  });
  @HiveField(0)
  final String kindResidence;
  @HiveField(1)
  final String localizationResidence;
  @HiveField(2)
  final String supplyWaterSystem;
  @HiveField(3)
  final String kindConstruction;
  @HiveField(4)
  final String kindFloor;
  @HiveField(5)
  final String garbageCollection;
  @HiveField(6)
  final String electricalNetwork;
  @HiveField(7)
  final String sewerage; //SISTEMA DE ESGOTO
  @HiveField(8)
  final String hasInternalBathroom;
  @HiveField(9)
  final String numberFamiliesLiveResidence;
  @HiveField(10)
  final String numberResidentFamiliarLiveResidence;
  @HiveField(11)
  final String numberRoomResidence;
  @HiveField(12)
  final String residenceSituation;

  @HiveField(13)
  final String reformNeed;
}
