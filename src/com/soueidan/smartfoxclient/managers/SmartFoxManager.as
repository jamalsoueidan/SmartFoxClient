package com.soueidan.smartfoxclient.managers
{
	import com.soueidan.smartfoxclient.core.SmartFoxClient;

	public class SmartFoxManager
	{
		static private var _server:SmartFoxClient;
		
		static public function getInstance():SmartFoxClient {
			if ( !_server ) {
				_server = new SmartFoxClient();
			}
			
			return _server;
		}
	}
}