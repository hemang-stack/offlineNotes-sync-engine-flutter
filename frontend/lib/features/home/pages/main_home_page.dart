import 'package:flutter/material.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.grey,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.black,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'LIMITED TIME',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Summer\nSale',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Up to 50% off on selected items',
                  style: TextStyle(fontSize: 15),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
