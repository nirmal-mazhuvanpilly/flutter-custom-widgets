import 'package:flutter/material.dart';
import 'package:limoverse_widgets/animated_dots/animated_dots.dart';
import 'package:limoverse_widgets/beizer/cubic_bezier.dart';
import 'package:limoverse_widgets/chart/chart_screen.dart';
import 'package:limoverse_widgets/community/community_page.dart';
import 'package:limoverse_widgets/custom_grid/custom_grid_view.dart';
import 'package:limoverse_widgets/custom_track_shape.dart';
import 'package:limoverse_widgets/date_n_time_picker/custom_date_picker.dart'
    as custom_date_picker;
import 'package:limoverse_widgets/matrices/matrices.dart';
import 'package:limoverse_widgets/story/story_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RangeValues rangeValues = const RangeValues(0, 20);

  final sampleText =
      """Join us at the "Limoverse presents World Biohack Summit Dubai 2023" starting tomorrow.
      https://cretezy.com
      www.livehealthcaresolution.com
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Ink(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.red],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.white.withOpacity(.10),
                    highlightColor: Colors.white.withOpacity(.10),
                    child: const SizedBox(
                      width: double.maxFinite,
                      height: 48,
                      child: Center(
                          child: Text(
                        "ADD",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )),
            ),
            const HeightWidget(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey)),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.white.withOpacity(.10),
                    highlightColor: Colors.white.withOpacity(.10),
                    child: const SizedBox(
                      width: double.maxFinite,
                      height: 48,
                      child: Center(
                          child: Text(
                        "ADD",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )),
            ),
            const HeightWidget(height: 10),
            Ink(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      // color: Colors.grey,
                      shape: BoxShape.circle),
                ),
              ),
            ),
            const HeightWidget(height: 10),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                inactiveTrackColor: Colors.grey.shade200,
                rangeThumbShape: const CustomRoundRangeSliderThumbShape(
                    strokeWidth: 1.5,
                    strokeGradient: LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                rangeTrackShape: const CustomRoundedRectRangeSliderTrackShape(
                    gradient: LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                trackHeight: 3.0,
                thumbColor: Colors.brown,
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                overlayColor: Colors.white,
              ),
              child: RangeSlider(
                values: rangeValues,
                onChanged: (value) {
                  setState(() {
                    rangeValues = value;
                  });
                },
                min: 0,
                max: 100,
              ),
            ),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  await custom_date_picker.showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2023));
                },
                child: const Text("Show Date Picker")),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CommunityPage()));
                },
                child: const Text("Community Page")),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CustomGridView()));
                },
                child: const Text("Custom Grid View")),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChartScreen()));
                },
                child: const Text("Flutter Chart")),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CubicBezierCurve()));
                },
                child: const Text("Bezier")),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AnimatedDots()));
                },
                child: const Text("Animated Circle Dots")),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Matrices()));
                },
                child: const Text("Matrices")),
            const HeightWidget(height: 10),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StoryScreen()));
                },
                child: const Text("Story")),
          ],
        ),
      ),
    );
  }
}

class HeightWidget extends SizedBox {
  const HeightWidget({super.key, final double? height}) : super(height: height);
}
