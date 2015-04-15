package final2140final.translator.api;

import com.memetix.mst.language.Language;
import com.memetix.mst.translate.Translate;

public class bingTranslator {
	
	public String translate(String inputText, Language fromLan, Language toLan) throws Exception{
		Translate.setClientId("2140bing_translate");
		Translate.setClientSecret("qTu36JotNAKrjz+yhf+7ETZ8a/40tZyB97U2RC56Td4=");
		
		return Translate.execute(inputText, fromLan, toLan);
	}
}
