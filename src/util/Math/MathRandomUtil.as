package util.Math 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class MathRandomUtil 
	{
		
		public function MathRandomUtil() 
		{
			
		}
		public static function randRange(min:Number, max:Number):Number 
		{
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
	}

}