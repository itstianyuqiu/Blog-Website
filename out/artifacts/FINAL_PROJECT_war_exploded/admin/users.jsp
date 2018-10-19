<%@ page import="POJO.AdminPOJO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>Users &laquo; Admin</title>
    <link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="../adminCSS/admin.css">
    <style>
        .button-bar {
            margin: 20px 0 30px 20px;

        }

        .page-action {
            margin-left: 10px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="page-title">
        <h1>USER</h1>
    </div>
    <!-- when have incorrect message-->
    <!-- <div class="alert alert-danger">
      <strong>错误！</strong>发生XXX错误
    </div> -->

    <div class="row">

        <div class="col-md-12">
            <div class="button-bar">
                <div class="page-action" style="display: inline-block">
                    <button class="btn btn-danger btn-sm allemail">Send All</button>
                </div>
                <div class="page-action" style="display: inline-block">
                    <button class="btn btn-danger btn-sm alldelete">All Delete</button>
                </div>

            </div>
            <table class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="text-center" width="40"><input type="checkbox"></th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Gender</th>
                    <th>Country</th>
                    <th>Birth</th>
                    <th class="text-center" width="150">Operation</th>
                </tr>
                </thead>
                <tbody class="usershow">
                <c:forEach items="${quarymodel.list}" var="userPOJO">
                    <tr id="${userPOJO.user_id}">
                        <td>
                            <input type="checkbox">
                        </td>
                        <td>${userPOJO.username}</td>
                        <td>${userPOJO.email}</td>
                        <td>${userPOJO.firstName}</td>
                        <td>${userPOJO.lastName}</td>
                        <td>${userPOJO.gender}</td>
                        <td>${userPOJO.country}</td>
                        <td>${userPOJO.birth}</td>
                        <td class="text-center">
                                <%--<c:if test="${userPOJO.security_key} ne null"> <a href="javascript:;" class="btn btn-default btn-xs email" >email</a></c:if>--%>
                            <a href="javascript:;" class="btn btn-danger btn-xs deletebtn">delete</a>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>

        </div>
        <ul class="pagination pagination-sm pull-right">
            <li class="pro">
                <a href="/AdminUserServlet?adminuser=getalluser&currentpage=<c:out value='${quarymodel.propage}'/>">PRO</a>
            </li>
            <c:forEach begin="1" end="${quarymodel.pageal}" step="1" var="i">
                <li id="<c:out value='${i}'/>" class="page">
                    <a href="/AdminUserServlet?adminuser=getalluser&currentpage=<c:out value='${i}'/>"><c:out
                            value="${i}"/></a>
                </li>
            </c:forEach>
            <li class="next"><a
                    href="/AdminUserServlet?adminuser=getalluser&currentpage=<c:out value='${quarymodel.nextpage}'/>">NEXT</a>
            </li>
        </ul>
    </div>
</div>
</body>
<script src="../JQuery_lib/jquery-3.3.1.js"></script>
<script src="../vendors/bootstrap/js/bootstrap.js"></script>

<script>
    $(".page[id=${quarymodel.pageNO}]").addClass("active")
    $(function ($) {

        <%--$("#${userPOJO.user_id} .email").click(function(){--%>
        <%--location.href="/AdminUserServlet?adminuser=sendemail&username="+ ${userPOJO.username}--%>
        <%--})--%>
        <%--$(".allemail").click(function(){--%>
        <%--location.href="/AdminUserServlet?adminuser=sendemail&username="+ ${userPOJO.username}--%>
        <%--})--%>

        $(".text-center input").click(function () {
            $(".usershow input").prop("checked", $(this).prop("checked"));
        });
        $(".usershow input").click(function () {
            $(".usershow input:checked").length == $(".usershow tr").length ? $(".text-center input").prop("checked", true) : $("thead input").prop("checked", false);
        });

        function deleteajax(ids) {
            $.post("/AdminUserServlet",
                {
                    "adminuser": "deleteuser",
                    'user_id': JSON.stringify(ids)
                },
                function (xhr) {
                    if (xhr == "success") {
                        location.href = "/AdminUserServlet?adminuser=getalluser&currentpage=" +
                        ${quarymodel.pageNO}
                    }
                }
            )
        }

        $(".deletebtn").click(function (e) {
            var $id = new Array();
            $id.push($(e.target).parent().parent().attr("id"))
            deleteajax($id);
        });

        $(".alldelete").click(function () {
            var ids = new Array();
            $(".usershow input:checked").parent().parent().each(function (i) {
                ids.push($(this).attr("id"));
            });
            if (ids.length > 0) {
                deleteajax(ids);
            }
        })
        $(".page").click(function () {
            $(".page").removeClass("active");
            $(this).addClass("active")

        });
    });

</script>

</html>
