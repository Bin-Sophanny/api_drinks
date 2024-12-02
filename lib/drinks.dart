import 'package:drinks/api_drink.dart';
import 'package:drinks/model_drink.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Drinks extends StatelessWidget {
  const Drinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: const Text(
          "Drinks",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                const Positioned(
                  right: 0, // Position relative to the IconButton
                  top: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )),
      ),
      drawer: Drawer(
        child: Container(color: Colors.blue),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for Drinks here',
                prefixIcon:
                    const Icon(Icons.search_rounded, color: Colors.blue),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 5),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Icon(Icons.color_lens_outlined),
                  SizedBox(width: 15),
                  Text(
                    "Drinks",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.grid_4x4_sharp)),
                ],
              )
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Drink>>(
              future: fetchDrink(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Drinks found'));
                } else {
                  final drinks = snapshot.data!;
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1),
                      itemCount: drinks.length,
                      itemBuilder: (context, index) {
                        final drink = drinks[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.blue,width: 5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                drink.image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                drink.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$${drink.price.toStringAsFixed(2)}',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
