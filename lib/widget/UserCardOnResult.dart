import 'package:flutter/material.dart';

class UserCardOnResult extends StatelessWidget {
  const UserCardOnResult(
      {required this.userName, required this.datetime, super.key});

  final String userName;
  final Duration datetime;
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
        child: Stack(
          children: [
            Row(
              children: [
                Center(
                  child: Container(
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
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(
                  right: 15.0,
                ),
                child: Text(
                  "${datetime.inSeconds}:${datetime.inMilliseconds % 1000}",
                  style: const TextStyle(
                    color: Color(0xff50586C),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
