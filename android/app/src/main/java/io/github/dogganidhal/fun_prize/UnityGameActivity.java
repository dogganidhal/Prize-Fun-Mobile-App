package io.github.dogganidhal.fun_prize;

import android.content.Intent;
import android.os.Bundle;
import com.unity3d.player.UnityPlayerActivity;

public class UnityGameActivity extends UnityPlayerActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    UnityGameScoreStaticNotifier.setListener((score) -> {
      Intent broadcastIntent = new Intent();
      broadcastIntent.setAction(GameScoreReceiver.POST_GAME_SCORE_ACTION);
      broadcastIntent.putExtra(GameScoreReceiver.GAME_SCORE_EXTRA_KEY, score);
      sendBroadcast(broadcastIntent);
      finish();
    });
  }

}
