package gamemap 
{
	import Base.BaseGameObject;
	import Base.GameBaseDataObject;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import gameutil.UtilConvert;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapInfo extends GameBaseDataObject
	{
		private var _arrayMapElement:Array = new Array();
		public function GameMapInfo() 
		{
			
		}
		override public function getByteArray():ByteArray
		{
			registerClassAlias("gamemap.GameMapElementInfo", GameMapElementInfo);
			var bytArray:ByteArray = new ByteArray();
			bytArray.writeObject( _arrayMapElement );
			bytArray.position = 0;
			bytArray.compress(CompressionAlgorithm.DEFLATE);
			return bytArray;
		}
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("gamemap.GameMapInfo", GameMapInfo);
		}
		
		public function getArray():Array
		{
			return _arrayMapElement;
		}
		
		public function updateMapData( gameObj:BaseGameObject ):void
		{
			var elementIndex:uint = 0;
			for each( var elementInfo:GameMapElementInfo in _arrayMapElement )
			{
				if ( elementInfo.gridRow == gameObj.mapRow && 
				elementInfo.gridColumn == gameObj.mapCol )
				{
					_arrayMapElement = _arrayMapElement.splice( elementIndex, 1 );
					break;
				}
				elementIndex++;
			}
			var newElementInfo:GameMapElementInfo = new GameMapElementInfo();
			UtilConvert.convertGameObjToElementInfo( gameObj, newElementInfo );
			_arrayMapElement.push( newElementInfo );
		}
		
	}

}