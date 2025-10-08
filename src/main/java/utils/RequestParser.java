package utils;

import exceptions.RequestParsingException;
import jakarta.servlet.http.HttpServletRequest;
import objects.RequestBody;

import java.math.BigDecimal;

public class RequestParser {

    public static RequestBody parseRequest(HttpServletRequest request) throws RequestParsingException {
        RequestBody requestBody;
        try {
            BigDecimal x = new BigDecimal(request.getParameter("x"));
            BigDecimal y = new BigDecimal(request.getParameter("y"));
            BigDecimal r = new BigDecimal(request.getParameter("r"));
            String type = request.getParameter("type");
            requestBody = new RequestBody(x, y, r, type);
        }
        catch (Exception e) {
            throw new RequestParsingException("Error parsing request body");
        }
        return requestBody;
    }
}