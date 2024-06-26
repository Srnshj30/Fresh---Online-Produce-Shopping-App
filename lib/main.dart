import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fresh_grocery_app/auth/sign_in.dart';
import 'package:fresh_grocery_app/provider/check_out_provider.dart';
import 'package:fresh_grocery_app/provider/product_provider.dart';
import 'package:fresh_grocery_app/provider/review_cart_provider.dart';
import 'package:fresh_grocery_app/provider/user_provider.dart';
import 'package:fresh_grocery_app/provider/wishlist_provider.dart';
import 'package:fresh_grocery_app/screen/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<WishlistProvider>(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider<CheckOutProvider>(
          create: (context) => CheckOutProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold();
              }
              if (snapshot.hasData) {
                return const HomeScreen();
              }

              return const SignIn();
            }),
      ),
    );
  }
}
