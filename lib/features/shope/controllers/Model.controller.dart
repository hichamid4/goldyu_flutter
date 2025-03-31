import 'package:get/get.dart';
import 'package:goldyu/common/models/model.dart';
import 'package:goldyu/data/repositories/model.api.dart';

class ModelsControllers extends GetxController {
  static ModelsControllers get instance => Get.find();

  var models = <Model>[].obs;
  var selectedModel = Rxn<Model>();
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchModels();
  }

  /// Fetch all Modesl from API
  Future<void> fetchModels() async {
    try {
      var fetchedModels = await ModelApi.getModels();
      models.assignAll(fetchedModels);
    } catch (e) {
      errorMessage.value = "Error fetching modesl.";
    }
  }

  /// Select a model and fetch its models
  Future<void> selectModel(int modelId) async {
    isLoading.value = true;
    try {
      var model = await ModelApi.getModel(modelId);
      if (model != null) {
        selectedModel.value = model;
      }
    } catch (e) {
      errorMessage.value = "Error fetching model details.";
    } finally {
      isLoading.value = false;
    }
  }

  /// Create a new model
  Future<void> addModel(String name) async {
    try {
      var newModel = await ModelApi.createModel(name);
      if (newModel != null) {
        models.add(newModel);
      }
    } catch (e) {
      errorMessage.value = "Error adding model.";
    }
  }

  /// Update an existing category
  Future<void> updateModel(int id, Model model) async {
    try {
      var updatedModel = await ModelApi.updateModel(id, model);
      if (updatedModel != null) {
        int index = models.indexWhere((m) => m.id == id);
        if (index != -1) {
          models[index] = updatedModel;
        }
      }
    } catch (e) {
      errorMessage.value = "Error updating model.";
    }
  }

  /// Delete a model
  Future<void> deleteModel(int id) async {
    try {
      bool success = await ModelApi.deleteModel(id);
      if (success) {
        models.removeWhere((c) => c.id == id);
      }
    } catch (e) {
      errorMessage.value = "Error deleting model.";
    }
  }
}
