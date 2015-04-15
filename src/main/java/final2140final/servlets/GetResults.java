package final2140final.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.impl.client.DecompressingHttpClient;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.memetix.mst.language.Language;

import final2140final.translator.api.*;
import final2140final.stackexhcange.api.*;

/**
 * Servlet implementation class GetResults
 */
public class GetResults extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetResults() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		NewTranslator translator = new NewTranslator();
		QuestionsApi questionsApi;
		questionsApi = new QuestionsApi(new DecompressingHttpClient(HttpFactory.httpClient(true)));
		
		System.out.println("running GetResult");
		String inputChinese = request.getParameter("inputChinese");
		//String inputChinese = "java 閭欢";
		//this is first step to search
		String site = request.getParameter("site");
		//site = "stackoverflow";
		String inputEnglish = "";
		String searchQuestionUri = "";
		String returnedJson = "";
		JSONParser jsonParser = new JSONParser();
		JSONArray itemsJsonArr = new JSONArray();
		JSONObject itemJsonObj = new JSONObject();
		JSONObject outputObj = new JSONObject();
		JSONArray outputArr = new JSONArray();
		
		response.setHeader("Content-type", "text/html;charset=UTF-8");//鍛婄煡娴忚鍣ㄧ紪鐮佹柟寮�;
		PrintWriter out = response.getWriter();
		
		try {
			inputEnglish = translator.translate(inputChinese, Language.CHINESE_SIMPLIFIED, Language.ENGLISH);
			System.out.println("inputEnglish: " + inputEnglish);
			searchQuestionUri = questionsApi.makeSearchQuestionURI(inputEnglish, site);
			returnedJson = questionsApi.jsonFromUrl(searchQuestionUri);
			JSONObject wholeObject = (JSONObject)jsonParser.parse(returnedJson);
			
			//System.out.println(wholeObject.toString());
			if (wholeObject.get("items")!=null) {
				itemsJsonArr = (JSONArray)wholeObject.get("items");
			}else{
				//no result
			}
			Iterator itr = itemsJsonArr.iterator();
			while (itr.hasNext()) {
				//System.out.println("!"+itr.next().toString());
				itemJsonObj = (JSONObject)itr.next();
				//System.out.println(translator.translate((String)(itemJsonObj.get("title")), Language.ENGLISH, Language.CHINESE_SIMPLIFIED));
				String chineseTitle = translator.translate((String)(itemJsonObj.get("title")), Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
				itemJsonObj.put("chinesetitle", chineseTitle);
				outputArr.add(itemJsonObj);
			}
			outputObj.put("items", outputArr);
			outputObj.put("inputEnglish", inputEnglish);
			outputObj.put("chinesequery", inputChinese);
			System.out.println("output json: "+outputObj.toString());
			out.write(outputObj.toJSONString());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
