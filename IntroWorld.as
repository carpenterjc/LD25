package {
	import net.flashpunk.World;
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * @author jamescarpenter
	 */
	public class IntroWorld extends World
	{
		private var waited:Boolean = false;

		public function IntroWorld()
		{
			
		}
		
		override public function begin():void
		{
			var statusentity:Entity = new Entity();
			var statusstring:Text = new Text("Those handbags contain money,\nyou wan't it!\nNick those handbags by spinning\nand hitting the old dears with\nyour swag bag.\nCarefull you don't get too dizzy...\nor they'll get you!\n");
			statusentity.graphic = statusstring;
			add(statusentity);
			FP.alarm(2, timeout);
		}

		override public function update():void
		{
			if(Input.check(Key.SPACE) && waited)
			{
				FP.world = new GameWorld();
			}
		}
		public function timeout() :void
		{
			waited = true;
		}
	}
}
