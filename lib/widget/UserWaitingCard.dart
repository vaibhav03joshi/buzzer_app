import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({required this.userName, super.key});

  final String userName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 75.0,
      width: double.infinity,
      child: Card(
        color: const Color(0xffc6d3ef),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xff50586C),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xffDCE2F0),
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                color: Color(0xff50586C),
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
