import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectn/colors.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});
  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  String text = "hold the button and ";
  bool lisn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: lisn,
        duration: Duration(microseconds: 2000),
        startDelay: Duration(microseconds: 100),
        glowColor: bgcolor,
        repeat: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!lisn) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  lisn = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              lisn = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: bgcolor,
            radius: 35,
            child: Icon(
              lisn ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.sort_rounded, color: Colors.white),
        backgroundColor: bgcolor,
        elevation: 0.0,
        title: const Text(
          "speech to text",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: tectcolor,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: const EdgeInsets.only(bottom: 150),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
