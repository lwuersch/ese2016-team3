<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<c:import url="template/header.jsp" />

<ol class="breadcrumb">
	<li><a href="./">Home</a></li>
	<li class="active">Login</li>
</ol>

<div class="row">
	<div class="col-md-12 col-xs-12">
		<h3>Login</h3>
		<form:form id="login-form" class="form-horizontal" method="post"
			action="/j_spring_security_check">
			<div class="panel panel-default">
				<div class="panel-body">
					<c:choose>
						<c:when test="${loggedIn}">
							<p>You are already logged in!</p>
						</c:when>
						<c:otherwise>
							<c:if test="${!empty param.error}">
								<p>Incorrect email or password. Please retry using correct
									email and password.</p>
								<br />
							</c:if>
							<div class="form-group ${status.error ? 'has-error' : '' }">
								<label class="col-sm-2 control-label" for="field-email">Email:</label>
								<div class="col-sm-6">
									<input name="j_username" id="field-email" class="form-control" />
								</div>
							</div>
							<div class="form-group ${status.error ? 'has-error' : '' }">
								<label class="col-sm-2 control-label" for="field-password">Password:</label>
								<div class="col-sm-6">
									<input name="j_password" id="field-password" type="password"
										class="form-control" />
								</div>
							</div>
							<br />
		
			Or <a class="link" href="<c:url value="./signup" />">sign up</a> as a new user.
		
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			<div class="form-group pull-right">
				<div class="col-sm-12">
					<a href="./" class="btn btn-default">Cancel</a>
					<button type="submit" class="btn btn-primary">Login</button>
				</div>
			</div>
		</form:form>
	</div>
</div>	
		<ul class="test-users">
			<li>Email: <i>ese@unibe.ch</i>, password: <i>ese</i></li>
			<li>Email: <i>jane@doe.com</i>, password: <i>password</i></li>
			<li>Email: <i>user@bern.com</i>, password: <i>password</i></li>
			<li>Email: <i>oprah@winfrey.com</i>, password: <i>password</i></li>
		</ul>


<c:import url="template/footer.jsp" />