package com.soueidan.smartfoxclient.managers
{
	import com.smartfoxserver.v2.entities.SFSUser;
	import com.smartfoxserver.v2.entities.UserPrivileges;

	public class UserManager
	{
		static public function privilege(user:SFSUser):String {
			if ( user.privilegeId == UserPrivileges.ADMINISTRATOR ) {
				return "admin";
			} else if( user.privilegeId == UserPrivileges.MODERATOR ) {
				return "moderator";
			} else if ( user.privilegeId == UserPrivileges.STANDARD ) {
				return "standard";
			} else {
				return "guest";
			}
		}
	}
}