import 'package:flutter/material.dart';
import '../controllers/api_service.dart';
import '../models/generic/api_response_wrapper.dart';
import '../models/resourceModels/resource_item_model.dart';
import '../utils/global_variables.dart';

class ResourceBundleProvider with ChangeNotifier {
  final ApiService service = ApiService();
  final List<ResourceItem> _resources = [];

  List<ResourceItem> get resources => _resources;

  Future<void> loadAllResources() async {
    try {
      final response = await service.sendRequest(getResourcesApi, method: 'GET');
      final apiResponse = ApiResponse<List<ResourceItem>>.fromJson(
        response,
            (data) {
          final resourceList = (data['resource'] as List?) ?? [];
          return resourceList.map((e) => ResourceItem.fromJson(e)).toList();
        },
      );

      _resources.clear();
      _resources.addAll(apiResponse.data ?? []);

      debugPrint("✅ Loaded \${_resources.length} resources");
    } catch (e) {
      debugPrint("❌ Failed to load resources: $e");
    }
    notifyListeners();
  }

  void setResources(List<ResourceItem> resources) {
    _resources.clear();
    _resources.addAll(resources);
    notifyListeners();
  }

  ResourceItem? getItemByName(String name) {
    try {
      return _resources.firstWhere((item) => item.name == name);
    } catch (_) {
      return null;
    }
  }

  List<ResourceItem> getItemsByType(String type) {
    return _resources.where((item) => item.type == type).toList();
  }
}
