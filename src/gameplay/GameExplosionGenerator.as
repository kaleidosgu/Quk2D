package gameplay 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxParticle;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameExplosionGenerator 
	{
		static private var _staticIns:GameExplosionGenerator = null;
		public function GameExplosionGenerator( ) 
		{
		}
		static public function getIns():GameExplosionGenerator
		{
			if ( _staticIns == null )
			{
				_staticIns = new GameExplosionGenerator();
			}
			return _staticIns;
		}
		public function generateExplosion( posX:Number, posY:Number, _gameState:FlxState ):void
		{
			if ( _gameState != null )
			{
				var emitter:FlxEmitter = new FlxEmitter(posX, posY); //x and y of the emitter
				emitter.minParticleSpeed.x = -100;
				emitter.minParticleSpeed.y = -100;
				
				emitter.maxParticleSpeed.y = 100;
				emitter.maxParticleSpeed.x = 100;
				emitter.maxRotation = 1;
				emitter.minRotation = 3;
				generateEmitter( emitter );
				_gameState.add(emitter);
				emitter.start(true, 0.2,5 );
			}
		}
		
		private function generateEmitter(emitter:FlxEmitter ):void
		{
			for(var i:int = 0; i < 3; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xffffffff);
				particle.exists = false;
				particle.lifespan = 50;
				emitter.add(particle);
			}
		}
	}

}