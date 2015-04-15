package final2140final.translator.api;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.util.ArrayList;

import com.memetix.mst.language.Language;
import com.memetix.mst.translate.Translate;

public class NewTranslator {
	
	public String translate(String inputText, Language fromLan, Language toLan) throws Exception{
		
		Translate.setClientId("2140bing_translate");
		Translate.setClientSecret("qTu36JotNAKrjz+yhf+7ETZ8a/40tZyB97U2RC56Td4=");
		Translate.setContentType("text/HTML");
		
		int beginindex=0;
		 int endindex=0;
		 int cnt=0;		 
		 ArrayList codes=new ArrayList();
		 System.out.println("ori is "+inputText);
		 
		 StringBuilder sb =new StringBuilder();		 
		 

		
		 while (inputText.indexOf("<code>", beginindex)!=-1){
			 
			 beginindex=inputText.indexOf("<code>", beginindex)+4;
			 
			 String noncodepart=inputText.substring(endindex, beginindex-4);
			 String trans=Translate.execute(noncodepart, fromLan, toLan);		
			 sb.append(trans);
			 endindex=inputText.indexOf("</code>", beginindex)+7;	
			 String codepart=inputText.substring(beginindex-4, endindex);
			 sb.append(codepart);
			 
		 }
		 
		 sb.append( Translate.execute(inputText.substring(endindex), fromLan, toLan) );
		 

		 
		return sb.toString();
	}
	
	/**
public static void main(String args[]) throws Exception{
	
	NewTranslator t=new NewTranslator();
	String text=" The move with<code> the highest score </code>is chosen.<code> the hefqweoiuf score </code></p>\n\n<p>Using just 100 runs ";
	System.out.println(text);
	text=t.translate(text, Language.ENGLISH, Language.CHINESE_SIMPLIFIED);
	System.out.println(text);
	
}
	 
	**/

}
