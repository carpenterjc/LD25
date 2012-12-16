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
	public class LooserWorld extends World
	{

		private var waited:Boolean = false;

		public function LooserWorld()
		{
			
		}
		
		override public function begin():void
		{
			var statusentity:Entity = new Entity();
			var statusstring:Text = new Text("Oh dear!\nDid I hit you with my handbag?\nAre you OK?\nDreadfully sorry dear!\nAgain?");
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
		public function timeout() : void
		{
			waited = true;
		}
	}
}
