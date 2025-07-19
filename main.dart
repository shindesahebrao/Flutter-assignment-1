// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}

// models/plant.dart
class Plant {
  final String name;
  final String category;
  final String image;
  final double price;

  Plant({
    required this.name,
    required this.category,
    required this.image,
    required this.price,
  });
}

final List<Plant> plants = [
  Plant(
    name: 'Aloe Vera',
    category: 'Indoor',
    image: 'assets/images/aloe.png',
    price: 15.0,
  ),
  Plant(
    name: 'Cactus',
    category: 'Outdoor',
    image: 'assets/images/cactus.png',
    price: 20.0,
  ),
];

// widgets/plant_card.dart
class PlantCard extends StatelessWidget {
  final Plant plant;
  const PlantCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(plant: plant)),
        );
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: plant.image,
              child: Image.asset(plant.image, height: 100),
            ),
            SizedBox(height: 8),
            Text(
              plant.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("\$${plant.price}", style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

// screens/home_screen.dart
class HomeScreen extends StatelessWidget {
  final List<String> categories = ['Popular', 'Outdoor', 'Indoor', 'Top Pick'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello User',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text(categories[index])),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plants.length,
                itemBuilder: (context, index) =>
                    PlantCard(plant: plants[index]),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/shipping.png', height: 60),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Free Shipping on all orders!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// screens/detail_screen.dart
class DetailScreen extends StatelessWidget {
  final Plant plant;
  const DetailScreen({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: BackButton(),
        actions: [Icon(Icons.favorite_border), SizedBox(width: 16)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: plant.image,
                child: Image.asset(plant.image, height: 150),
              ),
            ),
            SizedBox(height: 20),
            Text(
              plant.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(plant.category, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text(
              "\$${plant.price}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [Icon(Icons.wb_sunny), Text("Light")]),
                Column(children: [Icon(Icons.opacity), Text("Water")]),
                Column(children: [Icon(Icons.thermostat), Text("Temp")]),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Read more...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
