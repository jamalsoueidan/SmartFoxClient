package com.soueidan.smartfoxclient.core
{
	import com.smartfoxserver.v2.*;
	import com.smartfoxserver.v2.core.*;
	import com.smartfoxserver.v2.entities.*;
	import com.smartfoxserver.v2.entities.data.*;
	import com.smartfoxserver.v2.requests.*;
	import com.soueidan.smartfoxclient.callbacks.ICallback;
	import com.soueidan.smartfoxclient.responses.ServerResponseHandler;
	
	import mx.collections.ArrayCollection;
	
	public class SmartFoxClient extends SmartFox
	{
		static private var _instance:SmartFoxClient;
		static private var _currentRoom:String;
		
		private var _responseHandlers:Object = {};
		
		public function SmartFoxClient(debug:Boolean=false)
		{
			super(debug);
			
			addEventListener(SFSEvent.CONNECTION, connection);
			addEventListener(SFSEvent.EXTENSION_RESPONSE, responseHandler);
			
			loadConfig("config.xml");
		}
		
		static public function getInstance():SmartFoxClient {
			if ( !_instance ) {
				_instance = new SmartFoxClient();
			}
			
			return _instance;
		}
		
		public function get currentRoom():Room {
			return getRoomByName(_currentRoom);
		}
		
		private function connection(evt:SFSEvent):void
		{	
			trace("connectionMade");
			var params:ISFSObject = new SFSObject();
			/*params.putUtfString("session", ExternalInterface.call("getParams", "sid"));//CookieManager.getSession());
			
			_currentRoom  = ExternalInterface.call("getParams", "rid")
			params.putUtfString("room", _currentRoom);*/
			
			_currentRoom = "testerne";
			
			trace("sendRequest");
			var login:LoginRequest = new LoginRequest("default", null, null, params);	
			send(login);
		}
		
		public function addResponseHandler(requestId:String, theClass:*):void {
			var handlers:Array = _responseHandlers[requestId];
			if ( !handlers) {
				handlers = new Array();
			}
			
			handlers.push(theClass);
			_responseHandlers[requestId] = handlers;
		}
		
		public function addCallBack(request:ICallback, theClass:*):void {
			addResponseHandler(request.action, theClass);
			send(request);
		}
		
		private function responseHandler(event:SFSEvent):void {
			var action:String = event.params.cmd;
			
			var handlers:Array = _responseHandlers[action];
			if ( !handlers ) {
				trace("No responseHandlers for", action);
				return;
			}
			
			trace("Executing", action);
			
			var handler:ServerResponseHandler;
			for each(var theClass:* in handlers) {
				handler = new theClass();
				handler.action = action;
				handler.handleServerResponse(event)
			}
		}
	}
}