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
		private var _parameters:Object;
		private var _responseHandlers:Object = {};
		private var _xml:XML;
		
		public function set parameters(value:Object):void {
			_parameters = value;
		}
		
		public function get gameId():int {
			return _xml.id;
		}
		
		public function get currentRoom():Room {
			return getRoomByName(_parameters.room);
		}
		
		public function start(xmlData:String):void {
			if ( !_parameters ) {
				throw new Error("You need to assign parameters instance first");
			}
			
			addEventListener(SFSEvent.CONNECTION, connection);
			addEventListener(SFSEvent.EXTENSION_RESPONSE, responseHandler);
			
			_xml = new XML(xmlData);
			
			connect(_xml.host, _xml.port);
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
		
		public function addResponseHandler(requestId:String, theClass:*):void {
			var handlers:Array = _responseHandlers[requestId];
			if ( !handlers) {
				handlers = new Array();
			}
			
			handlers.push(theClass);
			_responseHandlers[requestId] = handlers;
		}
		
		
		private function connection(event:SFSEvent):void
		{
			trace("connection made");
			
			var params:ISFSObject = new SFSObject();
			params.putUtfString("session", _parameters.session);
			params.putUtfString("room", _parameters.room);
			params.putInt("game_id", _xml.id);
			
			var request:IRequest = new LoginRequest("","",_xml.zone, params);
			send(request);
		}	
	}
}