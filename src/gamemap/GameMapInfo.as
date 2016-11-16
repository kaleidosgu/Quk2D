package gamemap 
{
	import Base.BaseGameObject;
	import Base.GameBaseDataObject;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import gamemap.Building.GameMapBuildingInf.BuildingInfoGravityMachine;
	import gamemap.Building.GameMapBuildingInf.GameMapElementBuildingInfo;
	import gamemap.GameMapElementInfo.GameMapElementInfoFactory;
	import gameutil.UtilConvert;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapInfo extends GameBaseDataObject
	{
		private var _arrayMapElement:Array = new Array();
		private var _buildingFactory:GameMapElementInfoFactory = new GameMapElementInfoFactory();
		public function GameMapInfo() 
		{
			super();
			registeClassName();
		}
		override public function getByteArray():ByteArray
		{
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
			var newElementInfo:GameMapElementInfo = _buildingFactory.CreateObject( gameObj.getMainTyp(), gameObj.getSubTyp());
			gameObj.GameObjectSettingDataObject(newElementInfo);
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
		public function getObj( mapRow:uint, mapCol:uint ):GameMapElementInfo
		{
			var getElementInfo:GameMapElementInfo = null;
			for each( var elementInfo:GameMapElementInfo in _arrayMapElement )
			{
				if ( elementInfo.mapRow == mapRow && elementInfo.mapCol == mapCol )
				{
					getElementInfo = elementInfo;
				}
			}
			return getElementInfo;
		}

		override public function setDataFromByteArray( bytArray:ByteArray ):void
		{
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
					else
					{
						//need add class to let program know which class could be created.
					}
				}
			}
		}		
		
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("gamemap.GameMapInfo", GameMapInfo);
			registeBuildingClass();
		}
		
		public function getArray():Array
		{
			return _arrayMapElement;
		}
		private function registeBuildingClass():void
		{
			new BuildingInfoGravityMachine();
			new GameMapElementBuildingInfo();
		}
	}

}