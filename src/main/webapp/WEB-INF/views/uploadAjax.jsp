<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.css">    
<script src="<c:url value="/resources/js/jquery-3.3.1.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>    
<!DOCTYPE html>
<html>
<head>
<style>
	.fileDrop{
		width: 100%;
		height: 200px;
		border: 1px dotted blue;
	}
	small{
		margin-left: 3px;
		font-weight: bold;
		color: gray;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>
	
	
	

<script type="text/javascript">
	
	$(document).ready(function(){
		function checkImageType(fileName){
			var pattern = /jpg$|gif$|png$|jpeg$/i;
			
			return fileName.match(pattern);
			
		}
		function getOriginalName(fileName){
			if(checkImageType(fileName)){
				console.log("이미지 파일 임")
				return ;
			}
			
			let idx =fileName.indexOf("_")+1;
			return fileName.substr(idx);
		}
		function getImageLink(fileName){
			if(!checkImageType(fileName)){
				return;
			}
			let front = fileName.substr(0,12);
			let end = fileName.substr(14);
			
			return front+end;
		}
		
	
		$(".fileDrop").on("dragenter dragover",function(event){
			event.preventDefault();
		})
		$(".fileDrop").on("drop",function(event){
			event.preventDefault();
			
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0]
			var formData = new FormData();
			
			formData.append("file",file);
			
			$.ajax({
				url:'/uploadAjax',
				data: formData,
				dataType:'text',
				processData: false,
				contentType: false,
				type: 'POST',
				success:function(data){
					let str="";
					
					if(checkImageType(data)){
						str="<div>"+
							"<a href='displayFile?fileName="+getImageLink(data)+"'>"+
							"<img src='displayFile?fileName="+data+"'/>"+
							"</a><small data-src="+data+">X</small></div>";
					}else{
						str="<div><a href='displayFile?fileName="+data+"'>"+
							getOriginalName(data)+"</a>"+
							"</div>";
					
					}
				$(".uploadedList").append(str);
				}
			})
		})
		
		$(".uploadedList").on('click','small',function(event){
			var that =$(this);
			
			$.ajax({
				url:"deleteFile",
				type:"post",
				data:{fileName:$(this).attr("data-src")},
				dataType:"text",
				success:function(result){
					if(result == 'deleted'){
						that.parent("div").remove();
					}
				}
			})
		})
	})
		
	</script>
	
</body>
</html>