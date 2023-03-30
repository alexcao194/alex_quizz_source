class QuizResult {
  const QuizResult({required this.total, required this.done, required this.hit});
  final int total;
  final int done;
  final List<int> hit;
}