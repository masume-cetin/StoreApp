import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../controllers/api_service.dart';
import '../../cubits/search_bar_cubit.dart';
import '../../models/generic/api_list_response_wrapper.dart';
import '../../providers/resource_bundle_provider.dart';
import '../../models/categoryModels/category_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? bannerUrl; // 🔥 store the banner URL once

  @override
  void initState() {
    super.initState();
    final resourceProvider = Provider.of<ResourceBundleProvider>(context, listen: false);
    final bannerResource = resourceProvider.getItemByName("homeBanner");
    bannerUrl = bannerResource?.value;
  }

  Future<ApiListResponseWrapper<Category>> fetchAllCategories() async {
    final response = await ApiService().sendRequest('/api/categories', method: 'GET');

    return ApiListResponseWrapper<Category>.fromJson(
      response,
          (json) => Category.fromJson(json),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, String>(
      builder: (context, searchQuery) {
/* final filteredItems = allItems
            .where((item) => item.name.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

        return ListView(
          children: filteredItems.map((item) => ListTile(title: Text(item.name))).toList(),
        );*/
        return Column(
          children: [
            if (bannerUrl != null && bannerUrl!.isNotEmpty)
              SizedBox(
                height: foundation.kIsWeb ? 500 : 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  bannerUrl!,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Text("No Banner Available"),
          ],
        );
      },
    );
  }
}
