import 'dart:ui';

import 'package:flutter/material.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Last updated: 22. May 2024.", style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontStyle: FontStyle.italic)),
        Text('Privacy Policy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text('Konjic Discover ("we," "our," or "us") respects your privacy and is committed to protecting any information that you may provide while using our mobile application. This Privacy Policy outlines the types of personal information that is received and collected by Konjic Discover and how it is used. This policy is available on our app’s store listing page in the Play Console and within the app itself.', style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
        Text('Information Collection and Use', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Konjic Discover does not collect any personal information or data from its users. We do not require you to provide any personal information to use our application.', style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
        Text('Firebase Backend Usage', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Konjic Discover utilizes Firebase solely for the purpose of displaying information within the application. Firebase may collect certain non-personal information such as device information, usage statistics, and cookies to provide its services. However, Konjic Discover does not have access to or collect any of this information. For more details, please review Firebase\'s Privacy Policy.', style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
        Text('Third-party Links', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Konjic Discover may contain links to third-party websites or services that are not operated by us. Please note that we have no control over the content or practices of these websites and cannot be responsible for the protection and privacy of any information which you provide while visiting such sites. We encourage you to review the privacy policies of any third-party sites you visit.', style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
        Text('Children\'s Privacy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. If we discover that a child under 13 has provided us with personal information, we will delete such information immediately. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we can take necessary actions.', style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
        Text('Changes to This Privacy Policy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('We reserve the right to update or change our Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy on this page. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes.', style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
        Text('Contact Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('If you have any questions or concerns about this Privacy Policy, please contact us at:\n\nDeveloper:\nAdmir Voloder\nEmail: admirvoloder@gmail.com', style: TextStyle(fontSize: 12, fontFamily: "Montserrat-Light", fontWeight: FontWeight.bold)),
        Text('\nBy using Konjic Discover, you signify your acceptance of this Privacy Policy. If you do not agree to this policy, please do not use our application.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],);
  }
}
