<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store");
	response.setDateHeader("Expires", -1);
%> 

<!doctype html>
<html>
<head>
<title>Spring Boot AJAX jQuery CRUD</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- jQuery Modal -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
	
<style>
.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}


input[type=submit] {
	background-color: #1E90FF;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #4169E1;
}

.modal p {
	margin: 1em 0;
}

.add_form.modal {
	border-radius: 0;
	line-height: 18px;
	padding: 0;
	font-family: "Lucida Grande", Verdana, sans-serif;
}

.add_form.modal p {
	padding: 20px 30px;
	border-bottom: 1px solid #ddd;
	margin: 0;
	background: -webkit-gradient(linear, left bottom, left top, color-stop(0, #eee),
		color-stop(1, #fff));
	overflow: hidden;
}

.add_form.modal p:last-child {
	border: none;
}

.add_form.modal p label {
	float: left;
	font-weight: bold;
	color: #333;
	font-size: 13px;
	width: 110px;
	line-height: 22px;
}

.add_form.modal p input[type="text"], .add_form.modal p input[type="submit"]
	{
	font: normal 12px/18px "Lucida Grande", Verdana;
	padding: 3px;
	border: 1px solid #ddd;
	width: 200px;
}

#msg {
	margin: 10px;
	padding: 30px;
	color: #fff;
	font-size: 18px;
	font-weight: bold;
	background: -moz-linear-gradient(top, #2e5764, #1e3d47);
	background: -webkit-gradient(linear, left bottom, left top, color-stop(0, #1e3d47),
		color-stop(1, #2e5764));
}
</style>
</head>
<body>
    <div align="right">
  
	  <form action="SignOut">
		Hi
		<c:out value="${uId}"/>
		<input type="submit" value="SignOut" />
	  </form>
	</div> 
     
    <div align="center" class="container">
    
      <h2>List Of Books</h2>
	  <p>
		<a class='btn' href="#add" rel="modal:open">Add New Book</a>
	  </p>
     
	  <table border="1" cellspacing="0" cellpadding="5">
		<tr>
			<th>Book Id</th>
			<th>Book Name</th>
			<th>Book Author</th>
			<th>Data Added</th> 
			<th>Actions</th>

		</tr>
	  </table>
    </div>
    
    
	<form id="add" action="#" class="add_form modal" style="display: none;">
		<div id='msg' />
		<h3>Add a New Book</h3>
		<p>
			<label>Book Name</label> <input type="text" id="name" name="name">
		</p>
		<p>
			<label>Book Author</label> <input type="text" id="author"
				name="author">
		</p>
		<p>
			<label>Author Id</label> <input type="text" id="authorId"
				name="authorId">
			<label>Author Name</label> <input type="text" id="authorName"
				name="authorName">
		</p>
		<p>
			<input type="submit" id="addNew" value="Submit">
		</p>
	</form>
	
	
	<script type="text/javascript">
	
	   function getBook(){
		  $.ajax({
				type : "GET",
				contentType : "application/json; charset=utf-8",
				url : "http://localhost:8083/book/v1",
				cache : false,
				success : function(data) {
					console.log(data);
					var tr=[];
					for (var i = 0; i < data.length; i++) {
						tr.push('<tr>');
						tr.push('<td>' + data[i].bookId + '</td>');
						tr.push('<td>' + data[i].bookName + '</td>');
						tr.push('<td>' + data[i].bookAuthor + '</td>');
						tr.push('<td>' + data[i].date + '</td>'); 
						tr.push('<td><button class=\'edit\'>Edit</button>&nbsp;&nbsp;<button class=\'delete\' id=' + data[i].bookId + '>Delete</button></td>');
						tr.push('</tr>');
					}
					$('table').append($(tr.join('')));
				},
				error : function() {
					$('#err')
							.html('<span style=\'color:red; font-weight: bold; font-size: 30px;\'>Error updating record')
							.fadeIn()
							.fadeOut(4000, function() {
								$(this).remove();
							});
				}
			});
	   }
	
	   function postBook(){
		   $(document).delegate('#addNew', 'click', function(event) {
				event.preventDefault();
			/* var name = $('#name').val();*/
		    var formData={
					 bookName : $('#name').val(),
					 bookAuthor : $('#author').val(),
					 author:{
					  authorId: $('#authorId').val(),
					  authorName: $('#authorName').val() 
					 }
			}   
			
			$.ajax({
				type: "POST",
				contentType: "application/json; charset=utf-8",
				url: "http://localhost:8083/book/v1",
				/* data: JSON.stringify({'bookName': name})*/
				data: JSON.stringify(formData), 
				cache: false,
				success: function(result) {
					$("#msg").html( "<span style='color: green'>Book added successfully</span>" );
					window.setTimeout(function(){location.reload()},1000)
				},
				error: function(err) {
					$("#msg").html( "<span style='color: red'>Name is required</span>" );
				}
			});
		   });	
	   }
	   
	   function deleteBook(){
		   $(document).delegate('.delete', 'click', function() { 	
		      if (confirm('Do you really want to delete record?')) {
				var id = $(this).attr('id');
				var parent = $(this).parent().parent();
				$.ajax({
					type: "DELETE",
					url: "http://localhost:8083/book/v1/" + id,
					cache: false,
					success: function() {
						parent.fadeOut('slow', function() {
							$(this).remove();
						});
						location.reload(true)
					},
					error: function() {
						$('#err').html('<span style=\'color:red; font-weight: bold; font-size: 30px;\'>Error deleting record').fadeIn().fadeOut(4000, function() {
							$(this).remove();
						});
					}
				});
			 }
		   });
	   }
	   
	   function editBook(){
		 $(document).delegate('.edit', 'click', function() {
		   var parent = $(this).parent().parent();
			
			var id = parent.children("td:nth-child(1)");
			var name = parent.children("td:nth-child(2)");
			var author = parent.children("td:nth-child(3)");
			var date = parent.children("td:nth-child(4)");
			var buttons = parent.children("td:nth-child(5)");
			
			name.html("<input type='text' id='txtName' value='" + name.html() + "'/>");
			author.html("<input type='text' id='txtAuthor' value='" + author.html() + "'/>");
			buttons.html("<button id='save'>Save</button>&nbsp;&nbsp;<button class='delete' id='" + id.html() + "'>Delete</button>");
		 });
	   }
	   
	   function saveBook(){ 
		 $(document).delegate('#save', 'click', function() {

		   var parent = $(this).parent().parent();
			
			var bookId = parent.children("td:nth-child(1)");
			var bookName = parent.children("td:nth-child(2)");
			var bookAuthor = parent.children("td:nth-child(3)");
			var date = parent.children("td:nth-child(4)");
			var buttons = parent.children("td:nth-child(5)");
			console.log(bookId);
			
			$.ajax({
				type: "PUT",
				contentType: "application/json; charset=utf-8",
				url: "http://localhost:8083/book/v1/"+bookId.html(),
				data: JSON.stringify({'bookId' : bookId.html(), 'bookName' : bookName.children("input[type=text]").val(), 'bookAuthor': bookAuthor.children("input[type=text]").val(),'date' : date.html()}),
				cache: false,
				success: function() {
					bookName.html(bookName.children("input[type=text]").val());
					bookAuthor.html(bookAuthor.children("input[type=text]").val());
					buttons.html("<button class='edit' id='" + bookId.html() + "'>Edit</button>&nbsp;&nbsp;<button class='delete' id='" + bookId.html() + "'>Delete</button>");
				},
				error: function() {
					$('#err').html('<span style=\'color:red; font-weight: bold; font-size: 30px;\'>Error updating record').fadeIn().fadeOut(4000, function() {
						$(this).remove();
					});
				}
			});
			
		  });
	   }
	   
	   $(document).ready(function() {
		   
				getBook();
							
				postBook();
							
				deleteBook();
							
				editBook();
							
				saveBook();

	   }); 
	</script>

</body>

</html>