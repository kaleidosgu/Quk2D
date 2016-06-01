package gameplay.soundsys 
{
	import gameEvent.sound.PlaySoundEvent;
	import util.EventDispatch.GameDispatchSystem;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class QukSoundSystem 
	{
		[Embed(source = "../../../res/sfx/machinegun.mp3")] private var sfxMg:Class;
		[Embed(source = "../../../res/sfx/shotgun.mp3")] private var sfxSg:Class;
		
		[Embed(source = "../../../res/sfx/changeweapon.mp3")] private var sfxChange:Class;
		[Embed(source = "../../../res/sfx/noEnoughAmmo.mp3")] private var sfxNotEnoughAmmo:Class;
		
		private var _objectSound:Object = new Object();
		private var _dspSystem:GameDispatchSystem =  null;
		public function QukSoundSystem( _inDspSystem:GameDispatchSystem ) 
		{
			_dspSystem 	= _inDspSystem;
			registerEvent();
			
			_objectSound["machinegun"] = sfxMg;
			_objectSound["shotgun"] = sfxSg;
			_objectSound["change"] = sfxChange;
			_objectSound["noammo"] = sfxNotEnoughAmmo;
		}
		private function registerEvent():void
		{
			_dspSystem.RegisterEvent( PlaySoundEvent.PLAY_SOUND_EVENT, onSoundPlayEvent );
		}
		private function onSoundPlayEvent( evt:PlaySoundEvent ):void
		{
			var obj:Class = _objectSound[evt.strSound];
			if ( obj != null )
			{
				FlxG.play(obj);	
			}
		}
	}

}