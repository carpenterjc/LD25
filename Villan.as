package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;

	public class Villan extends Entity
	{
		[Embed(source = 'graphics/villan.png')] private const SPRITE:Class;

		public var sprite:Spritemap = new Spritemap(SPRITE, 11, 13);

		private var speed:int = 3;
		private var _velocity:Point;
		private var gridSize:int = 16;
		private var life: int = 100;
		private var dizzy: int = 0;
		private var attacking:Boolean = false;
		private var statusstring:Text;
		private var kills: int  = 0;

		[Embed(source = 'sounds/swag.mp3')] private const SWAG:Class;
		public var swag:Sfx = new Sfx(SWAG);
		[Embed(source = 'sounds/spin.mp3')] private const SPIN:Class;
		public var spin:Sfx = new Sfx(SPIN);
		
		[Embed(source = 'sounds/handbag.mp3')] private const HANDBAG:Class;
		public var handbag:Sfx = new Sfx(HANDBAG);	

		public function Villan(gridLocation:Point, ss:Text)
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
			statusstring = ss;
		}

		public function hit():void
		{
			life --;
			if(life < 1)
			{
				FP.world.remove(this);
			}
			handbag.play();
		}

		override public function update():void
		{
			var movement:Point = new Point;
			if (Input.check(Key.UP)) movement.y--;
			if (Input.check(Key.DOWN)) movement.y++;
			if (Input.check(Key.LEFT)) movement.x--;
			if (Input.check(Key.RIGHT)) movement.x++;
			
			var attackkey:Boolean = Input.check(Key.SPACE);
			var attack:Boolean = false;
			if(attackkey)
			{
				
				if(attacking && dizzy < 500)
				{
					attack = true;
					dizzy +=10;
				}
				else if (!attacking && dizzy < 50)
				{
					spin.play();
					attacking = true;
					attack = true;
					dizzy +=10;
				}
			}
			else
			{
				if ( dizzy > 1)
				{
					dizzy--;
				}
				attacking = false;
			}

			
			//if(!attack)
			//{
				_velocity.x = 100 * FP.elapsed * movement.x;
				_velocity.y = 100 * FP.elapsed * movement.y;
			//}


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

			var gran:Entity = collide("granny", x, y);
			if(gran is Entity && attack)
			{
				FP.world.remove(gran);
				kills++;
				swag.play();
			}

			var str:String = "{0}% Health - {1} Handbags";
			var newString:String = StringUtil.substitute(str, life/5, kills);
			statusstring.text = newString;
			super.update()
		}
	}
}