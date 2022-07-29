import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';

// components
import 'package:foodelo/general_components/user_credentials_object.dart';

class HomeScreen extends StatefulWidget {
  static const screenId = 'Home_screen';
  final UserCredentials userCredentials;

  const HomeScreen({Key? key, required this.userCredentials}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List currentProductList = [];

  NetworkHelper networkHelper = NetworkHelper();

  refreshProductList() async {
    print({widget.userCredentials.userId});
    Map<String, dynamic> responseMap = await networkHelper
        .getProductsListOnline(widget.userCredentials.userId);
    print('Response to the getProductsList request: $responseMap');
    // I think it's a backend problem. I'm sending the correct request
    // TODO: fix "Response to the getProductsList request: {result: Unauthorized, Access Denied, status: 401}"
  }

  @override
  void initState() {
    super.initState();
    // initialize the products
    refreshProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Foodelo'),
        backgroundColor: Colors.black38,
        automaticallyImplyLeading: false,
        actions: [
          // Cart Button
          IconButton(
            onPressed: () async {
              Map<String, dynamic> responseMap = await networkHelper
                  .getCompleteCartOnline(userId: widget.userCredentials.userId);
              print('Response to the getCompleteCart request: $responseMap');
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: Center(
        // Button for testing the refreshProductsList Button
        child: MaterialButton(
          color: Colors.grey,
          onPressed: () {
            refreshProductList();
          },
          child: Text('refresh products list'),
        ),
      ),
    );
  }
}
