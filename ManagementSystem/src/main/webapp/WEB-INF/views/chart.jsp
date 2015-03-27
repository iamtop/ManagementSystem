<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ page import="com.infotop.system.account.service.ShiroDbRealm.ShiroUser,org.apache.shiro.SecurityUtils"%>

<script type="text/javascript" src="${ctx}/static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/primitives/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="${ctx}/static/js/primitives/primitives.min.js"></script>
<link rel="stylesheet" href="${ctx}/static/js/primitives/jquery/ui-lightness/jquery-ui-1.10.2.custom.min.css" />
<link href="${ctx}/static/js/primitives/primitives.latest.css" media="screen" rel="stylesheet" type="text/css" />
    
<!-- <script>parent.$.messager.progress('close');</script> -->

    <script type='text/javascript'> 
        jQuery(window).load(function () {
            var options = new primitives.orgdiagram.Config();

            var items = [
                new primitives.orgdiagram.ItemConfig({
                    id: 0,
                    parent: null,
                    title: "Scott Aasrud",
                    description: "VP, Public Sector",
                    /* image: "demo/images/photos/a.png" */
                }),
                new primitives.orgdiagram.ItemConfig({
                    id: 1,
                    parent: 0,
                    title: "Ted Lucas",
                    description: "VP, Human Resources",
                    /* image: "demo/images/photos/b.png" */
                }),
                new primitives.orgdiagram.ItemConfig({
                    id: 2,
                    parent: 0,
                    title: "Joao Stuger",
                    description: "Business Solutions, US",
                    /* image: "demo/images/photos/c.png" */
                })
            ];

            options.items = items;

            jQuery("#basicdiagram").orgDiagram(options);
        });

    </script>
    <div id="basicdiagram" style="width: 640px; height: 480px; border-style: dotted; border-width: 1px;" />