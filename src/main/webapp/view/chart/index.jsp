<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
    <head>
        <title>Chart</title>  
        <meta charset="utf-8" />
        <script src="http://cdn.jsdelivr.net/sockjs/0.3.4/sockjs.min.js"></script>
        <script src="http://code.jquery.com/jquery-2.1.3.js"></script>
    </head>
    <body>
        <table>
        	<tr><td colspan="2"><button style="width:100%;" id="connect">连接</button></td></tr>
        	<tr><td colspan="2"><button style="width:100%;" id="close">断开</button></td></tr>
        	<tr>
        		<td>昵称</td>
        		<td><input type="text" id="nickName"/></td>
        	</tr>
        	<tr>
        		<td>状态</td>
        		<td><input type="text" readonly="readonly" value="未连接" id="status"/></td>
        	</tr>
        	<tr>
        		<td colspan="2"><textarea rows="10" cols="" readonly="readonly" style="width:100%;" id="chartContent"></textarea></td>
        	</tr>
        	<tr>
        		<td colspan="2"><textarea rows="" cols="" style="width:100%;" id="message"></textarea></td>
        	</tr>
        	<tr>
        		<td colspan="2"><button style="width:100%;" id="send">发送</button></td>
        	</tr>
        </table>
        <script type="text/javascript">
        	$(document).ready(function() {
        		var self = this;
        		var sockjsAddr = "/test/hello/nickname";
        		var sockjsClient = null;
        		
        		var onopen = function() {
        			console.log('open');
        			$("#status").val("已连接");
        		 };
        		 var onmessage = function(e) {
        			 var chartContent = $("#chartContent").val();
        			 if (chartContent.length > 0) {
        				 chartContent += "\n";
        			 }
        			 chartContent = chartContent + e.data;
        			 $("#chartContent").val(chartContent);
        		 };
        		 var onclose = function() {
        			 console.log('close');
        			 $("#status").val("未连接");
        		 };
        		 
        		$("#connect").click(function() {
        			var nickName = $.trim($("#nickName").val());
        			if (nickName.length <= 0) {
        				alert("请先填写昵称");
        				return ;
        			} 
        			$("#status").val("正在连接中...");
        			sockjsClient = new SockJS(sockjsAddr + "/" + nickName);
        			sockjsClient.onopen = onopen;
        			sockjsClient.onmessage = onmessage;
        			sockjsClient.onclose = onclose;
        		});
        		
        		$("#close").click(function() {
        			if (sockjsClient != null) {
        				sockjsClient.close();
        				sockjsClient = null;
        				$("#status").val("未连接");
        			}
        		});
        		
        		$("#send").click(function() {
        			if (null == sockjsClient) {
        				alert("请先连接");
        				return ;
        			}
        			var message = $.trim($("#message").val());
        			if (message.length <= 0) {
        				return;
        			}
        			try {
        				var isSendSuccess = sockjsClient.send(message);
        				if (!isSendSuccess) {
        					alert("发送失败");
        				} else {
        					$("#message").val("");
        				}
        			} catch (e) {
        				alert("发送失败");
        			}
        		});
        	});
        </script>
    </body>
</html>