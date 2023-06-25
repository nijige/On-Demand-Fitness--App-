import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_diet_app/screens/welcom_view.dart';
import 'mode.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Category> catego = [
    Category(
      imagUrl: "assets/images/emily.png",
      name: "Yoga exercises",
    ),
    Category(
      imagUrl: "assets/images/sule.png",
      name: "Example exercises",
    ),
    Category(
      imagUrl: "assets/images/alexsandra.png",
      name: "Example exercises",
    ),
  ];

  void _goToHomeView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20),
          child: Column(
            children: [
              // Resto do seu código...

              GestureDetector(
                onTap: _goToHomeView, // Navega para outra tela
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Text(
                        "Popular Workout",
                        style: GoogleFonts.lato(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: catego.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Container(
                              height: 172,
                              width: 141,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(catego[index].imagUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              catego[index].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Screen"),
      ),
      body: Center(
        child: Text("This is another screen!"),
      ),
    );
  }
}
