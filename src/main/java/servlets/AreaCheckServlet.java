package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import objects.Result;
import utils.AreaHitChecker;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet("/areacheck")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HashMap<String, String> requestBody = (HashMap<String, String>) req.getAttribute("requestBody");

        boolean shotResult = AreaHitChecker.checkHit(requestBody);

        LocalDateTime localTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd.MM.yyyy");
        String stringTime = localTime.format(formatter);
        long endTime = System.nanoTime();
        long startTime = Long.parseLong(req.getAttribute("startTime").toString());
        double requestTime = Math.round(((double) (endTime - startTime) / 1e6) * 1e6) / 1e6;

        Result result = new Result(new BigDecimal(requestBody.get("x")),
                new BigDecimal(requestBody.get("y")),
                new BigDecimal(requestBody.get("r")),
                shotResult,
                requestTime,
                stringTime);

        ServletContext context = getServletContext();
        saveResult(context, result);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/jsp/result.jsp");
        dispatcher.forward(req, resp);
    }

    private synchronized void saveResult(ServletContext servletContext, Result result) {
        ArrayList<Result> results = (ArrayList<Result>) servletContext.getAttribute("results");

        if (results == null) {
            results = new ArrayList<>();
        }

        results.add(result);
        servletContext.setAttribute("results", results);
    }
}
