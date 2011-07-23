package br.eng.mosaic.pigeon.web.world 
{
	import br.eng.mosaic.pigeon.web.entities.Cursor;
	import br.eng.mosaic.pigeon.web.entities.Enemy;
	import br.eng.mosaic.pigeon.web.entities.Pigeon;
	import br.eng.mosaic.pigeon.web.entities.Shot;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;

	import br.eng.mosaic.pigeon.web.entities.Cursor;
	import br.eng.mosaic.pigeon.web.entities.FacebookConfig;
	import br.eng.mosaic.pigeon.web.entities.PlayButton;
	import br.eng.mosaic.pigeon.web.entities.background.*;
	import br.eng.mosaic.pigeon.web.entities.background.selection.*;
	import br.eng.mosaic.pigeon.web.entities.background.transition.*;
	
	public class MyWorld extends World
	{

		private var pigeon:Pigeon = new Pigeon();
		
		public static var playing = false;
		
		public static var userX:int = 0;
		public static var userY:int = 0;
		
		//public static var cursor:Cursor=new Cursor;
		public var cursor:Cursor=new Cursor;

		public function MyWorld() {	
			//add(new Background);
			//addGraphic(new Background);
			
			add(pigeon);
			
			add(cursor);
			var enemy:Enemy = new Enemy();
			
			//enemy.x= 0;
			//Cria em algum lugar X aleatorio acima
			enemy.x = Math.random()%(FP.width)
			enemy.y= 0;
			add(enemy);
			
			enemy = new Enemy();
			enemy.x= FP.width - enemy.width;
			//Cria em algum lugar X aleatorio acima
			//enemy.x = Math.random()%(FP.width)
			enemy.y=0;
			add(enemy);
			
			enemy = new Enemy();
			//Cria em algum lugar X aleatorio abaixo
			enemy.x=0;
			//enemy.x = Math.random()%(FP.width)
			enemy.y=FP.height - enemy.height;
			add(enemy);
			
			
			enemy = new Enemy();
			//Cria em algum lugar X aleatorio abaixo
			enemy.x=FP.width - enemy.width;
			//enemy.x = Math.random()%(FP.width)
			enemy.y=FP.height - enemy.height;
			add(enemy);
			
			add (new FigeanSelection);
			
		}
		
		private var shots:Array=[];
		
		override public function update():void{
			super.update();
			if(Input.mousePressed){
				var shot:Shot=new Shot();
				shot.x=cursor.x + cursor.width/2 - shot.width/2;
				shot.y=cursor.y + cursor.height/2 - shot.height/2;
				shots[shots.length]=shot;
				add(shot);
			}
			this.bringForward(cursor);
			
			//Se não tem mais inimigos, termina
			if (this.classCount(Enemy)==0){
				pigeon.finalize();
			}
		}
	}
}