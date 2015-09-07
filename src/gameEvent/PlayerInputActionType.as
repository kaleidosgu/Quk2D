package gameEvent 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerInputActionType 
	{
		public static var Player_Move_None:uint = 0;
		public static var Player_Move_Right:uint = 1;
		public static var Player_Move_Left:uint = 2;
		public static var Player_Jump:uint = 3;
		public static var Player_Move_Stop:uint = 4;
		public static var Player_Direction:uint = 5;
		public static var Player_Shoot_On:uint = 6;
		public static var Player_Shoot_Off:uint = 7;
		public static var Player_ChangeWeapon:uint = 8;
		
		private var _changeWeaponTyp:uint = 0;
		public function PlayerInputActionType() 
		{
			
		}
		
		public function get changeWeaponTyp():uint 
		{
			return _changeWeaponTyp;
		}
		
		public function set changeWeaponTyp(value:uint):void 
		{
			_changeWeaponTyp = value;
		}
		
	}

}