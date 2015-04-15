package final2140final;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.util.ArrayList;

import com.memetix.mst.MicrosoftTranslatorAPI;
import com.memetix.mst.language.Language;
import com.memetix.mst.translate.Translate;

public class temptranslator {
	
	public String translate(String inputText, Language fromLan, Language toLan) throws Exception{
		//Translate tr=new Translate();
		
		Translate.setClientId("2140bing_translate");
		Translate.setClientSecret("qTu36JotNAKrjz+yhf+7ETZ8a/40tZyB97U2RC56Td4=");
		Translate.setContentType("text/HTML");
		
		int beginindex=0;
		 int endindex=0;
		 int cnt=0;		 
		 ArrayList codes=new ArrayList();
		 
		 
		 //----------------
	//	String convert= inputText.replaceAll("<code>", "<code class=notranslate>");
	//	convert=convert+"<p><span its:translate=\"no\">Do not translate this</span>Do translate this.</p>";
	//	 inputText= inputText.replaceAll("</pre>", "</pre>/>");
		 
		 
	
		String chineseText = Translate.execute(inputText, fromLan, toLan);	
		
		
/**		
		 while (inputText.indexOf("<pre>", beginindex)!=-1){
			 
			 beginindex=inputText.indexOf("<pre>", beginindex)+4;			 
			 endindex=inputText.indexOf("</pre>", beginindex);			 
			 String codepart=inputText.substring(beginindex-4, endindex+7);
			 System.out.println("codepart is "+codepart);
			 codes.add(codepart);
			 inputText= inputText.replaceAll(codepart, "<copart"+cnt+">");
			 cnt++;
			 
		 }
		 
		 String chineseText = Translate.execute(inputText, fromLan, toLan);		 
		 for(int i=0;i<cnt;i++){
			 
			 String insertcode=(String) codes.get(i);
			 chineseText=chineseText.replaceAll("<copart"+i+">", insertcode);
			 
		 }
		 
		 System.out.println("chn is "+chineseText);
		 **/
		return chineseText;
	}
	
	
public static void main(String args[]) throws Exception{

	String a="<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Insert title here</title></head><body><p><span its:translate=\"no\" >Do not translate this</span>Do translate this.</p><p>why i </p> <p><span translate=\"no\">Do not translate this</span>Do translate this.</p></body></html>";
	
	temptranslator t=new temptranslator();
	//String text=" The move with<code> the highest score </code>is chosen.</p>\n\n<p>Using just 100 runs ";
	String text=t.translate(a, Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
	System.out.println(text);
	
}
	 


}
