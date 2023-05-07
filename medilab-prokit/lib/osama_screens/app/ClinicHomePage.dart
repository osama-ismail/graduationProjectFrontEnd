import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

import '../leftMenu.dart';



class ClinicHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Carousel Slider',

      home: MyHomePage(title: 'Flutter Carousel Slider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;

  MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> colors = [
    Colors.blue,
    Colors.blue,



  ];
  final List<String> letters = [
    "images/m1.png",
    "images/m5.png",



  ];

  Transforms _transform = Transforms.StackTransform;
  SlideTransform _slideTransform = StackTransform();
  Indicators _indicator = Indicators.SequentialFillIndicator;
  SlideIndicator _slideIndicator = SequentialFillIndicator(
    padding: EdgeInsets.only(bottom: 32),
  );
  bool _isPlaying = true;
  CarouselSliderController? _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: About',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Color.fromARGB(255, 80, 63, 129)),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business,color: Color.fromARGB(255, 80, 63, 129)),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school,color: Color.fromARGB(255, 80, 63, 129)),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 80, 63, 129),
          onTap: _onItemTapped,
        ),
        drawer: NavBar(),
      appBar: AppBar(

        backgroundColor: Colors.blue,
        title: Text(
          widget.title!,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.transform),
            onPressed: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Transforms"),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _getTransformRadio(Transforms.CubeTransform, _transform, setState),
                            _getTransformRadio(Transforms.ZoomOutSlideTransform, _transform, setState),
                            _getTransformRadio(Transforms.RotateUpTransform, _transform, setState),
                            _getTransformRadio(Transforms.RotateDownTransform, _transform, setState),
                            _getTransformRadio(Transforms.TabletTransform, _transform, setState),
                            _getTransformRadio(Transforms.StackTransform, _transform, setState),
                            _getTransformRadio(Transforms.ParallaxTransform, _transform, setState),
                            _getTransformRadio(Transforms.ForegroundToBackgroundTransform, _transform, setState),
                            _getTransformRadio(Transforms.FlipVerticalTransform, _transform, setState),
                            _getTransformRadio(Transforms.DepthTransform, _transform, setState),
                            _getTransformRadio(Transforms.BackgroundToForegroundTransform, _transform, setState),
                            _getTransformRadio(Transforms.AccordionTransform, _transform, setState),
                            _getTransformRadio(Transforms.DefaultTransform, _transform, setState),
                            _getTransformRadio(Transforms.FlipHorizontalTransform, _transform, setState),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.transit_enterexit),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Indicators"),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: <Widget>[
                            _getIndicatorRadio(Indicators.CircularSlideIndicator, _indicator, setState),
                            _getIndicatorRadio(Indicators.CircularWaveSlideIndicator, _indicator, setState),
                            _getIndicatorRadio(Indicators.CircularStaticIndicator, _indicator, setState),
                            _getIndicatorRadio(Indicators.SequentialFillIndicator, _indicator, setState),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: Column(

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: 600,
            child: CarouselSlider.builder(

              initialPage: 0,
              enableAutoSlider: true,
              unlimitedMode: true,
              controller: _sliderController,
              autoSliderTransitionTime: Duration(seconds: 1),
              itemCount: letters.length,

              slideBuilder: (index) {

                return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // color: colors[index],
                  // child: Center(
                  children: <Widget>[

                    Image.asset(
                      letters[index],
                      width: 380,
                      height:280,
                    ),]

                  // ),
                );
              },



            ),
          ),


          // SizedBox(height: 32),
        ],
      ),
    ) ));
  }

  Widget _getRadio(value, groupValue, onChange) {
    return Row(

      children: <Widget>[

        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChange,
        ),
        Expanded(
          child: Text(
            value.toString().split('.').last,
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _getTransformRadio(value, groupValue, state) {
    return _getRadio(value, groupValue, (value) {
      setState(() {
        _transform = value;
        _slideTransform = _getTransform(value);
        state(() {});
        Navigator.of(context).pop();
      });
    });
  }

  Widget _getIndicatorRadio(value, groupValue, state) {
    return _getRadio(value, groupValue, (value) {
      setState(() {
        _indicator = value;
        _slideIndicator = _getIndicator(value);
        state(() {});
        Navigator.of(context).pop();
      });
    });
  }

  SlideTransform _getTransform(Transforms transform) {
    switch (transform) {
      case Transforms.CubeTransform:
        return CubeTransform();
      case Transforms.AccordionTransform:
        return AccordionTransform();
      case Transforms.BackgroundToForegroundTransform:
        return BackgroundToForegroundTransform();
      case Transforms.ForegroundToBackgroundTransform:
        return ForegroundToBackgroundTransform();
      case Transforms.DefaultTransform:
        return DefaultTransform();
      case Transforms.DepthTransform:
        return DepthTransform();
      case Transforms.FlipHorizontalTransform:
        return FlipHorizontalTransform();
      case Transforms.FlipVerticalTransform:
        return FlipVerticalTransform();
      case Transforms.ParallaxTransform:
        return ParallaxTransform();
      case Transforms.StackTransform:
        return StackTransform();
      case Transforms.TabletTransform:
        return TabletTransform();
      case Transforms.RotateDownTransform:
        return RotateDownTransform();
      case Transforms.RotateUpTransform:
        return RotateUpTransform();
      case Transforms.ZoomOutSlideTransform:
        return ZoomOutSlideTransform();
    }
    return CubeTransform();
  }

  SlideIndicator _getIndicator(Indicators indicator) {
    switch (indicator) {
      case Indicators.CircularSlideIndicator:
        return CircularSlideIndicator(
          padding: EdgeInsets.only(bottom: 32),
        );
      case Indicators.CircularWaveSlideIndicator:
        return CircularWaveSlideIndicator(
          padding: EdgeInsets.only(bottom: 32),
        );
      case Indicators.CircularStaticIndicator:
        return CircularStaticIndicator(
          padding: EdgeInsets.only(bottom: 32),
          enableAnimation: true,
        );
      case Indicators.SequentialFillIndicator:
        return SequentialFillIndicator(
          padding: EdgeInsets.only(bottom: 32),
          enableAnimation: true,
        );
    }
    return CircularSlideIndicator(
      padding: EdgeInsets.only(bottom: 32),
    );
  }
}

enum Transforms {
  CubeTransform,
  AccordionTransform,
  BackgroundToForegroundTransform,
  ForegroundToBackgroundTransform,
  DefaultTransform,
  DepthTransform,
  FlipHorizontalTransform,
  FlipVerticalTransform,
  ParallaxTransform,
  StackTransform,
  TabletTransform,
  RotateDownTransform,
  RotateUpTransform,
  ZoomOutSlideTransform,
}

enum Indicators {
  CircularSlideIndicator,
  CircularWaveSlideIndicator,
  CircularStaticIndicator,
  SequentialFillIndicator,
}