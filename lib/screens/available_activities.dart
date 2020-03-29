import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AvailableActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff101010),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  List<Widget> widgets;

  int currentFocus = 0;

  @override
  void initState() {
    super.initState();
    updateFocus(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Swiper(
            viewportFraction: 0.9,
            scrollDirection: Axis.vertical,
            itemCount: widgets.length,
            itemBuilder: (context, index) => widgets[index],
            onIndexChanged: (index) {
              updateFocus(index);
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    OMIcons.keyboardArrowLeft,
                    color: Color(0xff0c0c0c),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateFocus(int pos) {
    setState(() {
      currentFocus = pos;
      widgets = [
        _Widget(
            parent: this, pos: 0,
            title: 'Gardening Sessions',
            startText: 'What about some gardening? Learn skills, get fresh air and meet other students.',
            text: 'Come along to our weekly gardening sessions run in partnership with '
                'Bath Mind. You will be able to learn gardening skills in these hands-on '
                'sessions. Activities will vary depend on the season but you will be '
                'able to help plant and maintain a vegetable patch and learn about the '
                'different plants and how to care for them. There will also be the '
                'opportunity to meet new people and enjoy the fresh air. This activity '
                'will run throughout the year and in times of bad weather we will explore '
                'other areas of gardening such as indoor planting and sowing seeds. '
                'Everything takes place on campus.',
            image: 'assets/images/Gardening.jpg',
            isBookable: true,
            url: 'https://unihub.bath.ac.uk/s/myskills/events/search?query=gardening&EventType=23'
        ),
        _Widget(
          parent: this, pos: 1,
          title: 'Dog Walking',
          startText: 'Why not try a walk with dogs around campus? Get some fresh air,'
              ' exercise and a chance to spend some time with a PAT dog.',
          text: 'This year we\'re running weekly dog walks during term-time. Pets '
              'as Therapy (PAT) dogs will be joining us with their owners for a 45 '
              'minute stroll around campus. You will have the opportunity to meet '
              'some new people, get some fresh air and exercise and of course meet '
              'the PAT dogs.',
          image: 'assets/images/Dog_Walking.jpg',
          isBookable: true,
          url: 'https://unihub.bath.ac.uk/s/myskills/events/search?query=dog+walking&EventType=',
        ),
        _Widget(
          parent: this, pos: 2,
          title: 'Cooking Classes',
          startText: 'Improve your cookery skills with one of our classes. We offer'
              ' a range of different levels and skills.',
          text: 'Learn to cook some healthy and simple recipes from some of the '
              'University\'s qualified chefs. Classes may include watching a live '
              'demonstration or practicing some cooking skills. Classes will vary, '
              'some may consist of making a meal together (classes will cater for '
              'different skill levels) and eating it together! Others may show different '
              'types of skills such as bread making.',
          image: 'assets/images/Cooking_Classes.jpg',
          isBookable: true,
          url: 'https://unihub.bath.ac.uk/s/myskills/events/search?query=Baking+cookies++-+Make+time+for+treats&EventType=23',
        ),
        _Widget(
          parent: this, pos: 3,
          title: 'Talk Club – Running',
          startText: 'A male mental fitness club based around running.',
          text: 'Talk club is a talking and listening group for men to help build '
              'your mental fitness through running. It is important we all practice '
              'our mental fitness regularly and talk club allows you to do this in '
              'a social, relaxed and confidential setting. Over four weeks you will'
              ' have the opportunity to meet up with others for a social run followed'
              ' by some time to talk and more importantly listen to each other.',
          image: 'assets/images/Running.jpg',
          isBookable: true,
          url: 'https://unihub.bath.ac.uk/students/events/Detail/767601',
        ),
        _Widget(
          parent: this, pos: 4,
          title: 'Counselling Workshops and Courses',
          startText: 'We offer a range of free course and workshops to help you overcome'
              ' anxiety, depression and other common mental health problems.',
          text: 'These include in-depth courses which last for a number of weeks such'
              ' as those teaching mindfulness or managing anxiety and also short '
              'one-off workshops on topics such as sleep problems or stress.',
          image: 'assets/images/Counselling.jpg',
          isBookable: false,
          url: 'https://www.bath.ac.uk/campaigns/counselling-workshops-and-courses/',
        ),
        _Widget(
          parent: this, pos: 5,
          title: 'Autism Social Group',
          startText: 'A social group on campus for students who identify as being '
              'on the autism spectrum.',
          text: 'This is a group run by the Disability Service for students who identify'
              ' as being on the Autism Spectrum/have Aspergers, whether there is a '
              'formal diagnosis or not. It runs every two weeks on a Tuesday evening'
              ' and includes activities like film nights, quizzes, table tennis, board'
              ' games, pizza nights and themed activities.',
          image: 'assets/images/Autism_Social.jpg',
          isBookable: false,
          url: 'https://www.bath.ac.uk/campaigns/autism-social-group/',
        ),
      ];
    });
  }
}

class _Widget extends StatefulWidget {
  final parent;
  final pos;
  final title;
  final startText;
  final text;
  final image;
  final isBookable;
  final url;

  _Widget({@required this.parent, @required this.pos, @required this.title,
    @required this.startText, @required this.text, @required this.image, @required this.isBookable,
    @required this.url});

  @override
  _WidgetState createState() => _WidgetState(parent: parent, pos: pos, title: title,
      startText: startText, text: text, image: image, isBookable: isBookable, url: url);
}

class _WidgetState extends State<_Widget> {
  final _BodyLayoutState parent;
  final pos;
  final title;
  final startText;
  final text;
  final image;
  final isBookable;
  final url;
  bool isFocused;

  _WidgetState({@required this.parent, @required this.pos, @required this.title,
    @required this.startText, @required this.text, @required this.image, @required this.isBookable,
    @required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFocused = this.parent.currentFocus == pos;
    return isFocused ? main(context)
        : Transform.scale(
            scale: 0.95,
            child: main(context),
    );
  }

  Widget main(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff424242),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  startText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(image),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        child: Text(
                          isBookable ? 'BOOK ON MYSKILLS' : 'MORE INFORMATION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff0c0c0c),
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => _launchURL(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}