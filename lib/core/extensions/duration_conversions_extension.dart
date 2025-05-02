extension DurationConversionsExtension on Duration {
  String display() {
    int hours = this.inHours;
    int minutes = this.inMinutes % 60;
    int seconds = this.inSeconds % 60;

    // Return formatted string: HH:MM:SS
    return '${_padZero(hours)}:${_padZero(minutes)}:${_padZero(seconds)}';
  }

  String displayHHMM() {
    return '${inHours}h ${_padZero(inMinutes % 60)}m';
  }
}

String _padZero(int value) {
  return value.toString().padLeft(2, '0');
}
