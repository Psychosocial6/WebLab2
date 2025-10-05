package servlets;

import exceptions.RequestParsingException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.RequestParser;
import utils.Validator;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;

@WebServlet("/api")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HashMap<String, String> requestBody;

        try {
            requestBody = RequestParser.parseRequest(req);
            if (requestBody.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid values");
                return;
            }
            if (!Validator.validateData(requestBody) && requestBody.get("type").equals("btn")) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid values");
                return;
            }
        }
        catch (RequestParsingException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("/areacheck");
        req.setAttribute("startTime", System.nanoTime());
        req.setAttribute("requestBody", requestBody);
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/delete");
        dispatcher.forward(req, resp);
    }
}
