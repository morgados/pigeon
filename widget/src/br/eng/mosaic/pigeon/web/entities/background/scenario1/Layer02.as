package br.eng.mosaic.pigeon.web.entities.background.scenario1
	
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Layer02 extends Entity 	{
		
		[Embed(source = 'br/eng/mosaic/pigeon/web/assets/layer_02.png')] private const IMAGE:Class;
		
		
		public function Layer02(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null){
			//super(x, y, graphic, mask);
			
			graphic = new Image(IMAGE);
			
			super(x, y, graphic, mask);
			
		}
	}
}