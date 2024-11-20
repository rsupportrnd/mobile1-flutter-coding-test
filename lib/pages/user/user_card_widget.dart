// import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/constants/enums.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildPhoto(
              'https://i.namu.wiki/i/J1f1LJ21yWHGgARNPjNlOe6fXqQcyJbuge7HedriooZ3sTSw0VMnw-9gfp67uu5gcDXkcvMGPyim5jQDPb7jlrcY_2HlCyQULABkgHLKeQsGUey-uvwtbN6fquEGToyQzp1FpIPK3VyR4GXTFJAg2w.webp'),
          buildInfo(context,
              name: 'Dana Choi', email: 'aaa@aaa.com', role: 'MANAGER'),
        ],
      ),
    );
  }

  Expanded buildInfo(BuildContext context,
      {required String name, required String email, required String role}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Dana Choi',
                  style: Theme.of(context).textTheme.headlineSmall),
              buildRoleTag('MANAGER'),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.email_outlined),
              const SizedBox(
                width: 10,
              ),
              Text('sdkfjdkfj@dkfjdkfj.com')
            ],
          ),
        ],
      ),
    );
  }

  Container buildPhoto(String url) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
      child: buildStatus(UserStatus.away),
    );
  }

  Center buildStatus(UserStatus userStatus) {
    return Center(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Transform.translate(
          offset: const Offset(5, 5),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: userStatus.backColor),
          ),
        ),
      ),
    );
  }

  Container buildRoleTag(String roleName) {
    return Container(
      width: 100,
      height: 30,
      margin: const EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Text(roleName),
    );
  }
}
