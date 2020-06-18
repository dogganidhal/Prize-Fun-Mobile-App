using System;

namespace FlutterUnityPlugin
{
	public class FlutterUnityMessage
	{
		
	}

	public class SetTargetScoreMessage : FlutterUnityMessage
	{
		public string targetScore { get; set; }
	}
}