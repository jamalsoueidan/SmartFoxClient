package com.soueidan.smartfoxclient.callbacks
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.IRequest;
	
	public interface ICallback extends IRequest
	{
		function get action():String;	
		function handleServerResponse(event:SFSEvent):void;
	}
}