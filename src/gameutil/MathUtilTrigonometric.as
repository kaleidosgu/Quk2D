package gameutil 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class MathUtilTrigonometric 
	{
		private var _sinAng:Number = 0;
		private var _cosAng:Number = 0;
		public function MathUtilTrigonometric() 
		{
			
		}
		public function calculateAng( srcPosX:Number, srcPosY:Number, dstPosX:Number, dstPosY:Number ):void
		{
			var newWidth:Number = dstPosX - srcPosX;
			var newHeight:Number = dstPosY - srcPosY;
			
			var rLength:Number = Math.sqrt( newWidth * newWidth + newHeight * newHeight );
			
			_sinAng = newHeight / rLength;
			_cosAng = newWidth  / rLength;
		}
		public function calculateAngBySize( objSrcPosX:Number, objSrcPosY:Number, objSrcWidth:Number, objSrcHeight:Number,
		objDstPosX:Number, objDstPosY:Number, objDstWidth:Number, objDstHeight:Number ):void
		{
			var srcX:Number = objSrcPosX + objSrcWidth / 2;
			var srcY:Number = objSrcPosY + objSrcHeight / 2;
			
			var dstX:Number = objDstPosX + objDstWidth / 2;
			var dstY:Number = objDstPosY + objDstHeight / 2;
			calculateAng( srcX, srcY, dstX, dstY );
		}
		
		public function get sinAng():Number 
		{
			return _sinAng;
		}
		
		public function get cosAng():Number 
		{
			return _cosAng;
		}
		
	}

}