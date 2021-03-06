<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<c:import url="template/header.jsp" />

<script src="/js/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>

<script src="/js/pictureUpload.js"></script>

<script>
	$(document)
			.ready(
					function() {

						// Go to controller take what you need from user
						// save it to a hidden field
						// iterate through it
						// if there is id == x then make "Bookmark Me" to "bookmarked"

						$("#field-city").autocomplete({
							minLength : 2,
							source : <c:import url="getzipcodes.jsp" />,
							enabled : true,
							autoFocus : true
						});
						$("#field-moveInDate").datepicker({
							dateFormat : 'dd-mm-yy'
						});

						$("#field-endDate").datepicker({
							dateFormat : 'dd-mm-yy'
						});

						$("#field-visitDay").datepicker({
							dateFormat : 'dd-mm-yy'
						});

						$("#addVisitButton")
								.click(
										function() {
											var date = $("#field-visitDay")
													.val();
											if (date == "") {
												return;
											}

											var startHour = $("#startHour")
													.val();
											var startMinutes = $(
													"#startMinutes").val();
											var endHour = $("#endHour").val();
											var endMinutes = $("#endMinutes")
													.val();

											if (startHour > endHour) {
												alert("Invalid times. The visit can't end before being started.");
												return;
											} else if (startHour == endHour
													&& startMinutes >= endMinutes) {
												alert("Invalid times. The visit can't end before being started.");
												return;
											}

											var newVisit = date + ";"
													+ startHour + ":"
													+ startMinutes + ";"
													+ endHour + ":"
													+ endMinutes;
											var newVisitLabel = date + " "
													+ startHour + ":"
													+ startMinutes + " to "
													+ endHour + ":"
													+ endMinutes;

											var index = $("#addedVisits input").length;

											var label = "<p>" + newVisitLabel
													+ "</p>";
											var input = "<input type='hidden' value='" + newVisit + "' name='visits[" + index + "]' />";

											$("#addedVisits").append(
													label + input);
										});
					});
</script>


<ol class="breadcrumb">
	<li><a href="/${pagemode}/">Homepage</a></li>
	<li class="active">Place ad</li>
</ol>


<div class="row">
	<div class="col-md-12 col-xs-12">

		<h3>Place an ad</h3>
		<div class="row">
			<div class="col-md-12">
				<form:form method="post" modelAttribute="placeAdForm"
					action="./placeAd" id="placeAdForm" autocomplete="off"
					cssClass="form form-horizontal">
					<h4>General information</h4>

					<div class="panel panel-default">
						<div class="panel-body">

							<spring:bind path="title">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-title">Ad
										Title</label>
									<div class="col-sm-5">
										<form:input type="text" id="field-title" path="title"
											cssClass="form-control" placeholder="Title" />
										<form:errors path="title" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="type">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="type-room">Type</label>
									<div class="col-sm-5">
										<form:select path="type" id="type" cssClass="form-control">
											<form:options items="${types}" itemLabel="name" />
										</form:select>
									</div>
								</div>
							</spring:bind>

							<spring:bind path="street">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-street">Street</label>
									<div class="col-sm-5">
										<form:input type="text" id="field-street" path="street"
											cssClass="form-control" placeholder="Street" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="city">
								<div class="form-group ${status.error ? 'has-error' : '' }">

									<label class="col-sm-3 control-label" for="field-city">City
										/ zip code</label>
									<div class="col-sm-5">
										<form:input type="text" name="city" id="field-city"
											path="city" placeholder="City" cssClass="form-control" />
										<form:errors path="city" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="moveInDate">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="moveInDate">Move-in
										date</label>
									<div class="col-sm-5">
										<form:input type="text" id="field-moveInDate"
											path="moveInDate" cssClass="form-control" />
										<form:errors path="moveInDate" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-body">
							<spring:bind path="squareFootage">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-SquareFootage">Square
										Meters</label>
									<div class="col-sm-5">
										<form:input id="field-SquareFootage" type="number" min="0"
											path="squareFootage" placeholder="Square footage" step="5"
											cssClass="form-control" />
										<form:errors path="squareFootage" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="numberOfRooms">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-NumberOfRooms">Number
										of rooms</label>
									<div class="col-sm-5">
										<form:input id="field-NumberOfRooms" type="number" min="0"
											path="numberOfRooms" placeholder="numberOfRooms" step="1"
											cssClass="form-control" />
										<form:errors path="numberOfRooms" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="floorLevel">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-FloorLevel">Floor
										level </label>
									<div class="col-sm-5">
										<form:input id="field-Floor" type="number" min="0"
											path="floorLevel" placeholder="0" step="1"
											cssClass="form-control" />
										<form:errors path="floorLevel" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="distanceSchool">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label"
										for="field-DistanceSchool">Distance to school</label>
									<div class="col-sm-5">
										<form:select id="field-DistanceSchool" path="distanceSchool"
											cssClass="form-control">
											<option value="0"></option>
											<form:options items="${distances}" itemLabel="name"
												itemValue="distance" />
										</form:select>
										<form:errors path="distanceSchool" cssClass="text-danger" />

									</div>
								</div>
							</spring:bind>

							<spring:bind path="distanceShopping">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label"
										for="field-DistanceShopping">Distance to shopping
										center</label>
									<div class="col-sm-5">
										<form:select id="field-DistanceShopping"
											path="distanceShopping" cssClass="form-control">
											<option value="0"></option>
											<form:options items="${distances}" itemLabel="name"
												itemValue="distance" />
										</form:select>
										<form:errors path="distanceShopping" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="distancePublicTransport">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label"
										for="field-DistancePublicTransport">Distance to public
										transport</label>
									<div class="col-sm-5">
										<form:select id="field-DistancePublicTransport"
											path="distancePublicTransport" cssClass="form-control">
											<option value="0"></option>
											<form:options items="${distances}" itemLabel="name"
												itemValue="distance" />
										</form:select>
										<form:errors path="distancePublicTransport"
											cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="buildYear">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-BuildYear">Year
										of construction</label>
									<div class="col-sm-5">
										<form:input id="field-BuildYear" path="buildYear" min="0"
											cssClass="form-control" />
										<form:errors path="buildYear" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>
							<spring:bind path="renovationYear">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label"
										for="field-RenovationYear">Year of renovation </label>
									<div class="col-sm-5">
										<form:input id="field-RenovationYear" path="renovationYear"
											min="0" cssClass="form-control" />
										<form:errors path="renovationYear" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>


							<%-- 			<spring:bind path="prize">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-Prize">Prize
										per month</label>
									<div class="col-sm-5">
										<form:input id="field-Prize" type="number" min="0"
											path="prize" placeholder="Prize per month" step="50"
											cssClass="form-control" />
										<form:errors path="prize" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>   --%>
						</div>
					</div>
					<h4>Prizing</h4>
					<div class="panel panel-default">
						<div class="panel-body">

							<spring:bind path="prize">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-Prize">Normal
										Buy Prize(without Auction) </label>
									<div class="col-sm-5">
										<form:input id="field-Prize" type="number" min="0"
											path="prize" placeholder="Prize " step="50"
											cssClass="form-control" />
										<form:errors path="prize" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<div class="form-group">

								<label class="col-sm-3 control-label">Auction</label>
								<div class="col-sm-offset-3 col-sm-10">
									<div class="checkbox">
										<label> <form:checkbox id="field-auction"
												path="auction" value="1" /> Yes
										</label>
									</div>
								</div>
							</div>

							<spring:bind path="buyItNowPrice">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-BuyNowPrize">Immediate
										Buy Price for Auction </label>
									<div class="col-sm-5">
										<form:input id="field-BuyNowPrize" type="number" min="0"
											path="buyItNowPrice" placeholder="Prize " step="50"
											cssClass="form-control" />
										<form:errors path="buyItNowPrice" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="startDate">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-startDate">Startdate
										for Auction </label>
									<div class="col-sm-5">
										<form:input type="datetime-local" value="2016-08-19T13:45:00"
											id="field-startDate" path="startDate" cssClass="form-control" />

									</div>

								</div>
							</spring:bind>

							<spring:bind path="endDate">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-endDate">Enddate
										for Auction </label>
									<div class="col-sm-5">
										<form:input type="text" id="field-endDate" path="endDate"
											cssClass="form-control" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="startPrice">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-startPrice">Startprice
										for Auction </label>
									<div class="col-sm-5">
										<form:input id="field-startPrice" path="startPrice"
											type="number" min="0" placeholder="Startprice " step="1"
											cssClass="form-control" />
										<form:errors path="startPrice" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>

							<spring:bind path="increaseBidPrice">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-increasePrice">Amount
										of increase of bid price </label>
									<div class="col-sm-5">
										<form:input id="field-increasePrice" path="increaseBidPrice"
											type="number" min="0" placeholder="Startprice " step="1"
											cssClass="form-control" />
										<form:errors path="increaseBidPrice" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>
						</div>
					</div>
					<h4>Description</h4>
					<div class="panel panel-default">
						<div class="panel-body">

							<spring:bind path="numberOfBath">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label" for="field-NumberOfBath">Number
										of baths</label>
									<div class="col-sm-5">
										<form:input id="field-NumberOfBath" type="number" min="0"
											path="numberOfBath" placeholder="Number of baths" step="1"
											cssClass="form-control" />
										<form:errors path="numberOfBath" cssClass="text-danger" />
									</div>
								</div>
							</spring:bind>
							<spring:bind path="infrastructureType">
								<div class="form-group ${status.error ? 'has-error' : '' }">
									<label class="col-sm-3 control-label"
										for="infrastructureType-room">InfrastructureType</label>
									<div class="col-sm-5">
										<form:select id="infrastructureType" path="infrastructureType"
											cssClass="form-control">
											<form:options items="${infrastructureTypes}" itemLabel="name" />
										</form:select>
									</div>
								</div>
							</spring:bind>





							<div class="checkbox">

								<label class="col-sm-3 control-label">Garage</label>
								<div class="col-sm-5">
									<form:checkbox id="field-garage" path="garage" value="1" />
								</div>


							</div>
							<div class="checkbox">
								<label class="col-sm-3 control-label">Parking</label>
								<div class="col-sm-5">
									<form:checkbox id="field-parking" path="parking" value="1" />

								</div>
							</div>

							<div class="checkbox">
								<label class="col-sm-3 control-label">Balcony or Patio</label>
								<div class="col-sm-5">
									<form:checkbox id="field-balcony" path="balcony" value="1" />
								</div>
							</div>
							<div class="checkbox">
								<label class="col-sm-3 control-label">Elevator </label>
								<div class="col-sm-5">
									<form:checkbox id="field-elevator" path="elevator" value="1" />
								</div>
							</div>
							<div class="checkbox">
								<label class="col-sm-3 control-label">Dishwasher</label>
								<div class="col-sm-5">
									<form:checkbox id="field-dishwasher" path="dishwasher"
										value="1" />
								</div>
							</div>
						</div>

						<br />

						<spring:bind path="roomDescription">
							<div class="form-group ${status.error ? 'has-error' : '' }">
								<label class="col-sm-3 control-label" for="roomDescription">Room
									Description:</label>
								<div class="col-sm-5">
									<form:textarea path="roomDescription" rows="10" cols="70"
										placeholder="Room Description" class="form-control" />
									<form:errors path="roomDescription" cssClass="text-danger" />
								</div>
							</div>
						</spring:bind>
					</div>
				</form:form>
			</div>

			<h4>Visiting times (optional)</h4>
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row form-inline bottom15">
						<div class="col-sm-3">
							<label>Day</label> <input type="text" id="field-visitDay"
								class="form-control">
						</div>
						<div class="col-sm-9">
							<label>Time</label> <select id="startHour" class="form-control">

								<%
									for (int i = 0; i < 24; i++) {
										String hour = String.format("%02d", i);
										out.print("<option value=\"" + hour + "\">" + hour + "</option>");
									}
								%>
							</select> <select id="startMinutes" class="form-control">
								<%
									for (int i = 0; i < 60; i++) {
										String minute = String.format("%02d", i);
										out.print("<option value=\"" + minute + "\">" + minute + "</option>");
									}
								%>
							</select> <span>to&thinsp; </span> <select id="endHour"
								class="form-control">
								<%
									for (int i = 0; i < 24; i++) {
										String hour = String.format("%02d", i);
										out.print("<option value=\"" + hour + "\">" + hour + "</option>");
									}
								%>
							</select> <select id="endMinutes" class="form-control">
								<%
									for (int i = 0; i < 60; i++) {
										String minute = String.format("%02d", i);
										out.print("<option value=\"" + minute + "\">" + minute + "</option>");
									}
								%>
							</select>


							<button type="button" class="btn btn-primary" id="addVisitButton">
								<span class="glyphicon glyphicon-plus"></span>
							</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12" id="addedVisits">
							<%-- ?? --%>
						</div>
					</div>
				</div>
			</div>



			<h4>Pictures (optional)</h4>
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row form-horizontal bottom15">
						<div class="col-sm-3">
							<label class="control-label" for="field-pictures">Add
								pictures</label>
						</div>
						<div class="col-sm-3">
							<input type="file" id="field-pictures" accept="image/*"
								multiple="multiple" />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<table id="uploaded-pictures" class="table">
								<thead>
									<tr>
										<th id="name-column">Uploaded picture</th>
										<th>Size</th>
										<th>Delete</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group pull-right">
				<div class="col-sm-12">
					<a href="/">
						<button type="reset" class="btn btn-default">Cancel</button>
					</a>
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
			</div>
		</div>
	</div>
</div>


<c:import url="template/footer.jsp" />