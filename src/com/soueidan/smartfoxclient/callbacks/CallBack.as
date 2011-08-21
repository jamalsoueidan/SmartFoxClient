package com.soueidan.smartfoxclient.callbacks
{
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	
	public class CallBack extends ExtensionRequest
	{
		public function CallBack(extCmd:String, params:ISFSObject=null, room:Room=null, useUDP:Boolean=false)
		{
			super(extCmd, params, room, useUDP);
		}
	}
}