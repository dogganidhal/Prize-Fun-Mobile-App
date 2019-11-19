package io.github.dogganidhal.fun_prize;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class GameScoreReceiver extends BroadcastReceiver {

  public static final String GAME_SCORE_EXTRA_KEY = "io.github.dogganidhal.fun_prize.GameScoreReceiver.score";
  public static final String POST_GAME_SCORE_ACTION = "io.github.dogganidhal.fun_prize.GameScoreReceiver.postScoreAction";

  private final ScoreReceiver mScoreReceiver;

  public GameScoreReceiver() {
    this(null);
  }

  public GameScoreReceiver(ScoreReceiver mScoreReceiver) {
    this.mScoreReceiver = mScoreReceiver;
  }

  @Override
  public void onReceive(Context context, Intent intent) {
    if (mScoreReceiver != null) {
      Integer score = intent.getIntExtra(GAME_SCORE_EXTRA_KEY, 0);
      mScoreReceiver.onReceiveScore(score);
    }
  }

  @FunctionalInterface
  public interface ScoreReceiver {
    void onReceiveScore(Integer score);
  }

}
