<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  author: Jsonor
  date: 2018/4/19 13:39
  description: Description
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户修改</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/v2/assets/layui/css/layui.css"
          media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<style>
    #img-auto {
        width: calc(100% - 30px);
        margin: 10px auto;
        border: 5px solid #a0a0a0;
        display: block;
    }
</style>
<body>

<hr>
<c:if test="${status == 0}">
    <form class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">用户ID</label>
            <div class="layui-input-inline">
                <input type="text" name="uid" lay-verify="require"
                       autocomplete="off" placeholder="请输入用户ID"
                <c:if test="${not empty data.uid}">
                       readonly
                </c:if>
                       class="layui-input" value="${data.uid}">
            </div>
          <label class="layui-form-label">用户名</label>
          <div class="layui-input-inline">
            <input type="text" name="username" lay-verify="require"
                   autocomplete="off" placeholder="请输入用户名"
                   class="layui-input" value="${data.username}">
          </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-inline">
                <!--required-->
                <input type="text" name="name" lay-verify=""
                       placeholder="请输入姓名" autocomplete="off"
                       class="layui-input" value="${data.name}">
            </div>
          <label class="layui-form-label">手机</label>
          <div class="layui-input-inline">
            <!--required|phone-->
            <input type="tel" name="telephone" lay-verify=""
                   autocomplete="no" class="layui-input" value="${data.telephone}">
          </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="email" lay-verify="email"
                       autocomplete="off" class="layui-input" value="${data.email}">
            </div>
          <label class="layui-form-label">出生日期</label>
          <div class="layui-input-inline">
            <!--date-->
            <input type="text" name="birthday" id="date" lay-verify="date"
                   placeholder="yyyy-MM-dd" autocomplete="off"
                   class="layui-input" value="${data.birthday}">
          </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-inline">
                <input type="radio" name="sex" value="男" title="男"
                       <c:if test="${data.sex == '男'}">checked="checked"</c:if> >
                <input type="radio" name="sex" value="女" title="女"
                       <c:if test="${data.sex == '女'}">checked="checked"</c:if> >
            </div>
          <label class="layui-form-label">权限</label>
          <div class="layui-input-inline">
            <!--date-->
            <input type="text" name="state" id="state" lay-verify="require"
                   placeholder="请输入权限代号" autocomplete="off"
                   class="layui-input" value="${data.state}">
          </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
                <!--date-->
                <input type="text" name="password" id="password" lay-verify=""
                       placeholder="请输入密码" autocomplete="off"
                       class="layui-input" value="">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="update-submit">立即提交</button>
            </div>
        </div>
    </form>
</c:if>
<c:if test="${status == 1}">
    <h2 align="center">${msg}</h2>
</c:if>
<script src="${pageContext.request.contextPath}/v2/assets/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form', 'laydate', 'upload'], function () {
        var form = layui.form
            , laydate = layui.laydate
            , layer = layui.layer
            , $ = layui.$
            , upload = layui.upload;

        //日期
        laydate.render({
            elem: '#date'
        });

        //监听提交
        form.on('submit(update-submit)', function (data) {
            updateUser(data.field, layer);
            return false;
        });

        function updateUser(json, layer) {
            console.log(json);
            $.ajax({
                type: "PUT"
                , url: "${pageContext.request.contextPath}/admin/users/" + json.uid + ".do"
                , data: JSON.stringify(json)
                , dataType: "json"
                , contentType: 'application/json;charset=UTF-8'
                , async: true
                , success: function (data) {
//                console.log(data)
                    layer.open({
                        type: 1
                        , area: ['250px', '200px']
                        , offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                        , id: 'layerMsg' + data.status //防止重复弹出
                        , content: "<hr><h2 align=\"center\">" + data.msg + "</h2>"
                        , btn: ['关闭']
                        , btnAlign: 'c' //按钮居中
                        , shade: 0.5 //不显示遮罩
                        , yes: function () {
                            layer.closeAll();
                            window.location.reload(true);
                        }
                    });
                }

            })
        }
    });

</script>

</body>
</html>