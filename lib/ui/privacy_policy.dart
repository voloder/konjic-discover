import 'dart:ui';

import 'package:flutter/material.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("Konjic Discover respects your privacy and is committed to protecting any information that you may provide while using our mobile application. This Privacy Policy outlines the types of personal information that is received and collected by Konjic Discover and how it is used.", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold),),
      Text("Information Collection and Use", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Konjic Discover does not collect any personal information or data from its users. We do not require you to provide any personal information to use our application.", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
      Text("Firebase Backend Usage", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Konjic Discover utilizes Firebase solely for the purpose of displaying information within the application. Firebase may collect certain non-personal information such as device information, usage statistics, and cookies to provide its services. However, Konjic Discover does not have access to or collect any of this information.", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
      Text("Third-party Links", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Konjic Discover may contain links to third-party websites or services that are not operated by us. Please note that we have no control over the content or practices of these websites and cannot be responsible for the protection and privacy of any information which you provide while visiting such sites.", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
      Text("Changes to This Privacy Policy", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("We reserve the right to update or change our Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy on this page.", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
      Text("Contact Us", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("If you have any questions or concerns about this Privacy Policy, please contact the developer at admirvoloder@gmail.com", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
      Text("\nBy using Konjic Discover, you signify your acceptance of this Privacy Policy. If you do not agree to this policy, please do not use our application.", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold))
    ],);
  }
}
