package br.eng.mosaic.pigeon.web.remote
{
	import br.eng.mosaic.pigeon.web.model.PigeonModel;
	import br.eng.mosaic.pigeon.web.remote.dto.PostarScoreDTO;
	
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONDecoder;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.http.HTTPService;
	

	public class Service 
	{
		
		private const serviceBaseUrl:String="http://mosaic.eng.br/server";
		
		private var operations:Object;
		
		public function Service()
		{
			operations=new Object;
			
			operations["publish"]= createHttpService("http://www.mosaic.eng.br/server/"+PigeonModel.getInstance().userID+"/oauth/facebook/publish.do");
			operations["topFive"]=createHttpService("http://www.mosaic.eng.br/server/topfive.do");
			
		}
		
		
		private function createHttpService(url:String):HTTPService{
			var service:HTTPService = new HTTPService();
			service.url=url;
			service.method="POST";
			
			
			return service;
		}
		
		private function getService(method:String):HTTPService{
			return operations[method] as HTTPService;
		}
		
		
	
		

		
		public function publish(message:String, score:String):AsyncToken{
			var data:Object=new Object();
			
			data.message = message;
			data.score=score;
			var token:AsyncToken=HTTPService(operations["publish"]).send(data);
			return token;
		}
		
		public function topFive():AsyncToken{
			var data:Object = new Object();
			var token:AsyncToken=HTTPService(operations["topFive"]).send(data);
			return token;
		}
	}
}