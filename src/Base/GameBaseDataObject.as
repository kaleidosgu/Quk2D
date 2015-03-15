package Base 
{
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	/**
	 * 可以让数据Bytearray序列化
	 * @author kaleidos
	 */
	public class GameBaseDataObject extends Object 
	{
		public function GameBaseDataObject() 
		{
			
		}
		
		public function getByteArray():ByteArray
		{
			registeClassName();
			
			var bytArray:ByteArray = new ByteArray();
			bytArray.writeObject( this );
			bytArray.position = 0;
			bytArray.compress(CompressionAlgorithm.DEFLATE);
			
			return bytArray;
		}
		protected function registeClassName():void
		{
			
		}
	}

}