package com.soueidan.smartfoxserver.responseHandlers
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.soueidan.smartfoxserver.core.Connector;

	public class BaseClientResponseHandler
	{
		protected var _server:Connector = Connector.getInstance();
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