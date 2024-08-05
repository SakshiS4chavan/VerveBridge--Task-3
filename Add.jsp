<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="digitalbd.Helper,digitalbd.User,digitalbd.trains,java.util.*" %>
<%
    String message = "";
    try {
        if(request.getParameter("createTrain") != null) {
            trains trn = new trains();
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String coach = request.getParameter("coach");
            String totalSeatStr = request.getParameter("totalseat");

            // Check for null or empty inputs
            if(name == null || name.trim().isEmpty() ||
               code == null || code.trim().isEmpty() ||
               coach == null || coach.trim().isEmpty() ||
               totalSeatStr == null || totalSeatStr.trim().isEmpty()) {
                message = "All fields are required!";
            } else {
                trn.name = name;
                trn.code = code;
                trn.type = coach;
                try {
                    trn.totalSeat = Integer.parseInt(totalSeatStr);
                    // Save the train data
                    trn.Save();
                    message = "Train Created";
                } catch (NumberFormatException e) {
                    message = "Total seat must be a number!";
                }
            }
        }
    } catch(Exception e) {
        message = "An error occurred: " + e.getMessage();
    }
%>

<%@ include file="header.jsp" %>
<div class="signpage">
    <% if(!message.equals("")){ %>
        <div class="alert alert-info"><p><%= message %></p></div>
    <% } %>
    <form class="register_form" action="<%= Helper.baseUrl %>Add.jsp" method="post">
        <div class="row">
            <div class="col-xs-12 col-sm-6 col-sm-offset-3">
                <div class="rs_form_box">
                    <h3 class="form_section_title">
                        Train Informations
                    </h3>
                    <div class="input-group">
                        <label>Name</label>
                        <input type="text" name="name" class="form-controller" required>
                    </div>
                    <div class="input-group">
                        <label>Code</label>
                        <input type="text" name="code" class="form-controller" required>
                    </div>
                    <div class="input-group">
                        <label>Total Seat</label>
                        <input type="text" name="totalseat" class="form-controller" required>
                    </div>
                    <div class="input-group">
                        <div class="form-group">
                            <label>Class :</label>
                            <select class="form-control" name="coach" required>
                                <%
                                HashMap<String,String> coach = Helper.TrainsCoach();
                                for(Map.Entry<String, String> temp : coach.entrySet()){
                                %>
                                    <option value="<%= temp.getKey() %>"><%= temp.getValue() %></option>
                                <%
                                }
                                %>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 text-center">
                <div class="rs_btn_group">
                    <button class="btn btn-default pull-left" name="createTrain" value="submit" type="submit">Save</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%@ include file="footer.jsp" %>
