import 'package:doctor_app_v2/models/medicine_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  static const String medicinesBox = 'my_medicines';

  static Future initHive() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(MedicineModelAdapter().typeId)) {
      Hive.registerAdapter(MedicineModelAdapter());
    }
  }

  //////////////////////////////////////////////////////////

  static Future addMedicine({required MedicineModel item}) async {
    final box = await Hive.openBox<MedicineModel>(medicinesBox);
    await box.put(item.id, item);
  }

  static Future<List<MedicineModel>> getMedicines() async {
    await Hive.close();
    final box = await Hive.openBox<MedicineModel>(medicinesBox);
    // await box.deleteFromDisk();
    final boxLength = box.length;
    List<MedicineModel> medicines = [];
    for (int i = 0; i < boxLength; i++) {
      medicines.add(box.getAt(i)!);
    }
    return medicines;
  }

  static Future deleteMedicineTime({required String id}) async {
    await Hive.close();
    final box = await Hive.openBox<MedicineModel>(medicinesBox);
    await box.delete(id);
  }
}
