package io.github.dogganidhal.fun_prize;

import androidx.annotation.UiThread;

final public class UnityGameScoreStaticNotifier {

  private static Listener mListener;

  static void setListener(Listener listener) {
    mListener = listener;
  }

  @SuppressWarnings("unused")
  public static void postScore(String score) {
    if (mListener != null) {
      mListener.onPostScore(Integer.parseInt(score));
    }
  }

  @FunctionalInterface
  public interface Listener {
    @UiThread
    void onPostScore(int score);
  }

}
