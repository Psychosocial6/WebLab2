package utils;

import exceptions.RequestParsingException;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;

public class RequestParser {

    public static HashMap<String, BigDecimal> parseRequest(HttpServletRequest request) throws RequestParsingException, IOException {
        HashMap<String, BigDecimal> requestBody = new HashMap<>();

        try {
            requestBody.put("x", new BigDecimal(request.getParameter("x")));
            requestBody.put("y", new BigDecimal(request.getParameter("y")));
            requestBody.put("r", new BigDecimal(request.getParameter("r")));
        }
        catch (Exception e) {
            throw new RequestParsingException("Error parsing request body");
        }

        return requestBody;
    }


}
