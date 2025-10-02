<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>WebLab2</title>
    <script>
        const contextPath = '${pageContext.request.contextPath}';
    </script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/styles.css">
    <script src="${pageContext.request.contextPath}/static/script.js"></script>
</head>

<body>
<header>
    <!--шапка-->
    <h1>Зыков Андрей Алексеевич | P3206 | вариант 547291</h1>
</header>

<main>
    <div class="container">
        <div class="top-row">
            <!--параметры точки и графика-->
            <div class="block">
                <!--X-->
                <fieldset>
                    <legend>Изменение X</legend>
                    <div class="x-button-container">
                        <div>
                            <button name="x-3" id="x-3">-3</button>
                            <button name="x-2" id="x-2">-2</button>
                            <button name="x-1" id="x-1">-1</button>
                        </div>
                        <div>
                            <button name="x0" id="x0" class="active-button">0</button>
                            <button name="x1" id="x1">1</button>
                            <button name="x2" id="x2">2</button>
                        </div>
                        <div>
                            <button name="x3" id="x3">3</button>
                            <button name="x4" id="x4">4</button>
                            <button name="x5" id="x5">5</button>
                        </div>
                    </div>

                </fieldset>

                <!--Y-->
                <fieldset>
                    <legend>Изменение Y</legend>
                    <input type="text" id="Ytext" name="Ytext" placeholder="Значение Y (от -5 до 3)"/>
                </fieldset>

                <!--R-->
                <fieldset>
                    <legend>Изменение R</legend>
                    <div>
                        <input type="radio" id="R1" name="R" value="1" checked="checked">
                        <label for="R1">1</label>
                    </div>
                    <div>
                        <input type="radio" id="R2" name="R" value="2">
                        <label for="R2">2</label>
                    </div>
                    <div>
                        <input type="radio" id="R3" name="R" value="3">
                        <label for="R3">3</label>
                    </div>
                    <div>
                        <input type="radio" id="R4" name="R" value="4">
                        <label for="R4">4</label>
                    </div>
                    <div>
                        <input type="radio" id="R5" name="R" value="5">
                        <label for="R5">5</label>
                    </div>
                </fieldset>

                <div class="button-panel">
                    <button name="submit" id="button" disabled>Проверить</button>
                    <button name="clear" id="clear">Очистить таблицу</button>
                </div>

            </div>

            <!--график-->
            <div class="block">
                <svg id="image" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">

                    <!--оси-->
                    <line x1="25" x2="375" y1="200" y2="200" stroke="#334155"/>
                    <line x1="200" x2="200" y1="25" y2="375" stroke="#334155"/>

                    <!--стрелки осей-->
                    <polygon points="380,200 375,195 375, 205" fill="#334155" stroke="#334155"/>
                    <polygon points="200,20 205,25 195,25" fill="#334155" stroke="#334155"/>

                    <!--значения X-->
                    <line x1="350" x2="350" y1="205" y2="195" stroke="#334155"/>
                    <line x1="275" x2="275" y1="205" y2="195" stroke="#334155"/>
                    <line x1="50" x2="50" y1="205" y2="195" stroke="#334155"/>
                    <line x1="125" x2="125" y1="205" y2="195" stroke="#334155"/>

                    <!--значения Y-->
                    <line x1="205" x2="195" y1="350" y2="350" stroke="#334155"/>
                    <line x1="205" x2="195" y1="275" y2="275" stroke="#334155"/>
                    <line x1="205" x2="195" y1="50" y2="50" stroke="#334155"/>
                    <line x1="205" x2="195" y1="125" y2="125" stroke="#334155"/>

                    <!--подписи X-->
                    <text x="350" y="190" stroke="#334155">R</text>
                    <text x="275" y="190" stroke="#334155">R/2</text>
                    <text x="50" y="190" stroke="#334155">-R</text>
                    <text x="125" y="190" stroke="#334155">-R/2</text>

                    <!--подписи Y-->
                    <text x="210" y="350" stroke="#334155">-R</text>
                    <text x="210" y="275" stroke="#334155">-R/2</text>
                    <text x="210" y="50" stroke="#334155">R</text>
                    <text x="210" y="125" stroke="#334155">R/2</text>

                    <!--подписи осей-->
                    <text x="380" y="215" stroke="#334155">X</text>
                    <text x="185" y="20" stroke="#334155">Y</text>

                    <!--фгиура-->
                    <rect height="75" width="150" X="50" y="200" fill-opacity="0.5" stroke="#3b82f6" fill="#3b82f6"/>
                    <polygon points="125,200 200,200 200,125" fill-opacity="0.5" stroke="#3b82f6" fill="#3b82f6"/>
                    <path d="M 200 200 L 275 200 A 75 75 0 0 0 200 125 Z" fill="#3b82f6" stroke="#3b82f6" fill-opacity="0.5"/>
                </svg>
            </div>
        </div>

        <div class="table-block">
            <!--таблица с результатами-->
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
    </div>
</main>
</body>
</html>
