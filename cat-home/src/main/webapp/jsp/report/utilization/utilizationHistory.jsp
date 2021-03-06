<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<jsp:useBean id="ctx" type="com.dianping.cat.report.page.statistics.Context" scope="request"/>
<jsp:useBean id="payload" type="com.dianping.cat.report.page.statistics.Payload" scope="request"/>
<jsp:useBean id="model" type="com.dianping.cat.report.page.statistics.Model" scope="request"/>

<a:body>
<res:useCss value='${res.css.local.table_css}' target="head-css" />
<res:useJs value="${res.js.local['bootstrap.min.js']}" target="head-js"/>
<script type="text/javascript">
		$(document).ready(function() {
			$('#utilization').addClass('active');
		});
	</script>
<div class="report">
	<table class="header">
		<tr>
			<td class="title"><span class="text-success"><span class="text-error">【报表时间】</span>&nbsp;&nbsp;From ${w:format(payload.historyStartDate,'yyyy-MM-dd HH:mm:ss')} to ${w:format(payload.historyDisplayEndDate,'yyyy-MM-dd HH:mm:ss')}</td>
			</td>
			<td class="nav">
					<a class="switch" href="?domain=${model.domain}&op=utilization"><span class="text-error">【切到小时模式】</span></a>
					<c:forEach var="nav" items="${model.historyNavs}">
					<c:choose>
						<c:when test="${nav.title eq model.reportType}">
								&nbsp;&nbsp;[ <a href="?op=historyUtilization&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${nav.title}" class="current">${nav.title}</a> ]
						</c:when>
						<c:otherwise>
								&nbsp;&nbsp;[ <a href="?op=historyUtilization&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${nav.title}">${nav.title}</a> ]&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				&nbsp;&nbsp;[ <a href="?op=historyUtilization&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${model.reportType}&step=-1">${model.currentNav.last}</a> ]&nbsp;&nbsp;
				&nbsp;&nbsp;[ <a href="?op=historyUtilization&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${model.reportType}&step=1">${model.currentNav.next}</a> ]&nbsp;&nbsp;
				&nbsp;&nbsp;[ <a href="?op=historyUtilization&domain=${model.domain}&ip=${model.ipAddress}&reportType=${model.reportType}&nav=next">now</a> ]&nbsp;&nbsp;
			</td>
		</tr>
	</table>
</div>

<div class="row-fluid">
      <div class="span2">
		<%@include file="../bugTree.jsp"%>
	</div>
	<div class="span10">
		<div class="tabbable "  > <!-- Only required for left/right tabs -->
			<ul class="nav nav-tabs alert-info">
			 	<li class="text-right "><a id="tab1Href" href="#tab1" data-toggle="tab"><strong>Web</strong></a></li>
			 	<li class="text-right "><a id="tab2Href" href="#tab2" data-toggle="tab"><strong>Service</strong></a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active" id="tab1">
					<div class="report">
						<table class="table table-striped table-bordered table-condensed table-hover">
							<tr>
								<th class="left">id</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&tab=tab1">Machine Number</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=urlCount&tab=tab1">URL Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=urlResponse&tab=tab1">URL Response Time</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=sqlCount&tab=tab1">SQL Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=pigeonCallCount&tab=tab1">Pigeon Call Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=swallowCallCount&tab=tab1">Swallow Call Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=memcacheCount&tab=tab1">Memcache Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=webScore&tab=tab1">Web Score</th>
							</tr>
						
							<c:forEach var="item" items="${model.utilizationWebList}" varStatus="status">
								<tr class="${status.index mod 2 != 0 ? 'odd' : 'even'}">
									<td>${item.id}</td>
									<td style="text-align:right">${item.machineNumber}</td>
									<td style="text-align:right">${w:format(item.urlCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.urlResponseTime,'0.0')}</td>
									<td style="text-align:right">${w:format(item.sqlCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.pigeonCallCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.swallowCallCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.memcacheCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.webScore,'0.00')}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="tab-pane" id="tab2">
					<div class="report">
						<table class="table table-striped table-bordered table-condensed table-hover">
							<tr>
								<th class="left">id</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&tab=tab2">Machine Number</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=serviceCount&tab=tab2">Service Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=serviceResponse&tab=tab2">Service Response Time</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=sqlCount&tab=tab2">SQL Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=pigeonCallCount&tab=tab2">Pigeon Call Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=swallowCallCount&tab=tab2">Swallow Call Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=memcacheCount&tab=tab2">Memcache Count</th>
								<th style="text-align:right"><a href="?domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&op=historyUtilization&sort=serviceScore&tab=tab2">Service Score</th>
							</tr>
						
							<c:forEach var="item" items="${model.utilizationServiceList}" varStatus="status">
								<tr class="${status.index mod 2 != 0 ? 'odd' : 'even'}">
									<td>${item.id}</td>
									<td style="text-align:right">${item.machineNumber}</td>
									<td style="text-align:right">${w:format(item.serviceCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.serviceResponseTime,'0.0')}</td>
									<td style="text-align:right">${w:format(item.sqlCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.pigeonCallCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.swallowCallCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.memcacheCount,'#,###,###,###,##0')}</td>
									<td style="text-align:right">${w:format(item.serviceScore,'0.00')}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</a:body>
<script type="text/javascript">
	$(document).ready(function() {
		var tab = '${payload.tab}';
		if(tab=='tab2'){
			$('#tab2Href').trigger('click');
		}else{
			$('#tab1Href').trigger('click');
		}
	});
</script>
