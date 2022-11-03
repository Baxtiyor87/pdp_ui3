import 'package:flutter/material.dart';
import 'package:pdp_ui3/pages/home_page.dart';
import 'package:pdp_ui3/utils/Strings.dart';
class IntroPage extends StatefulWidget {
  static String id = 'intro_page';
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  late PageController _pageController;
  int currentIndex = 0;
  int skipIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
   _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page){
              setState(() {
                currentIndex = page;
                skipIndex = page;
              });
            },
            controller: _pageController,
            children:  [
              makePage(
                  image: 'assets/images/image_1.png',
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent
              ),
              makePage(
                  reverse: true,
                  image: 'assets/images/image_2.png',
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent
              ),
              makePage(
                  image: 'assets/images/image_3.png',
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent
              ),
            ],
          ),
         

              Container(
                width: 80,
                height: 30,
                margin: const EdgeInsets.only(bottom: 30),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildIndicator(),
                      ),
              ),
          Row(
             mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _buildSkip(),
          )
        ],
      ),
    );
  }

  Widget makePage({ title, content,image, reverse = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: const TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),),
          const SizedBox(height: 30,),
          Text(content, textAlign: TextAlign.center, style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w400
          ),
          ),

          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              const SizedBox(height: 10,),
            ],
          ),

        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
      ),

    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      }

      else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }

  Widget _skip(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: isActive? GestureDetector(
       onTap: (){
        Navigator.pushReplacementNamed(context, HomePage.id);
      },
      child: const Padding(padding: EdgeInsets.only(bottom: 40, right: 20, left: 20),
        child: Text('Skip', style: TextStyle(color: Colors.red, fontSize: 18),),
      ),
    ): null,
    );
  }

  List<Widget> _buildSkip() {
    List<Widget> skip = [];
    if (skipIndex > 1) {
        skip.add(_skip(true));
      } else {
        skip.add(_skip(false));
      }

    return skip;
  }

}