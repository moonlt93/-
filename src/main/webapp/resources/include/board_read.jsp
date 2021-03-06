<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	var root = '${root}'
</script>
<meta charset="UTF-8">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script type="text/javascript" src="${root }/resources/js/board_reply.js"></script>


<script type="text/javascript">
	$(document).ready(function(e){
		
		var operForm = $("#operForm");
		$("button[data-oper='list']").click(function(e){
			
			operForm.attr("action", root + "/board/list");
			
			operForm.submit();
		});

		
		$("button[data-oper='modify']").click(function(e){
			operForm.append("<input type='hidden' name='board_bno' value='"+${boardVO.board_bno}+"'>");
			operForm.attr("action", root + "/board/modify");
			
			operForm.submit();
		});
		
		
		$("button[data-oper='delete']").click(function(e){
			operForm.append("<input type='hidden' name='board_bno' value='"+${boardVO.board_bno}+"'>");
			operForm.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token }'>");
		
			operForm.attr("method", "post");
			operForm.attr("action", root + "/board/delete");
			
			operForm.submit();
		});
		
		
		
		
		
		
		
	});
</script>
<title>Insert title here</title>
</head>
<body>
<div class="container-sm">
		<div class="row justify-content-center">
			<div class="col-lg-12">
				<h1>게시물 보기</h1>
			</div>
		</div>	
			
		<div class="row justify-content-center">
			<div class="col-lg-12">	
		

			<div class="form-group">
						<label for="input3">번호</label>
						<input class="form-control" type="text" id="input3" readonly value="${boardVO.board_bno }" />
			</div>
					
			<div class="form-group">
				<label for="input1">제목</label> <input readonly value='<c:out value="${boardVO.board_title}" />' type="text"
							class="form-control" id="input1" >
			</div>

			<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea readonly class="form-control" id="textarea1"
							rows="3"><c:out value="${boardVO.board_content}" /></textarea>
			</div>

			<div class="form-group">
					<label for="input2">작성자</label> <input readonly 
						  value='<c:out value="${boardVO.board_id }" />' type="text"
					class="form-control" id="input2" >
			</div>
				
			<div class="form-group">
					<label for="input1">조회수</label> <input readonly 
					    value='<c:out value="${boardVO.board_read_cnt }" />' type="text"
						class="form-control" id="input1" >
			</div>
			</div>
			
		</div>
		
			
		
		
		<c:choose>		
			<c:when test="${boardVO.board_bno eq 1 }">
				<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')" >
					<div class="btn-group ">
  					<button data-oper="modify" type="button" class="btn btn-secondary">수정하기</button>
  					<button data-oper="delete" type="button" class="btn btn-light">삭제하기</button>
					</div>
				</sec:authorize>
				<div class="btn-group ">
					<button data-oper="list" type="button" class="btn btn-secondary">목록으로</button>
				</div>
			</c:when>
			
			<c:otherwise>
				<div class="btn-group ">
  					<button data-oper="modify" type="button" class="btn btn-secondary">수정하기</button>
  					<button data-oper="delete" type="button" class="btn btn-light">삭제하기</button>
  					<button data-oper="list" type="button" class="btn btn-secondary">목록으로</button>
				</div>	
			</c:otherwise>
		</c:choose>		
</div>

<!-- 댓글목록 -->
<div class="container-sm my-3">
		<div class="row" style="margin-left: 5px;">
			<div class="col-12">
				<div class="card">
				
					<div class="card-header d-flex justify-content-between align-items-center">
						<span>댓글 목록</span>
						<sec:authorize access="isAuthenticated()">
						<button class="btn btn-info" id="new-reply-btn">댓글 쓰기</button>
						</sec:authorize>
					</div>
					
					<div class="card-body">
						<ul class="list-unstyled" id="reply-ul">
							
						</ul>
						
					</div>
				</div>
			
			</div>
		</div>
	</div>




<div class="d-none">
	<form id="operForm" action="/board/list" method="get">
		<input type="hidden" name="pageNum" value="${board_Criteria.pageNum }">
		<input type="hidden" name="amount" value="${board_Criteria.amount }">
		<input type="hidden" name="type" value="${board_Criteria.type }">
		<input type="hidden" name="keyword" value="${board_Criteria.keyword }">
		<input type="hidden" name="day" value="${board_Criteria.day }">
		
		<input type="submit"/>
	</form>

</div>



</body>
</html>