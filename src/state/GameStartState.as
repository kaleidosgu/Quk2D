package state 
{	
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameStartState extends FlxState 
	{
		[Embed(source = "../../res/images/alt_tiles.png")] private static var blockTile:Class;
		[Embed(source = "../../res/images/spaceman.png")] private static var spaceManTile:Class;
		
		private var player:FlxSprite = null;
		private var tileGroup:FlxGroup = new FlxGroup();
		public function GameStartState() 
		{
			
		}

		override public function create():void
		{
			super.create();
			createBlockGroup();
			createRole();
		}
		private function createRole():void
		{
			player = new FlxSprite(64, 100 );
			player.loadGraphic(spaceManTile, true, true, 16);
			
			//bounding box tweaks
			player.width = 16;
			player.height = 16;
			player.offset.x = 1;
			player.offset.y = 1;
			
			//basic player physics
			player.drag.x = 640;
			player.acceleration.y = 420;
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 160;
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4, 5, 6]);
			
			add(player);
			player.angularVelocity = 100;
			//player.angularAcceleration = 100;
			player.origin.x = 0;
			player.origin.y = 0;
		}
		private function createBlockGroup():void
		{
			var blockCounts:uint = 320 / 16;
			var posY:int = 200;
			for ( var blockIndex:uint = 0; blockIndex < blockCounts; blockIndex++ )
			{
				createSingleBlock( blockIndex * 16, posY );
			}
		}
		private function createSingleBlock( posX:int, posY:int ):FlxSprite
		{
			var bgTile:FlxSprite = new FlxSprite( posX,posY );
			bgTile.loadGraphic( blockTile, false, false, 16, 16 );
			bgTile.immovable = true;
			this.add( bgTile );
			tileGroup.add( bgTile );
			return bgTile;
		}
		override public function destroy():void
		{
			super.destroy();
		}
		override public function update():void
		{
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, tileGroup, onTileGroupCollide );
			
			/*
			var hightLightPoint:FlxPoint = getHightLightBoxPoint();
			highlightBox.x = hightLightPoint.x;
			highlightBox.y = hightLightPoint.y;
			*/
			
			if (FlxG.mouse.pressed())
			{
			}
			
			updatePlayer();
			super.update();
			
		}
		
		private function onTileGroupCollide( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			//flxObj1.acceleration.y -= 50;
			//player.velocity.y -= 350;
		}
		private function updatePlayer():void
		{
			wrap(player);
			
			//MOVEMENT
			player.acceleration.x = 0;
			if(FlxG.keys.pressed("A"))
			{
				//player.facing = FlxObject.LEFT;
				player.acceleration.x -= player.drag.x;
			}
			else if(FlxG.keys.pressed("D"))
			{
				//player.facing = FlxObject.RIGHT;
				player.acceleration.x += player.drag.x;
			}
			if(FlxG.keys.justPressed("W") && player.velocity.y == 0)
			{
				player.y -= 1;
				player.velocity.y = -150;
			}
			
			if ( FlxG.keys.justReleased("J" ) )
			{
				//writeMapToFile();
			}
			
			//ANIMATION
			if(player.velocity.y != 0)
			{
				player.play("jump");
			}
			else if(player.velocity.x == 0)
			{
				player.play("idle");
			}
			else
			{
				player.play("run");
			}
		}
		private function wrap(obj:FlxObject):void
		{
			obj.x = (obj.x + obj.width / 2 + FlxG.width) % FlxG.width - obj.width / 2;
			obj.y = (obj.y + obj.height / 2) % FlxG.height - obj.height / 2;
		}
	}

}