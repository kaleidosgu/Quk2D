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
			registeClassName();
			var bytArray:ByteArray = new ByteArray();
			
			var arrayLength:uint = _arrayMapElement.length;
			bytArray.writeUnsignedInt( arrayLength );
			for each( var eleInfo:GameMapElementInfo in _arrayMapElement )
			{
				bytArray.writeObject( eleInfo );
			}
			bytArray.position = 0;
			bytArray.compress(CompressionAlgorithm.DEFLATE);
			return bytArray;
		}
		
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("gamemap.GameMapInfo", GameMapInfo);
			registerClassAlias("gamemap.GameMapElementInfo", GameMapElementInfo);
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
				if ( elementInfo.mapRow == gameObj.gameObjData.mapRow && 
				elementInfo.mapCol == gameObj.gameObjData.mapCol )
				{
					var delArray:Array = _arrayMapElement.splice( elementIndex, 1 );
					break;
				}
				elementIndex++;
			}
			var newElementInfo:GameMapElementInfo = new GameMapElementInfo();
			UtilConvert.convertGameObjToElementInfo( gameObj, newElementInfo );
			_arrayMapElement.push( newElementInfo );
		}
		
		public function removeObj( mapRow:uint, mapCol:uint ):GameMapElementInfo
		{
			var elementIndex:uint = 0;
			var removeElementInfo:GameMapElementInfo = null;
			for each( var elementInfo:GameMapElementInfo in _arrayMapElement )
			{
				if ( elementInfo.mapRow == mapRow && elementInfo.mapCol == mapCol )
				{
					var delArray:Array = _arrayMapElement.splice( elementIndex, 1 );
					if ( delArray.length != 0 )
					{
						removeElementInfo = delArray[0];
					}
				}
				elementIndex++;
			}
			return removeElementInfo;
		}

		override public function setDataFromByteArray( bytArray:ByteArray ):void
		{
			registeClassName();
			
			super.setDataFromByteArray( bytArray );
			if ( bytArray.length != 0 )
			{
				bytArray.position = 0;
				bytArray.uncompress(CompressionAlgorithm.DEFLATE);
				bytArray.position = 0;
				var arrayLength:uint = bytArray.readUnsignedInt();
				for ( var arrayIndex:uint = 0; arrayIndex < arrayLength; arrayIndex++ )
				{
					var eleInfo:GameMapElementInfo = null;
					var readObj:Object = bytArray.readObject();
					if ( readObj is GameMapElementInfo )
					{
						eleInfo = readObj as GameMapElementInfo;
						_arrayMapElement.push( eleInfo );	
					}
				}
			}
		}		
	}

}