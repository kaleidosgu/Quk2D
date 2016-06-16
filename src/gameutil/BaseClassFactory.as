package gameutil 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseClassFactory 
	{
		protected var _objectClass:Object = new Object();
		private var _baseClass:Class = null;
		public function BaseClassFactory() 
		{
			
		}
		protected function SetBaseClass( baseClass:Class ):void
		{
			_baseClass = baseClass;
		}
		protected function AddClass( mainTyp:uint, subTyp:uint, inClass:Class ):void
		{
			var objClass:Object = _objectClass[mainTyp];
			if ( objClass == null )
			{
				_objectClass[mainTyp] = new Object();
				var subObjClass:Object = _objectClass[mainTyp][subTyp];
				if ( subObjClass == null )
				{
					_objectClass[mainTyp][subTyp] = inClass;
				}
			}
		}
		protected function CreateClassByTyp( mainTyp:uint, subTyp:uint ):Object
		{
			var obj:Object = null;
			var insClass:Class = _getClassByType( mainTyp, subTyp );
			
			if ( insClass != null )
			{
				obj = new insClass();
			}
			else
			{
				if ( _baseClass != null )
				{
					AddClass( mainTyp, subTyp, _baseClass );
					obj = new _baseClass();
				}
			}
			return obj;
		}
		private function _getClassByType( mainTyp:uint, subTyp:uint ):Class
		{
			var baseClass:Class = null;
			var objClass:Object = _objectClass[mainTyp];
			if ( objClass != null )
			{
				baseClass = objClass[subTyp];	
			}
			return baseClass;
		}
		
	}

}