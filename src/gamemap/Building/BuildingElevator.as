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
		private var _accelerationNumber:Number = 50;
		private var _moveSpeed:Number = 1;
		public function BuildingElevator() 
		{
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 160;
			//this.acceleration.y = _accelerationNumber;
			this.velocity.y = _accelerationNumber;
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
			/*if ( _downFlag == true )
			{
				this.y += _moveSpeed;
			}
			else
			{
				this.y -= _moveSpeed;
			}*/
			if ( this.y <= _startPosY - _accelerationNumber )
			{
				_downFlag = true;
				this.velocity.y = _accelerationNumber;
			}
			else if ( this.y > _startPosY + _accelerationNumber )
			{
				_downFlag = false;
				this.velocity.y = -_accelerationNumber;
			}
		}
		override public function createObjectByBaseData( baseData:GameBaseDataObject ):void
		{
			super.createObjectByBaseData( baseData );
			_startPosY = this.y;
		}
	}

}