import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GymCard extends StatefulWidget {
  final String imagen;
  final double size;
  final String url;
  const GymCard({super.key, required this.imagen, required this.size, required this.url});

  @override
  State<GymCard> createState() => _GymCardState();
}

class _GymCardState extends State<GymCard> {
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        _launchUrl(widget.url);
      },
      child: Container(
        width: widget.size,
        decoration: const BoxDecoration(
          borderRadius:  BorderRadius.all(Radius.circular(20.0)),
          
          
        ),
        child: Image.asset(widget.imagen),
      ),
    );
  }
}