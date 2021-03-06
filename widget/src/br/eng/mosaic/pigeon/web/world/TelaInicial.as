package br.eng.mosaic.pigeon.web.world 
{
	import br.eng.mosaic.pigeon.web.entities.Cursor;
	import br.eng.mosaic.pigeon.web.entities.FacebookConfig;
	import br.eng.mosaic.pigeon.web.entities.Pigeon;
	import br.eng.mosaic.pigeon.web.entities.PlayButton;
	import br.eng.mosaic.pigeon.web.entities.background.*;
	import br.eng.mosaic.pigeon.web.model.PigeonModel;
	import br.eng.mosaic.pigeon.web.remote.dto.TopFiveDTO;
	
	import com.facebook.graph.Facebook;
	
	import flash.text.TextField;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import punk.ui.*;
	import punk.ui.skins.*;
	
	/**
	 * ...
	 * @author Kellyton Brito
	 */
	public class  TelaInicial extends World {
		
		public static var pontuacao:int = 0;
		public var mensagem:String = "";
		public var textoDoUsuario:Text;
		public var userTextEntity:Entity ;
		public var cursor:Cursor=new Cursor;
		
		private var messageBorder:UserMessage;
		private var textArea:PunkTextArea;
		private var playButton:PlayButton;
		
		private var textLength:int = 140; //#CTP
		private var hashtagLength:int = 4; //#CTP
		private var highScoreLength:int = 4; //#top5
		
		[Embed(source = 'br/eng/mosaic/pigeon/web/assets/mosaic_pigeon_snd_menu5.mp3')]
		private static const BKG_MUSIC:Class;
		public static var bkg_music : Sfx = new Sfx(BKG_MUSIC);
		
		{
			PigeonSelection.bkg_music = bkg_music;
			TransitionScreen.bkg_music = bkg_music;
		}
		
		private function createBackground():void{
			var obj:Entity;
			
			add(new Bg());
			add(new OpeningScreen());
			playButton = new PlayButton(FP.width/2 -33, FP.height*2/3 -18); 
			add(playButton);
			
			messageBorder = new UserMessage();
			messageBorder.x = FP.width/2 - 165;// - obj.width/2;
			messageBorder.y = FP.height - 100; //obj.height;
			add(messageBorder);
			
			
			
			add (new Help(620,415));
			
			add (new FacebookButton(20, FP.height * 1/2 + 70));
			initAvatar();
			//add (new Pause(100, FP.height*1/2 + 240));
			
		}
		
		public function initAvatar():void{
			
			var model:PigeonModel = PigeonModel.getInstance();
			if(model.topFive[0]){
				
				addAvatar(150, 20, model.topFive[0] as TopFiveDTO);
			}
			if(model.topFive[1]){
				
				addAvatar(250, 20, model.topFive[1] as TopFiveDTO);
			}
			if(model.topFive[2]){
				
				addAvatar(350, 20, model.topFive[2] as TopFiveDTO);
			}
			if(model.topFive[3]){
				
				addAvatar(450, 20, model.topFive[3] as TopFiveDTO);
			}
			if(model.topFive[4]){
				
				addAvatar(550, 20, model.topFive[4] as TopFiveDTO);
			}
			
		}
		
		private function addAvatar(x:int, y:int, dto:TopFiveDTO):void{
		
			add(new Avatar(x, y, dto.getPhoto(), dto.getScore().toString()));
		}
		
		
		private const initText:String="<Put Message Here>";
		
		override public function begin():void 
		{
			createBackground();
			
			textArea = new PunkTextArea(initText, FP.width/2 - 160, FP.height - 65, 300, 65, new WhiteAfterlife);
			
			add(textArea); 
			
			// COlocar a musica de novo
			if (!bkg_music.playing){
				bkg_music.loop(0.5, 1);
			}
			
			add(cursor);
	
			
			super.begin();
		}
		
		override public function end():void{
			/*if(textArea.text != initText){
				CatchThePigeon(FP.engine).message=textArea.text;	
			}else{
				CatchThePigeon(FP.engine).message=null;
			}*/
			PigeonModel.getInstance().setUserMessage(textArea.text);
		}
	
		
		public function TelaInicial() {
			
		}
		
		 public function startGame():void{
				//FP.world = new MyWorld;
			//FP.world = new Scenario1;
			 //FP.world = new Scenario2;
			 //FP.world = new Scenario3;
		}
		
		override public function update():void {
			super.update();
			
			if (textArea.text.length > (textLength - hashtagLength)){
				textArea.text = textArea.text.substr(0, textLength - hashtagLength);
			}
			
			this.bringForward(cursor);
			
			//Show/hide the text area
			if(Input.mousePressed&&messageBorder.collidePoint(messageBorder.x, messageBorder.y, Input.mouseX+42, Input.mouseY+42)){
				messageBorder.setShow(!messageBorder.isShowed());
				//Show
				if (messageBorder.isShowed()){
					textArea.visible = true;
				} else { //Hide
					textArea.visible = false;
				} 
			}
			
			/*if(Input.mousePressed&&playButton.collidePoint(playButton.x, playButton.y, Input.mouseX+42, Input.mouseY+42)){
				PigeonModel.getInstance().setUserMessage(textArea.text);
			}*/
			
		}
	}
	
}