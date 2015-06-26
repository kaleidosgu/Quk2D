package gamemap.Building 
{
	import Base.GameBaseDataObject;
	import gamemap.GameMapBuildingTyp;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BuildingElevator extends BaseBuildingObject 
	{
		
		[Embed(source = '../../../res/images/elevator.png')]
		private static var elevatorClass:Class;
		private var _downFlag:Boolean = true;
		private var _startPosY:Number = 0;
		private var _moveDiff:Number = 50;
		private var _moveSpeed:Number = 1;
		public function BuildingElevator() 
		{
			
		}
		override public function createObjectByXml( mapDetailXml:XML ):void
		{
			super.createObjectByXml( mapDetailXml );
		}
		override public function resClass():Class
		{
			return elevatorClass;
		}
		override public function getSubTyp():uint
		{
			return GameMapBuildingTyp.GameMapBuildingTyp_Elevator;
		}
		override public function update():void
		{
			super.update();
			if ( _downFlag == true )
			{
				this.y += _moveSpeed;
			}
			else
			{
				this.y -= _moveSpeed;
			}
			if ( this.y <= _startPosY - _moveDiff )
			{
				_downFlag = true;
			}
			else if ( this.y > _startPosY + _moveDiff )
			{
				_downFlag = false;
			}
		}
		override public function createObjectByBaseData( baseData:GameBaseDataObject ):void
		{
			super.createObjectByBaseData( baseData );
			_startPosY = this.y;
		}
	}

}