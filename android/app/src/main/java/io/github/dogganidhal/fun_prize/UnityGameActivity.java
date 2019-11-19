package io.github.dogganidhal.fun_prize;

import android.os.Bundle;

import com.unity3d.player.UnityPlayerActivity;

public class UnityGameActivity extends UnityPlayerActivity {

  private static final String POST_SCORE_METHOD = "io.github.dogganidhal.fun_prize/channel.post_score";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    UnityGameScoreStaticNotifier.setListener((score) -> runOnUiThread(() -> {
      MainActivity.methodChannel.invokeMethod(POST_SCORE_METHOD, score);
      finish();
    }));
  }

}
