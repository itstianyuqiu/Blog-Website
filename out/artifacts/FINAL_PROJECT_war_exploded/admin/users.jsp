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
                    <button class="btn btn-danger btn-sm alldelete">Delete All</button>
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
                        <td class="useremail">${userPOJO.email}</td>
                        <td>${userPOJO.firstName}</td>
                        <td>${userPOJO.lastName}</td>
                        <td>${userPOJO.gender}</td>
                        <td>${userPOJO.country}</td>
                        <td>${userPOJO.birth}</td>
                        <td class="text-center">
                            <c:if test="${not empty userPOJO.securityKey}">
                                <a href="javascript:;" class="btn btn-info btn-xs email" data-toggle="modal"
                                   data-target="#myModal" id="${userPOJO.securityKey}">email</a>
                            </c:if>
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

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title email-address" id="myModalLabel">Email To </h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="email-title">email subject</label>
                    <input class="form-control" id="email-title" name="title" type="text" placeholder="heater">
                </div>
                <div class="form-group">
                    <label for="email-content">email content</label>
                    <textarea class="form-control" id="email-content" name="content" placeholder="content">
                            </textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary create-link">create reset password link</button>
                <button type="button" class="btn btn-primary send-email">Send email</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
<script src="../JQuery_lib/jquery-3.3.1.js"></script>
<script src="../vendors/bootstrap/js/bootstrap.js"></script>

<script>
    $(".page[id=${quarymodel.pageNO}]").addClass("active")
    $(function ($) {
        $('.email').click(function () {
            var emailaddress = $(this).parent().parent().children(".useremail").text()
            var securityKey = $(this).attr('id')
            $('.email-address').text('Email To : ' + emailaddress).attr({
                "email-address": emailaddress,
                "security-Key": securityKey
            });
        });
        $('.create-link').click(function () {

            $('#email-title').val('Reset password mail')
            $('#email-content').val('http://localhost:8181/admin/password_reset.jsp?security-Key=' + $('.email-address').attr('security-Key'))

        });
        $('.send-email').click(function () {
            sendEmail($('#email-title').val(), $('#email-content').val(), $('.email-address').attr('email-address'), $('.email-address').attr('security-Key'))
        });

        function sendEmail(title, content, address, key) {
            $.post("/AdminUserServlet", {
                'adminuser': 'sendemail',
                'email-address': JSON.stringify(address),
                'email-title': title,
                'security-Key': key,
                'email-content': content
            }, function (xhr) {
                if (xhr == '0') {
                    $('#myModal').css('display','none');
                    closeModel();
                    alert('send success!')
                } else {
                    alert('send error!')
                }
            });
        }

        $(".close").on('click', function () {
            closeModel()
        });

        function closeModel() {
            $('.email-address').removeAttr('email-address').removeAttr('security-Key')
            $('#email-title').val('')
            $('#email-content').val('')
        }

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
