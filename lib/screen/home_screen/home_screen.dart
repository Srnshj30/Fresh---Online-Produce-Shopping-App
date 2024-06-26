import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_grocery_app/provider/product_provider.dart';
import 'package:fresh_grocery_app/provider/user_provider.dart';
import 'package:fresh_grocery_app/screen/home_screen/single_product.dart';
import 'package:fresh_grocery_app/screen/product_overview/product_overview.dart';
import 'package:fresh_grocery_app/screen/review_cart/review_cart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../search/search.dart';
import 'drawer_side.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;

  Widget listTitle(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchVegeProductData();
    productProvider.fetchFruitProductData();
    productProvider.fetchHerbProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 231, 231),
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        // elevation: 0,
        title: const Text(
          'Home',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 17,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getAllProductSearch,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  size: 24,
                  color: Color.fromARGB(255, 161, 174, 177),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 12),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey[300],
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ReviewCart(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  size: 22,
                  color: Color.fromARGB(255, 161, 174, 177),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 12),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey[300],
              child: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  GoogleSignIn().signOut();
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 22,
                  color: Color.fromARGB(255, 161, 174, 177),
                ),
              ),
            ),
          ),
        ],
        backgroundColor:
            const Color.fromARGB(255, 130, 172, 194), //Taskbar Color
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/vegi.jpg'),
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60, bottom: 0),
                          child: Container(
                            height: 55,
                            width: 105,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              color: Color.fromARGB(255, 207, 215, 221),
                            ),
                            child: const Center(
                              child: Text(
                                'Fresh',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(236, 42, 118, 108),
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Great Vibes',
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 19,
                                      color: Color.fromARGB(220, 81, 228, 132),
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // color: Colors.blue,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 55, top: 40),
                          child: Text(
                            '30% Off',
                            style: TextStyle(
                              fontSize: 35,
                              color: Color.fromARGB(255, 200, 230, 201),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Text(
                            "On all Vegetable Products!!!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 200, 230, 201),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 80, top: 15),
                          child: Text(
                            '*Terms and Conditions Applied',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 8,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fresh Vegetables',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Search(
                            search: productProvider.getVegeProductDataList,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Color.fromARGB(255, 121, 120, 120),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.getVegeProductDataList.map(
                  (e) {
                    return SingleProduct(
                      productImage: e.productImage,
                      productName: e.productName,
                      productUnit: e,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductOverview(
                              productUnit: e,
                              productImage: e.productImage,
                              productName: e.productName,
                              productAbout: e.productAbout,
                              productPrice: e.productPrice,
                              productId: e.productId,
                            ),
                          ),
                        );
                      },
                      productPrice: e.productPrice,
                      productId: e.productId,
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fresh Fruits',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Search(
                            search: productProvider.getFruitProductDataList,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Color.fromARGB(255, 121, 120, 120),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.getFruitProductDataList.map(
                  (e) {
                    return SingleProduct(
                      productUnit: e,
                      productImage: e.productImage,
                      productName: e.productName,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductOverview(
                              productUnit: e,
                              productImage: e.productImage,
                              productName: e.productName,
                              productAbout: e.productAbout,
                              productPrice: e.productPrice,
                              productId: e.productId,
                            ),
                          ),
                        );
                      },
                      productPrice: e.productPrice,
                      productId: e.productId,
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Herbs Seasonings',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Search(
                            search: productProvider.getHerbProductDataList,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Color.fromARGB(255, 121, 120, 120),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.getHerbProductDataList.map(
                  (e) {
                    return SingleProduct(
                      productUnit: e,
                      productImage: e.productImage,
                      productName: e.productName,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductOverview(
                              productUnit: e,
                              productImage: e.productImage,
                              productName: e.productName,
                              productAbout: e.productAbout,
                              productPrice: e.productPrice,
                              productId: e.productId,
                            ),
                          ),
                        );
                      },
                      productPrice: e.productPrice,
                      productId: e.productId,
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
