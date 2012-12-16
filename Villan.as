package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import net.flashpunk.FP;

	public class Villan extends Entity
	{
		[Embed(source = 'graphics/villan.png')] private const SPRITE:Class;

		public var sprite:Spritemap = new Spritemap(SPRITE, 16, 16);

		private var speed:int = 3;
		private var _v:Point;

		public function Villan()
		{
			sprite.add("stand", [0,1], 10, true);
			sprite.add("runright", [2,3], 20, true);
			sprite.add("runleft", [4,5], 20, true);
			sprite.add("runcenter", [6,7], 20, true);

			setHitbox(11,14,5,1);
			graphic = sprite;
			_v = new Point;
		}

		override public function update():void
		{
			var movement:Point = new Point;
			if (Input.check(Key.UP)) movement.y--;
			if (Input.check(Key.DOWN)) movement.y++;
			if (Input.check(Key.LEFT)) movement.x--;
			if (Input.check(Key.RIGHT)) movement.x++;
			_v.x = 100 * FP.elapsed * movement.x;
			_v.y = 100 * FP.elapsed * movement.y;

			if(movement.x > 0)
			{
				sprite.play("runright");
			}
			else if ( movement.x < 0 )
			{
				sprite.play("runleft");
			}
			else if(movement.x == 0 && movement.y ==0)
			{
				sprite.play("stand")
			}
			else
			{
				sprite.play("runcenter")
			}

			x += _v.x;
			if(collide("level", x, y))
			{
				if(FP.sign(_v.x) >0)
				{ //moving right
					_v.x = 0;
					x = Math.floor(x/16) * 16 - 16 - width;
				}
				else 
				{//moving left
					_v.x = 0;
					x = Math.floor(x/16) * 16;
				}
				

			}

			y += _v.y;
			if(collide("level", x, y))
			{
				if(FP.sign(_v.y) >0)
				{ //moving down
					_v.y = 0;
					y = Math.floor(y/16) * 16;
				}
				else 
				{//moving down
					_v.y = 0;
					
					y = Math.floor(y/16) * 16 - 16 - height;
				}
			}

			super.update()
		}
	}
}