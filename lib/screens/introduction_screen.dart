import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_vision/screens/home_page.dart';
import 'package:video_player/video_player.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPageIndex = 0;
  VideoPlayerController _controller = VideoPlayerController.asset('');

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('Images/obamaDeepfake.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true); // To loop the video playback
        });
      });
  }

  List<PageViewModel> getPages() {
    return [
      /*  **********First page********** */
      PageViewModel(
          titleWidget: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                    child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.yellow,
                  size: 27,
                )),
                TextSpan(
                    text: 'DANGERS OF \nDEEPFAKE VIDEOS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red)),
                WidgetSpan(
                    child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.yellow,
                  size: 27,
                )),
              ],
            ),
          ),
          body:
              'Deepfakes, the most powerful cyber weapon is just around the corner',
          image: SizedBox(
            height: 750,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          decoration: PageDecoration(
            titlePadding: EdgeInsets.only(top: 150, bottom: 20, left: 4),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.red,
            ),
            bodyTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            fullScreen: true,
          )),

      /*  **********Second page********** */
      PageViewModel(
        title: 'Seeing is not believing',
        body: 'Do you have your Anti-Deefake protocol ready?',
        image: Container(
          margin: EdgeInsets.only(top:60),
            height: 500,
            width: 400,
            child: Image.asset(
              'Images/image3.png',
              fit: BoxFit.cover,
            ),
          ),
        decoration: PageDecoration(
          
          bodyTextStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 22),
          bodyAlignment: Alignment.bottomCenter,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 29,
            color: Color.fromARGB(255, 206, 0, 0),
          ),
          // to make background color transparent
         
        ),
      ),

      /*  **********Third page********** */
      PageViewModel(
        
          title: 'FakeVision',
          body: 'Let\'s detect and prevent the spread of Deepfakes',
          footer: ElevatedButton(
            onPressed: () {},
            child: Text('Get Started'),
          ),
          image: Container(
            height: 500,
            width: 400,
            child: Image.asset(
              'Images/fourth.gif',
              fit: BoxFit.cover,
            ),
          ),
          decoration: const PageDecoration(
            pageColor: Color.fromARGB(255, 182, 220, 230),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          )),
    ];
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: IntroductionScreen(
            pages: getPages(),
            onChange: (index) {
              setState(() {
                _currentPageIndex = index;
              });

              if (_currentPageIndex == 0) {
                _controller.play();
              } else {
                _controller.pause();
              }
            },
            dotsDecorator: const DotsDecorator(
                size: Size(15, 15),
                color: Color.fromARGB(255, 17, 85, 141),
                activeSize: Size.square(15),
                activeColor: Color.fromARGB(255, 170, 45, 36)),
            showDoneButton: true,
            done: const Text(
              'Done',
              style: TextStyle(fontSize: 15),
            ),
            showSkipButton: true,
            skip: const Text(
              'Skip',
              style: TextStyle(fontSize: 15),
            ),
            showNextButton: true,
            next: const Icon(Icons.arrow_forward, size: 25),
            onDone: () => onDone(context),
          ),
        )));
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
