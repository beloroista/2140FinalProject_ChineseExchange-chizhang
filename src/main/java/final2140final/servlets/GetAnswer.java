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
import org.json.simple.parser.ParseException;

import com.memetix.mst.language.Language;

import final2140final.stackexhcange.api.HttpFactory;
import final2140final.stackexhcange.api.QuestionsApi;
import final2140final.translator.api.NewTranslator;
import final2140final.translator.api.bingTranslator;

/**
 * Servlet implementation class GetAnswer
 */
public class GetAnswer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAnswer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String questionId = request.getParameter("question_id");
		String site = request.getParameter("site");
		String sort = request.getParameter("sort");
		//String sort="desc&sort";
		//test
	//	questionId="28469472";
	//	site = "stackoverflow";
		
		QuestionsApi questionsApi;
		questionsApi = new QuestionsApi(new DecompressingHttpClient(HttpFactory.httpClient(true)));
		NewTranslator translator = new NewTranslator();
		
		String answerUri = questionsApi.makeGetAnswerURI(questionId, site,sort);
		//System.out.println(answerUri);
		String returnedJson = "";
		returnedJson = questionsApi.jsonFromUrl(answerUri);
		
		JSONParser jsonParser = new JSONParser();
		JSONArray itemsJsonArr = new JSONArray();
		JSONObject itemJsonObj = new JSONObject();
		JSONObject outputObj = new JSONObject();
		JSONArray outputArr = new JSONArray();
		String chineseBody = "";
		
		response.setHeader("Content-type", "text/html;charset=UTF-8");//
		PrintWriter out = response.getWriter();
		
		
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
				//System.out.println(itemJsonObj.toString());
				chineseBody = translator.translate((String)(itemJsonObj.get("body")), Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
				//System.out.println(chineseBody);
				itemJsonObj.put("chineseBody", chineseBody);
				outputArr.add(itemJsonObj);
			}
			outputObj.put("items", itemsJsonArr);
			
			//-----------
			

			
			String Questionuri = questionsApi.makeGetQuestionURI(questionId, site,sort);
			//System.out.println(answerUri);
			String returnedQuestionJson = "";
			returnedQuestionJson = questionsApi.jsonFromUrl(Questionuri);
			
			
				JSONObject questionobject = (JSONObject)jsonParser.parse(returnedQuestionJson);
				JSONObject questioncontent = new JSONObject();
				if (questionobject.get("items")!=null) {
					questioncontent = (JSONObject) ((JSONArray)questionobject.get("items")).get(0);
					String chineseTitle = translator.translate((String)(questioncontent.get("title")), Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
					questioncontent.put("chinesetitle", chineseTitle);
				}else{
					//no result
				}
						
				outputObj.put("question", questioncontent);
			
			
			
		//	outputObj.put("items", itemsJsonArr);

			//System.out.println(outputObj.toString());
			out.write(outputObj.toString());
			
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
