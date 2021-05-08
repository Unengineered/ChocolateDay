import 'package:chocolate_day/components/aasra/text_image.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/material.dart';

class FoundationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text("Our\nFoundations",
                    style: kLargeTitleStyle.copyWith(fontSize: 35)),
              ),
            ],
          ),
          SizedBox(height: 30),
          TextImage(
            path: "asset/illustrations/khushi_f.png",
            text: "Khushiyaan\nFoundation",
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
                """Khushiyaan, as the name suggests 'Happiness'' is committed to delivering Happiness to underprivileged humans of the society & environment. Amid the second wave of the pandemic, the Khushiyaan Foundation has been providing free Oxygen cylinders to people and hospitals through their ‘Oxygen Seva’ initiative, reaching out to more than 5 cities across India.""",
                style: kParaStyle),
          ),
          SizedBox(height: 30),
          TextImage(
            path: "asset/illustrations/smit.png",
            text: "Smit old age\nhome",
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
                """About 70% of India’s population above 60 lives in poverty and the second wave of the pandemic has only worsened the situation for them. To create a better world for the underprivileged old aged people, SMIT Old Age home aims to ensure the safety and welfare of old aged people. The organization attends to destitute senior citizens, provides a sense of belonging and empowers their members to become self reliable, giving them security and comfort.""",
                style: kParaStyle),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
