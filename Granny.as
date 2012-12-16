package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import mx.utils.ObjectUtil;

	public class Granny extends Entity
	{
		[Embed(source = 'graphics/granny.png')] private const SPRITE:Class;

		public var sprite:Spritemap = new Spritemap(SPRITE, 11, 13);

		private var speed:int = 3;
		private var _velocity:Point;
		private var gridSize:int = 16;
		private var movement:Point;
		private var villan:Villan;

		public function Granny(gridLocation:Point, mvmt:Point, vil:Villan)
		{
			sprite.add("runright", [0,1], 5, true);
			sprite.add("runleft", [2,3], 5, true);
			sprite.add("runcenter", [4,5], 5, true);
			sprite.add("handbag", [6,7], 5, true);
			sprite.x = 0;
			sprite.y = 0;
			width = 11;
			height = 13;
			setHitbox(11,13,0,0);
			graphic = sprite;
			_velocity = new Point;
			movement = mvmt;
			x = gridLocation.x * gridSize;
			y = gridLocation.y * gridSize;
			type = "granny";
			villan = vil;
		}

		override public function update():void
		{
			
			_velocity.x = 50 * FP.elapsed * movement.x;
			_velocity.y = 50 * FP.elapsed * movement.y;

			
			
			var collided:Boolean = false;

			x += _velocity.x;
			if (collide("level", x, y) ) 
			{
				//Moving right
				if (FP.sign(_velocity.x) > 0) 
				{
					_velocity.x = 0;
					x = Math.floor((x + width) / gridSize) * gridSize - width;

				} else 
				{ 
					//Moving left
					_velocity.x = 0;
					x = Math.floor(x / gridSize) * gridSize + gridSize;
				}
				collided = true;
			}
			if(collide("granny", x, y))
			{
				//collided = true;
			}

			

			y += _velocity.y;
			if (collide("level", x, y)) 
			{
				//Moving down
				if (FP.sign(_velocity.y) > 0) 
				{
					_velocity.y = 0;
					y = Math.floor((y + height) / gridSize) * gridSize - height;

				} else
				{ 
					//Moving up
					_velocity.y = 0;
					y = Math.floor(y / gridSize) * gridSize + gridSize;
				}
				collided = true;
			}
			if(collide("granny", x, y))
			{
				//collided = true;
			}


			var attacking:Boolean = collide("villan", x + (_velocity.x *3), y + (_velocity.y *3)) is Entity;

			if(movement.x > 0 && !attacking)
			{
				sprite.play("runright");
			}
			else if ( movement.x < 0 && !attacking)
			{
				sprite.play("runleft");
			}
			else if(attacking)
			{
				sprite.play("handbag")
			}
			else
			{
				sprite.play("runcenter")
			}

			if (collided)
			{
				var currentHeading:Number = Math.atan2(movement.y, movement.x);
				var newHeading:Number = currentHeading + (((Math.random()-0.5)*2*Math.PI)/2);
				movement.x = Math.sin(newHeading);
				movement.y = Math.cos(newHeading);
			}
			if(attacking)
			{
				villan.hit()
			}
			super.update()
		}
	}
}