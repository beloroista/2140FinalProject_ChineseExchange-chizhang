package final2140final;

import java.io.IOException;
import java.util.Iterator;

import org.apache.http.impl.client.DecompressingHttpClient;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.memetix.mst.language.Language;

import final2140final.stackexhcange.api.HttpFactory;
import final2140final.stackexhcange.api.QuestionsApi;
import final2140final.translator.api.bingTranslator;

public class testtranslate {
	
	 public static void main(String argsp[]) throws Exception {  
		 
		 bingTranslator b=new bingTranslator();
		 String o= b.translate("<html>english is the text", Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
		 System.out.println(o);
		 
		 
		 
		 String questionId="29443011";
			String site = "stackoverflow";
			
			QuestionsApi questionsApi;
			questionsApi = new QuestionsApi(new DecompressingHttpClient(HttpFactory.httpClient(true)));
			bingTranslator translator = new bingTranslator();
			
			String answerUri = questionsApi.makeGetAnswerURI(questionId, site,"desc&sort");
			//System.out.println(answerUri);
			String returnedJson = "";
			returnedJson = questionsApi.jsonFromUrl(answerUri);
			
			JSONParser jsonParser = new JSONParser();
			JSONArray itemsJsonArr = new JSONArray();
			JSONObject itemJsonObj = new JSONObject();
			JSONObject outputObj = new JSONObject();
			JSONArray outputArr = new JSONArray();
			String chineseBody = "";
			
		//	response.setHeader("Content-type", "text/html;charset=UTF-8");//鍛婄煡娴忚鍣ㄧ紪鐮佹柟寮�;
			//PrintWriter out = response.getWriter();
			
			
			try {
				JSONObject wholeObject = (JSONObject)jsonParser.parse(returnedJson);
				if (wholeObject.get("items")!=null) {
					itemsJsonArr = (JSONArray)wholeObject.get("items");
				}else{
					//no result
				}
				
				Iterator itr = itemsJsonArr.iterator();
				while (itr.hasNext()) {
					itemJsonObj = (JSONObject)itr.next();
				//	System.out.println(itemJsonObj.toString());
					long aid=(long)(itemJsonObj.get("answer_id"));
					String a=(String)(itemJsonObj.get("body"));
					chineseBody = translator.translate((String)(itemJsonObj.get("body")), Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
					System.out.println(a);
				//	itemJsonObj.put("chineseBody", chineseBody);
					outputArr.add(itemJsonObj);
				}
				outputObj.put("items", itemsJsonArr);
				//System.out.println(outputObj.toString());
			//	out.write(outputObj.toString());
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		 
	 }

}
