<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	
	String inputText = new String(request.getParameter("q").getBytes("ISO-8859-1"),"UTF-8");
	String inputSite = request.getParameter("site");
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
		<div class="div-ads" style="margin-top: -15px;"></div>
		<h4 id="question">Haoda Zou</h4>
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
			window.location='result.jsp?q='+inputText+'&site='+site;
			
		}else{
			//if it is empty, do nothing
			$('.x-kw').focus();
		}
		return false;
	});
	

	var site = "<%=inputSite%>";
	var q = "<%=inputText%>";
	var inputEnglish;
	var itemsArr = [];
	$('.result_container').hide();
	//alert(site+": "+q);
	$.ajax({
		url: 'GetResults',
		type: 'GET',
		dataType: 'json',
		data: {
			inputChinese: q,
			site: site
	    },
	})
	.done(function(data) {
		$('#loading_item').hide();//remove loading item
		$('.result_container').show();
		console.log("success");
		$('#question').html('Question: '+data.inputEnglish+'('+q+') From '+site);
		//alert(inputEnglish);
		itemsArr = data.items;
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
		if(itemsArr.length!=0){
			for(var i=0; i< itemsArr.length; i++){
				var itemContent = ' <tr> <td class="x-item"> <div class="row"> <div class="tag_line"> <div class="tags"> <b>Tags: </b> </div> <div class="score"> Score: <div id="scoreId"></div> ,&nbsp; <div class="answer_status"></div> ,&nbsp;<a href="" id="linkId">Link</a>,&nbsp;<a id="showAnswerId" questionId="">Show Answers</a></div> </div> </div> <div class="row"> <table class="inner_table"> <tbody> <tr> <th width="20%">Chinese Title</th> <th width="20%">English Title</th> <th width="60%">Content(<a class="bodytrans">translate</a>)</th> </tr> <tr> <td width="20%" class="ctId"></td> <td width="20%" class="etId"></td> <td width="60%" class="btId"></td> </tr> <tr> <td></td> <td></td> <td id="actions">  </td> </tr> </tbody> </table> </div> </td> </tr>';
				//add item frame
				var tagsArr = itemsArr[i].tags;
				$('.table>tbody').append(itemContent);
				console.log(itemsArr[i].score);
				$('.table>tbody>tr:eq('+i+') #scoreId').html(itemsArr[i].score);
				$('.table>tbody>tr:eq('+i+') .ctId').html(itemsArr[i].chinesetitle);
				$('.table>tbody>tr:eq('+i+') .etId').html(itemsArr[i].title);
				$('.table>tbody>tr:eq('+i+') .btId').html(itemsArr[i].body); 
				$('.table>tbody>tr:eq('+i+') #linkId').attr('href',itemsArr[i].link);
				$('.table>tbody>tr:eq('+i+') #showAnswerId').attr('questionId',itemsArr[i].question_id);
				if(itemsArr[i].is_answered==true){
					$('.table>tbody>tr:eq('+i+') .answer_status').html('Is Answered <span class="glyphicon glyphicon-ok"></span>').css('background-color', 'rgb(9, 211, 9)');
					
				}else{
					$('.table>tbody>tr:eq('+i+') .answer_status').html('Not Answered <span class="glyphicon glyphicon-remove"></span>').css('background-color', 'red');
				}
				
				for(var j=0;j<tagsArr.length;j++){	
					$('.table>tbody>tr:eq('+i+') .tags').append('<span class="badge">'+tagsArr[j]+'</span>');
				}
				
			}
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
	})//end of .done
	.fail(function() {
		console.log("error");
	});
	
	

</script>
</body>
</html>