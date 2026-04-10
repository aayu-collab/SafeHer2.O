        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton: GestureDetector(
  onTap: () async {
    if (!isListening) {
      bool available = await _speech.initialize();

      if (available) {
        setState(() {
          isListening = true;
          voiceEnabled = true;
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              spokenText = result.recognizedWords;
            });

            /// 🔥 SECRET WORD
            if (spokenText.toLowerCase().contains("help")) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("SOS Triggered 🚨")),
              );

              print("🚨 SOS TRIGGERED");
            }
          },
        );
      }
    } else {
      setState(() {
        isListening = false;
        voiceEnabled = false;
      });

      _speech.stop();
    }
  },

  child: CircleAvatar(
    radius: 30,
    backgroundColor: voiceEnabled ? Colors.red : Colors.grey,
    child: Icon(Icons.mic, color: Colors.white),
  ),
),