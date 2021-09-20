class FlashException {
  final String message;
  const FlashException(this.message);

  @override
  String toString() {
    return "error message is $message";
  }
}
