<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="table-block">
    <table>
        <thead>
        <tr>
            <td>№</td>
            <td>X</td>
            <td>Y</td>
            <td>R</td>
            <td>Результат попадания</td>
            <td>Время обработки запроса, мс</td>
            <td>Текущее время</td>
        </tr>
        </thead>

        <tbody id="table-body">
        <c:if test="${not empty applicationScope.results}">
            <c:forEach var="res" items="${applicationScope.results}" varStatus="loop">
                <tr class="data-row">
                    <td class="n">${loop.count}</td>
                    <td class="x">${res.x}</td>
                    <td class="y">${res.y}</td>
                    <td class="r">${res.r}</td>
                    <td class="result">${res.result ? 'Попадание' : 'Промах'}</td>
                    <td class="request-time">${res.requestTime}</td>
                    <td class="local-time">${res.localTime}</td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty applicationScope.results}">
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>