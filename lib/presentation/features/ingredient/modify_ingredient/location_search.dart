import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/location.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/ingredient_repository_remote.dart';
import 'package:plan_meal_app/domain/entities/location_entity.dart';

class SearchLocation extends SearchDelegate {
  final IngredientRepositoryRemote ingredientRepositoryRemote =
      IngredientRepositoryRemote();
  List<Location> locationList = [];
  int page = 1;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(query: query, locationList: locationList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Location>>(
        future: ingredientRepositoryRemote.searchLocation(query, page),
        builder: (context, snapshot) {
          if (query == "") {
            return const SizedBox.shrink();
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("There is something error. Please try again");
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (!snapshot.hasData || snapshot.hasError) {
                return const Center(
                    child: Text("Sorry, no food found for you"));
              }
              locationList.addAll(snapshot.data ?? []);
              return buildSuggestionSuccess(snapshot.data);
          }
        });
  }

  Widget buildSuggestionSuccess(List<Location>? locationList) {
    if (locationList == null || locationList.isEmpty) {
      return const Center(
          child: Text("Sorry, no ingredient is founded for you"));
    }
    return ListView.builder(
        itemCount: locationList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  locationList[index].name ?? "",
                  style: const TextStyle(fontSize: 20),
                )),
                IconButton(
                    onPressed: () async {
                      LocationEntity locationEntity = LocationEntity(
                          id: locationList[index].id.toString(),
                          location: locationList[index].name ?? "");

                      Navigator.of(context).pop(locationEntity);
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
          );
        });
  }
}

class SearchResult extends StatefulWidget {
  SearchResult({Key? key, required this.query, required this.locationList})
      : super(key: key);
  final List<Location> locationList;
  final IngredientRepositoryRemote ingredientRepositoryRemote =
      IngredientRepositoryRemote();
  final String query;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Location> locationList = [];
  late int page;
  late bool isPerformingRequest;
  late bool isNoResult;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    page = 1;
    isPerformingRequest = false;
    isNoResult = false;
    locationList.addAll(widget.locationList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: const Text(
            "Create new location",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 16, top: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.green),
                              borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.green),
                            borderRadius: BorderRadius.circular(8),
                          )),
                      controller: locationController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 16, top: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Address",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.green),
                              borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.green),
                            borderRadius: BorderRadius.circular(8),
                          )),
                      controller: addressController,
                    ),
                  ),
                ],
              )),
              GestureDetector(
                onTap: () async {
                  if (locationController.text.isNotEmpty) {
                    String id = await widget.ingredientRepositoryRemote
                        .addLocation(locationController.text);
                    LocationEntity locationEntity = LocationEntity(
                        id: id,
                        location: locationController.text,
                        address: addressController.text);
                    Navigator.of(context).pop(locationEntity);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Add",
                    style: TextStyle(color: AppColors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const Text(
          "Locations",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: locationList.length + 1,
                itemBuilder: (context, index) {
                  if (index == locationList.length) {
                    return buildProcessIndicator();
                  } else {
                    return Card(
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  locationList[index].name ?? "",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  locationList[index].address ?? "",
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.gray),
                                )
                            ],
                          ),
                              )),
                          IconButton(
                              onPressed: () async {
                                LocationEntity locationEntity = LocationEntity(
                                    id: locationList[index].id.toString(),
                                    location: locationList[index].name ?? "",
                                    address: locationList[index].address ?? "");

                                Navigator.of(context).pop(locationEntity);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    );
                  }
                })),
        // isNoResult
        //     ? Container()
        //     : Container(
        //         margin: const EdgeInsets.symmetric(vertical: 16),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             GestureDetector(
        //               onTap: () async {
        //                 setState(() {
        //                   isPerformingRequest = true;
        //                 });
        //                 List<Location> queryList = await widget
        //                     .ingredientRepositoryRemote
        //                     .searchLocation(widget.query, page + 1);
        //                 if (queryList.isEmpty) {
        //                   setState(() {
        //                     isNoResult = true;
        //                   });
        //                 }
        //                 setState(() {
        //                   page = page + 1;
        //                   locationList.addAll(queryList);
        //                   isPerformingRequest = false;
        //                 });
        //               },
        //               child: const Text(
        //                 "Show more result",
        //                 style: TextStyle(fontSize: 20),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
      ],
    );
  }

  Widget buildProcessIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
