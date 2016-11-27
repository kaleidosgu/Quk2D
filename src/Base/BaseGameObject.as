package Base 
{
	import UI.Data.EditorPadData;
	import flash.events.Event;
	import gameEvent.BattleEvent.BattleGroundMapLayerChangedEvent;
	import gameEvent.sound.PlaySoundEvent;
	import gamemap.GameMapBuildingXmlTag;
	import gamemap.GameMapElementInfo;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import util.EventDispatch.GameDispatchSystem;
	import util.UtilXmlConvertVariables;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseGameObject extends FlxSprite 
	{
		protected var _gameObjData:GameBaseDataObject = null;
		private var _selfGroup:FlxGroup	= null;
		
		private var _tickConstCount:Number = 0;
		private var _tickCount:Number = _tickConstCount;
		protected var _enableUpdateTick:Boolean = false;
		public var prePos:FlxPoint = null;
		private var _dsp:GameDispatchSystem = null;
		protected var _updatePrePoint:Boolean = false;
		public function BaseGameObject( ) 
		{
			super();
			//_gameObjData = new GameBaseDataObject();
			prePos = new FlxPoint();
			//this.active = false;
			//this.visible = false;
		}	
		private function setWorldData():void
		{
			this.x = (_gameObjData.mapCol * _gameObjData.spriteWidth * this.scale.x);
			this.y = (_gameObjData.mapRow * _gameObjData.spriteHeight * this.scale.y);
		}   
		
		public function createObjectByBaseData( baseData:GameBaseDataObject ):void
		{
			_gameObjData = baseData;
			createObjectByParam();
			setWorldData();
		}
		private function createObjectByParam():void
		{
			this.scale.x = _gameObjData.scaleX;
			this.scale.y = _gameObjData.scaleY;
			loadGraphic( resClass(), true, true, _gameObjData.spriteWidth, _gameObjData.spriteHeight );
			_scaleTile( this.scale );
			frame = _gameObjData.spriteRows * _gameObjData.spriteCnts + _gameObjData.spriteCol ;
		}
		protected function _scaleTile( _scaleFact:FlxPoint ):void
		{
			width = _gameObjData.spriteWidth * _scaleFact.x;
			height = _gameObjData.spriteHeight * _scaleFact.y;
			offset.x -= _gameObjData.spriteWidth * ( _scaleFact.x - 1 ) / 2; 
			offset.y -= _gameObjData.spriteHeight * ( _scaleFact.y - 1 ) / 2;
		}	
		public function resClass():Class
		{
			return null;
		}
		
		public function getMainTyp():uint
		{
			return _gameObjData.elementMainType;
		}
		public function getSubTyp():uint
		{
			return _gameObjData.elementSubType;
		}
		
		public function get gameObjData():GameBaseDataObject 
		{
			return _gameObjData;
		}
		
		public function set gameObjData(value:GameBaseDataObject):void 
		{
			_gameObjData = value;
		}
		
		public function get tickConstCount():Number 
		{
			return _tickConstCount;
		}
		
		public function set tickConstCount(value:Number):void 
		{
			_tickConstCount = value;
			_tickCount 		= value;
		}
		
		public function get dsp():GameDispatchSystem 
		{
			return _dsp;
		}
		
		public function set dsp(value:GameDispatchSystem):void 
		{
			_dsp = value;
			_dsp.RegisterEvent(BattleGroundMapLayerChangedEvent.BattleGroundMapLayerChanged, _OnBattleGroundMapLayerChanged);
		}
		
		public function setSelfGroup(value:FlxGroup):void 
		{
			_selfGroup = value;
			value.add( this );
		}
		private function _OnBattleGroundMapLayerChanged(evt:BattleGroundMapLayerChangedEvent):void
		{
			changeLayer( evt.mapLayer);
		}
		public function changeLayer( dstLayer:uint ):void
		{
			var bRes:Boolean = ( dstLayer == _gameObjData.mapLayer);
			this.active = bRes;
			this.visible = bRes;
			this.exists = bRes;
		}
		public function collideTrig( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			
		}
		
		protected function removeFromGroup():void
		{
			if ( _selfGroup != null )
			{
				_selfGroup.remove( this );
			}
		}
		public function getPrePoint():FlxPoint
		{
			return _point;
		}
		public function setPrePoint( preX:Number, preY:Number ):void
		{
			_point.x = preX;
			_point.y = preY;
		}
		override public function update():void
		{
			super.update();
			if ( _enableUpdateTick == true )
			{
				_tickCount -= FlxG.elapsed;
				if ( _tickCount <  0)
				{
					_tickCount = _tickConstCount;
					TickUpdateFunction();
				}
			}
			if ( _updatePrePoint == true )
			{
				setPrePoint(this.x, this.y);
			}
		}
		protected function TickUpdateFunction():void
		{
		}
		
		protected function soundPlay( strSound:String ):void
		{
			if ( dsp != null )
			{
				var evt:PlaySoundEvent = new PlaySoundEvent( PlaySoundEvent.PLAY_SOUND_EVENT );
				evt.strSound = strSound;
				dsp.DispatchEvent(evt);	
			}
		}
		public function collideByOtherObj( otherObj:BaseGameObject ):void
		{
			removeFromGroup();
		}

		
		public function SetEditorPadData(editorPadData:EditorPadData):void
		{
			_gameObjData.mapLayer = editorPadData.currentLayer;
		}
		
		public function GameObjectSettingDataObject( dataObj:GameBaseDataObject):void
		{
			dataObj.elementMainType 	= getMainTyp();
			dataObj.elementSubType 		= getSubTyp();
			dataObj.posX 				= x;
			dataObj.posY 				= y;
			dataObj.mapRow 				= gameObjData.mapRow;
			dataObj.mapCol				= gameObjData.mapCol;
			dataObj.mapLayer			= gameObjData.mapLayer;
			dataObj.scaleX				= gameObjData.scaleX;
			dataObj.scaleY				= gameObjData.scaleY;
			
			dataObj.spriteWidth 		= gameObjData.spriteWidth;
			dataObj.spriteHeight 		= gameObjData.spriteHeight ;
			dataObj.spriteCol 			= gameObjData.spriteCol ;
			dataObj.spriteRows 			= gameObjData.spriteRows ;
			dataObj.spriteCnts 			= gameObjData.spriteCnts ;
		}
	}
}