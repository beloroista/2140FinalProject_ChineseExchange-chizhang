<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String qid = new String(request.getParameter("qid"));
	String inputSite = request.getParameter("site");
	String sort = request.getParameter("sort");
//	String qid = "5783969";
//	String inputSite = "stackoverflow";
//	String sort = "activity";
	//System.out.println(inputSite+": "+inputText);

%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<meta author="Haoda Zou">
	<meta e-mail="haz51@pitt.edu">
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/stackexchange.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="shortcut icon" type="image/x-icon" href="http://www.shousibaocai.com/static/favicon.ico">
	
	<link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
	
	<!-- script -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
</head>
<body>



	<nav class="navbar navbar-inverse" role="navigation">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<a class="navbar-brand" href="index.html">Chinese-StackExchange</a>
		</div>
	
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<form class="navbar-form navbar-left x-form" role="search">
				<div class="form-group">
					<input type="text" class="x-kw form-control search-inline" placeholder="Search">
				</div>

				<select name="" id="input" class="x-selector form-control" required="required">
					<option value="stackoverflow">StackOverflow</option>
					<option value="serverfault">ServerFault</option>
					<option value="askubantu">AskUbuntu</option>
				</select>
				<button type="submit" class="btn btn-default">Search</button>
			</form>
			<ul class="nav navbar-nav navbar-right">
				<li><a target="_blank" href="http://www.bing.com/translator/">Bing Translator</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">StackExhcange<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a target="_blank" href="http://stackoverflow.com/">StackOverflow</a></li>
						<li><a target="_blank" href="http://serverfault.com/">ServerFault</a></li>
						<li><a target="_blank" href="http://askubuntu.com/">AskUbuntu</a></li>
					</ul>
				</li>
			</ul>
		</div><!-- /.navbar-collapse -->
	</nav>
	<!-- Loading Item -->
	<div id="loading_item">
		<div class="row">
			<div class="col-lg-offset-3 col-lg-6">
				<h1>Loading...</h1>
				<div class="progress">
					<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
						<span class="sr-only">Loading...</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Result Part -->

	<div class="result_container col-lg-offset-1 col-lg-10">
		<div class="div-ads" style="margiop: -15px;"></div>
		

		
		<div > 排序依据:
		<a  id="creation" class="btn btn-primary">创建时间</a>
		&nbsp
		<a id="votes" class="btn btn-primary">投票数</a>
		&nbsp
		<a  id="activity" class="btn btn-primary">活跃度</a>
		
		<a style="float:right" class="btn btn-primary" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
 		 查看原问题
	</a>
		</div>
		




<div class="collapse" id="collapseExample">
  <div class="well" id=questioncontent>
  
 <tr> <td class="x-item"> <div class="row"> <div class="tag_line"> <div class="tags"> <b>原问题 </b> </div>  </div> </div> <div class="row"> <table class="inner_table"> <tbody> <tr> <th width="20%">中文标题</th> <th width="20%">英文标题</th> <th width="60%">原文(<a class="bodytrans">查看翻译</a>)</th> </tr> <tr> <td width="20%" class="ctId" id=qchinesetitle></td> <td width="20%" class="etId" id=qtitle></td> <td width="60%" class="btId" id=qbody></td> </tr> <tr> <td></td> <td></td> <td id="actions">  </td> </tr> </tbody> </table> </div> </td> </tr>
    
  </div>
</div>




		
		
		<table class="table">
			<tbody>
				
			</tbody>
		</table>
	</div>
	
	<!-- Jquery UI dialog(for translator) -->
	<div id="TranslateDialog" title="Translate Helper"></div>
<script>

	//top search bar
	$('.x-form').submit(function(event) {
		event.preventDefault();
		/* Act on the event */
		var inputText=$('.x-kw').val();
		var site=$('.x-selector').val();
		//alert(site+": "+inputText);
		if (inputText!=''||inputText.length!=0) {
			//alert(site+": "+inputText);
			window.location='resulttest.jsp?q='+inputText+'&site='+site;
			
		}else{
			//if it is empty, do nothing
			$('.x-kw').focus();
		}
		return false;
	});
	

	var site = "<%=inputSite%>";
	var question_id = "<%=qid%>";
	var sort = "<%=sort%>";
	var inputEnglish;
	var itemsArr = [];
	var question;
	$('.result_container').hide();
	//alert(site+": "+q);
	$.ajax({
		url: 'GetAnswer',
		type: 'GET',
		dataType: 'json',
		data: {
			question_id: question_id,
			site: site,
			sort: sort
	    },
	})
	.done(function(data) {
		$('#loading_item').hide();//remove loading item
		$('.result_container').show();
		console.log("success");
		itemsArr = data.items;
		question=data.question;
		
	
	//	$(' #qscore').html(question.score);
		$('#qchinesetitle').html(question.chinesetitle);
		$('#qtitle').html(question.title);
		$('#qbody').html(question.body); 
		//$('#qlink').attr('href',question.link);
		
		
		//alert(itemsArr[0].title);
		
		// .tags: <span class="badge">JAVA</span>
		// #scoreId: 分数
		
		// if answered:
		// 	Is Answered
		// 	<span class="glyphicon glyphicon-ok"></span>
		// Not answered:
		// 	Not Answered
		// 	<span class="glyphicon glyphicon-remove"></span>
		
		// #ctId: 中文title
		// #etId: 英文title
		// #btId: body
		// #linkId: href="link"
		// #showAnswerId  的questionId="question_id"  看答案
		var trid=0;
		if(itemsArr.length!=0){
			for(var i=0; i< itemsArr.length; i++){
				var itemContent = ' <tr id=tid'+i+'> <td class="x-item"> <div class="row"> <div class="tag_line"> <div class="tags"> <b>回答: </b> </div> <div class="score" style="display:inline"> 分数: <b id=score'+i+'></b> ,&nbsp; <div class="answer_status" id=ans'+i+'></div> ,&nbsp;<a href="" id=linkId'+i+'>原链接</a>&nbsp;<a id="showAnswerId" questionId=""></a></div> </div> </div> <div class="row"> <table class="inner_table"> <tbody> <tr> <th width="50%">译文</th> <th width="50%">原文</th> </tr> <tr> <td width="50%" class="ctId" id=ctid'+i+'></td>  <td width="50%" class="btId" id=btid'+i+'></td> </tr> <tr> <td></td>  <td id="actions">  </td> </tr> </tbody> </table> </div> </td> </tr>';

				if(itemsArr[i].is_accepted==true){
					
					$('.table>tbody').prepend(itemContent);
					$('#ctid'+i).html(itemsArr[i].chineseBody);
					$('#btid'+i).html(itemsArr[i].body); 
					$('#score'+i).html(itemsArr[i].score); 
				    $('#ans'+i).html('已采纳 <span class="glyphicon glyphicon-ok"></span>').css('background-color', 'rgb(9, 211, 9)');
				    $('#linkId'+i).attr('href',itemsArr[i].link);

				}else{
			
					$('.table>tbody').append(itemContent);
					$('#ctid'+i).html(itemsArr[i].chineseBody);
					$('#btid'+i).html(itemsArr[i].body); 
					$('#score'+i).html(itemsArr[i].score); 
				    $('#linkId'+i).attr('href',itemsArr[i].link);
					$('#ans'+i).html('未采纳 <span class="glyphicon glyphicon-remove"></span>').css('background-color', 'red');

					
				}					
				
			}//end of for
		}else{
			//find nothing
			$('.table>tbody').append('<tr><td><img src="images/not_found.jpeg"><td></tr>');
		}
		
		//open translate Helper
		$("#TranslateDialog").dialog({
	        autoOpen: false, 
	        hide: "slide",
	        show : "slide",
	        height: 400,
	        width: 400,
	        draggable: true,
	        position: {
	            my: "left center",
	            at: "left center"
	         }
	     });
	     $('.bodytrans').click(function() {
	    	 //when user click translate button besides "Content"
	    	($("#TranslateDialog").dialog("isOpen") == false) ? $("#TranslateDialog").dialog("open") : $("#TranslateDialog").dialog("close");
	    	$('#TranslateDialog').html('<h3><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>Translating...</h3>');
	    	var contentText = $(this).parent().parent().parent().find('.btId').html();
         	//$('#TranslateDialog').html(contentText);
         	$.ajax({
               	url: 'GetTranslated',
               	type: 'GET',
               	dataType: 'json',
               	data: {englishText: contentText},
               })
               .done(function(data) {
               		console.log("translate success");
               		$('#TranslateDialog').html(data.translatedText);        
               })
               .fail(function() {
            		alert("error in translating context");
               		console.log("error");
               });
	     });
	     
	     
	     
	     $('#activity').click(function() {	     
	    
	     		window.location='testanswer.jsp?qid='+question_id+'&site='+site+'&sort=activity'; // go to result.jsp
	     });  
	     
	     $('#creation').click(function() {	     
		    	
		     		window.location='testanswer.jsp?qid='+question_id+'&site='+site+'&sort=creation'; // go to result.jsp
		     });  
	     
	     $('#votes').click(function() {	     
		    	
		     		window.location='testanswer.jsp?qid='+question_id+'&site='+site+'&sort=votes'; // go to result.jsp
		     }); 
	     
	     
	     
	     
	})//end of .done
	.fail(function() {
		console.log("error");
	});
	
	

</script>
</body>
</html>