<%-- 
    Document   : login
    Created on : Feb 19, 2020, 9:58:40 PM
    Author     : Senior Steps
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="login" method="POST">
			<table>
				<tr>
					<th>Username</th>
					<td>
						<input type="text" name='username' />
					</td>
				</tr>
				<tr>
					<th>Password</th>
					<td>
						<input type="password" name='password' />
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type='submit' name='button' value="Login" />
					</th>
				</tr>
			</table>
		</form>
    </body>
</html>
