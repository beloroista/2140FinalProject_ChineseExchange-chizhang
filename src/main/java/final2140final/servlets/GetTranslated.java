package final2140final.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.memetix.mst.language.Language;
import org.json.simple.JSONObject;
import final2140final.translator.api.*;

/**
 * Servlet implementation class GetTranslated
 */
public class GetTranslated extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetTranslated() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Using GetTranslated");
		//bingTranslator translator = new bingTranslator(); //modify here!
		NewTranslator translator = new NewTranslator();
		
		String englishText = request.getParameter("englishText");
		String chineseText = "";
		JSONObject returnObj = new JSONObject();
		try {
			chineseText = translator.translate(englishText, Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.setHeader("Content-type", "text/html;charset=UTF-8");//鍛婄煡娴忚鍣ㄧ紪鐮佹柟寮�;
		PrintWriter out = response.getWriter();
		
		returnObj.put("translatedText", chineseText);
		out.write(returnObj.toJSONString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
