package io.github.dogganidhal.fun_prize;

import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "io.github.dogganidhal.fun_prize/channel";
  private static final String START_GAME_METHOD = "io.github.dogganidhal.fun_prize/channel.start_game";
  private static final String POST_SCORE_METHOD = "io.github.dogganidhal.fun_prize/channel.post_score";

  private MethodChannel mMethodChannel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    mMethodChannel = new MethodChannel(getFlutterView(), CHANNEL);

    mMethodChannel.setMethodCallHandler(
      (call, result) -> {
        if (START_GAME_METHOD.equals(call.method)) {
          Intent intent = new Intent(MainActivity.this, UnityGameActivity.class);
          startActivity(intent);
          result.success(null);
        }
      });

    GameScoreReceiver mScoreReceiver = new GameScoreReceiver(score -> runOnUiThread(() -> {
      mMethodChannel.invokeMethod(POST_SCORE_METHOD, score);
    }));
    IntentFilter intentFilter = new IntentFilter();
    intentFilter.addAction(GameScoreReceiver.POST_GAME_SCORE_ACTION);

    registerReceiver(mScoreReceiver, intentFilter);

  }

}
