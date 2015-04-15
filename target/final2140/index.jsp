<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Chinese-StackExchange</title>
	<meta author="Haoda Zou">
	<meta e-mail="haz51@pitt.edu">
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/stackexchange.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="shortcut icon" type="image/x-icon" href="http://www.shousibaocai.com/static/favicon.ico">
	<!-- script -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<a class="navbar-brand" href="index.html">Chinese-StackExchange</a>
		</div>
	
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse navbar-ex1-collapse">
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
	
	<!-- index page -->
	<form class="x-form">
		<div class="container">
			<div class="div-search-box col-lg-offset-3 col-lg-6">
				<div class="logo">
					<img src="http://www.shousibaocai.com/static/ssbc.png" alt="search logo here">
				</div>

				<div class="input-group">
					<input placeholder="What do you want to ask?" autocomplete="off" type="text" class="form-control x-kw" name="s">
					<span class="input-group-btn">
						<button class="btn btn-default" type="submit">
						<span class="glyphicon glyphicon-search"></span> Search
						</button>
					</span>
				</div>
				<!-- images -->
				<br>
				<div class="well">
					<div class="row">
						<div class="col-xs-4 well-block">
							<img src="images/stackoverflow-img.png" class="img-responsive img-radio" style="opacity: 1;" >
        					<button type="button" class="btn btn-primary btn-radio active" name="stackoverflow">StackOverflow</button>
        					<input type="checkbox" id="left-item" class="hidden">
						</div>
						<div class="col-xs-4 well-block">
							<img src="images/serverfault-img.png" class="img-responsive img-radio">
        					<button type="button" class="btn btn-primary btn-radio" name="serverfault">ServerFault</button>
        					<input type="checkbox" id="left-item" class="hidden">
						</div>
						<div class="col-xs-4 well-block">
							<img src="images/askubuntu-img.jpg" class="img-responsive img-radio">
        					<button type="button" class="btn btn-primary btn-radio" name="askubuntu">AskUbuntu</button>
        					<input type="checkbox" id="left-item" class="hidden">
						</div>
					</div>
				</div>
			</div> 
		</div>
	</form>




<script>
	//This is for images to select in index
	$('.x-kw').focus();
	var site="stackoverflow";
	var inputText="";
    $('.btn-radio').click(function(e) {
    	//alert($(this).attr("name"));
    	site=$(this).attr('name');
        $('.btn-radio').not(this).removeClass('active')
    		.siblings('input').prop('checked',false)
            .siblings('.img-radio').css('opacity','0.1');
    	$(this).addClass('active')
            .siblings('input').prop('checked',true)
    		.siblings('.img-radio').css('opacity','1');
    });

    $('.x-form').submit(function(event) {
    	event.preventDefault();
    	/* Act on the event */
    	inputText=$('.x-kw'