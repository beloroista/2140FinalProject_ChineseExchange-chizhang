package final2140final.stackexhcange.api;

import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.nio.charset.Charset;

import org.apache.commons.httpclient.URIException;
import org.apache.commons.httpclient.util.URIUtil;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.client.utils.URIUtils;
import org.apache.http.util.EntityUtils;

public class QuestionsApi {
	private HttpClient client;
	
	public QuestionsApi(final HttpClient client) {
		super();
		this.client = client;
	}
	
	// API

		public final String jsonFromUrl(final String questionUri)
				throws IOException {
			HttpGet request = null;
			HttpEntity httpEntity = null;
			try {
				
				request = new HttpGet(questionUri);
				
				final HttpResponse httpResponse = client.execute(request);
				httpEntity = httpResponse.getEntity();
				final InputStream entityContentStream = httpEntity.getContent();
				final String outputAsEscapedHtml = IOUtils.toString(
						entityContentStream, Charset.forName("utf-8"));
				return outputAsEscapedHtml;
			} catch (final IOException ex) {
				throw new IllegalStateException(ex);
			} finally {
				if (request != null) {
					request.releaseConnection();
				}
				if (httpEntity != null) {
					EntityUtils.consume(httpEntity);
				}
			}
		}
		
		public final String makeSearchQuestionURI(String q, String site) throws URIException{
			
			String originalUriString="https://api.stackexchange.com/search/advanced?order=desc&sort=relevance&q="+q+"&site="+site+"&filter=!)4k)sg)DG*ot)0l3bUI2ltMKwCWi";
			return URIUtil.encodeQuery(originalUriString);
		}
		
		public final String makeGetAnswerURI(String questionId, String site, String sort) throws URIException{
			String originalUriString = "https://api.stackexchange.com/questions/"+questionId+"/answers?order=desc&sort="+sort+"&site="+site+"&filter=!4*Zo7YZsxr6*fr_99";
			return URIUtil.encodeQuery(originalUriString);
		}
		
		public final String makeGetQuestionURI(String questionId, String site, String sort) throws URIException{
			String originalUriString = "https://api.stackexchange.com/questions/"+questionId+"?order=desc&sort="+sort+"&site="+site+"&filter=!-*f(6rkvMbqu";
			return URIUtil.encodeQuery(originalUriString);
		}
		
	 
}
