package com.soueidan.smartfoxclient.responses
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.soueidan.smartfoxclient.callbacks.ICallback;
	import com.soueidan.smartfoxclient.core.SmartFoxClient;

	public class ServerResponseHandler
	{
		protected var _server:SmartFoxClient = SmartFoxClient.getInstance();
		private var _action:String;
		
		public function get action():String
		{
			return _action;
		}

		public function set action(value:String):void
		{
			_action = value;
		}

		public function handleServerResponse(event:SFSEvent):void {
			
		}
	}
}