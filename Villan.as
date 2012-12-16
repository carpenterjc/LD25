package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import mx.utils.ObjectUtil;

	public class Villan extends Entity
	{
		[Embed(source = 'graphics/villan.png')] private const SPRITE:Class;

		public var sprite:Spritemap = new Spritemap(SPRITE, 11, 13);

		private var speed:int = 3;
		private var _velocity:Point;
		private var gridSize:int = 16;
		private var life: int = 100;

		public function Villan(gridLocation:Point)
		{
			sprite.add("stand", [0,1], 10, true);
			sprite.add("runright", [2,3], 20, true);
			sprite.add("runleft", [4,5], 20, true);
			sprite.add("runcenter", [6,7], 20, true);
			sprite.add("attack", [8,1,9,1], 20, true);
			sprite.x = 0;
			sprite.y = 0;
			width = 11;
			height = 13;
			setHitbox(11,13,0,0);
			graphic = sprite;
			_velocity = new Point;
			x = gridLocation.x * gridSize;
			y = gridLocation.y * gridSize;
			type = "villan"
		}

		public function hit():void
		{
			life --;
			if(life < 1)
			{
				FP.world.remove(this);
			}
		}

		override public function update():void
		{
			var movement:Point = new Point;
			if (Input.check(Key.UP)) movement.y--;
			if (Input.check(Key.DOWN)) movement.y++;
			if (Input.check(Key.LEFT)) movement.x--;
			if (Input.check(Key.RIGHT)) movement.x++;
			var attack:Boolean = Input.check(Key.SPACE);
			if(!attack)
			{
				_velocity.x = 100 * FP.elapsed * movement.x;
				_velocity.y = 100 * FP.elapsed * movement.y;
			}


			if(attack)
			{
				sprite.play("attack");
			}
			else if(movement.x > 0)
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

			//trace(ObjectUtil.toString(_velocity));
			x += _velocity.x;

			if (collide("level", x, y)) {
				trace("collide right-left");
				//Moving right
				if (FP.sign(_velocity.x) > 0) {
					_velocity.x = 0;
					x = Math.floor((x + width) / gridSize) * gridSize - width;

				} else { //Moving left
					_velocity.x = 0;
					x = Math.floor(x / gridSize) * gridSize + gridSize;
				}
			}

			y += _velocity.y;

			if (collide("level", x, y)) {
				trace("collide up-down");
				//Moving down
				if (FP.sign(_velocity.y) > 0) {
					_velocity.y = 0;
					y = Math.floor((y + height) / gridSize) * gridSize - height;

				} else { //Moving up
					_velocity.y = 0;
					y = Math.floor(y / gridSize) * gridSize + gridSize;
				}
			}

			super.update()
		}
	}
}