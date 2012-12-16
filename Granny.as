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

		public function Granny(gridLocation:Point, mvmt:Point)
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
				
		}

		override public function update():void
		{
			
			_velocity.x = 50 * FP.elapsed * movement.x;
			_velocity.y = 50 * FP.elapsed * movement.y;

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

			x += _velocity.x;

			if (collide("level", x, y)) {
				//Moving right
				if (FP.sign(_velocity.x) > 0) {
					_velocity.x = 0;
					x = Math.floor((x + width) / gridSize) * gridSize - width;

				} else { //Moving left
					_velocity.x = 0;
					x = Math.floor(x / gridSize) * gridSize + gridSize;
				}
				movement.x = 0 - movement.x;
			}

			y += _velocity.y;

			if (collide("level", x, y)) {
				//Moving down
				if (FP.sign(_velocity.y) > 0) {
					_velocity.y = 0;
					y = Math.floor((y + height) / gridSize) * gridSize - height;

				} else { //Moving up
					_velocity.y = 0;
					y = Math.floor(y / gridSize) * gridSize + gridSize;
				}
				movement.y = 0 - movement.y;
			}

			super.update()
		}
	}
}