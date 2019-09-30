import 'dart:async';

const int kDefaultThrottleSeconds = 3;

Future<T> delayed<T>(FutureOr<T> microtask, {int seconds = kDefaultThrottleSeconds}) async {
  T result;
  await Future.wait<Null>([
    Future.microtask(() async {
      result = await microtask;
    }),
    Future.delayed(Duration(seconds: 3))
  ]);
  return result;
}