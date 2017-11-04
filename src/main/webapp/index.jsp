<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>
        RESTful测试
    </title>
</head>
<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js">
</script>
<script type="text/javascript">
    $(document).ready(function(){  //一开始隐藏的数据
        $("#tab2").hide();
    });

    function loadDate(){
        $("#tab2").hide();          //隐藏添加框
        $("#tab1").show();          //显示自己
        $("#tab1").empty();         //清空原始数据

        var addStr;
        $.get(
            "demos",
            function(date){
                $.each(date,function(index,element){
                    addStr+="<tr><td>";         //添加数据
                    addStr+=index;
                    addStr+="</td><td>";
                    addStr+=element.name;
                    addStr+="</td><td>";
                    addStr+=element.status;
                    addStr+="</td><td>";
                    addStr+="<input type='button' onclick='deleteDate("+index+")' value='删除' />";   //添加删除方法
                    addStr+="</td><td>";
                    addStr+="<input type='button' onclick='showUpdateDate("+index+")' value='修改' />";   //添加修改方法
                    addStr+="</td></tr>";
                });
                $("#tab1").append(addStr);    //放在外面因为是异步,外面还未更新为空
                $("#tab1").append("<thead><tr><th>序号</th><th>姓名</th><th>状态</th></tr></thead>");
            }
        );

    }

    //显示添加框
    function showAddDate() {
        $("#tab1").hide();
        $("#tab2").show();
        $("#sumbit").attr("onclick",'addDate()');
        $("#name").val('');
        $("#status").val('');
    }

    //显示修改框
    function showUpdateDate(id) {
        $("#tab1").hide();
        $("#tab2").show();
        $("#sumbit").attr("onclick",'updateDate('+id+')');

        //jquery版
        $("#name").val($("tbody tr:eq("+id+") td:eq(1)").text());
        $("#status").val($("tbody tr:eq("+id+") td:eq(2)").text());

        /*get版
        $.ajax({
            url:'demo/'+id,
            type:'get',
            success:function(result){
                $("#name").val(result.name);
                $("#status").val(result.status);
            },
            error:function(){
                alert('数据已被删除');
                $("#tab2").hide();
                loadDate();
            }
        });*/

    }

    //添加函数
    function addDate(){
        var name = $("#name").val();
        var status = $("#status").val();
        if(name==''||status==''){
            alert("数据不能为空");
            return
        }
        $.ajax({
            url:'demo',
            type:'post',
            data:{name:name, status:status},

            success:function() {
                alert("保存成功");
                $("#tab2").hide();
                loadDate();
            },
            error:function() {
                alert("保存失败");
            }
        });
    }

    //修改函数
    function updateDate(id){
        var name = $("#name").val();
        var status = $("#status").val();
        if(name==''||status==''){
            alert("数据不能为空");
            return
        }
        $.ajax({
            url:'demo/'+id,
            type:'put',
            data:{name:name, status:status},

            success:function() {
                alert("修改成功");
                $("#tab2").hide();
                loadDate();
            },
            error:function() {
                alert("修改失败");
            }
        });
    }


    //删除函数
    function deleteDate(id){
        $.ajax({
            url:'demo/'+id,
            type:'delete',
            data:{id:id},

            success:function() {
                alert("删除成功");
                loadDate();
            },
            error:function() {
                alert("删除失败");
            }
        });
    }

</script>
<body>


<!-- 显示框 -->
<a href="javascript:loadDate()">显示所有Demo</a> <a href="javascript:showAddDate()">添加Demo</a>


<table id="tab1" border="1" bordercolor="#a0c6e5" style="border-collapse:collapse;padding: 2px" />


<form id="form1">
    <table id="tab2" style="padding: 3px;border: 1px" >
        <tr><td>
            姓名: <input id="name" type="text" />
        </td></tr>
        <tr><td>
            状态: <input id="status" type="text" />
        </td></tr>
        <tr><td>
            <input id="sumbit" type="button" value="保存">
        </td></tr>
    </table>
</form>




</body>
</html>
