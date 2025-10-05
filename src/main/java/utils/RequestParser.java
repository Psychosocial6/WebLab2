package utils;

import exceptions.RequestParsingException;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;

public class RequestParser {

    public static HashMap<String, String> parseRequest(HttpServletRequest request) throws RequestParsingException, IOException {
        HashMap<String, String> requestBody = new HashMap<>();

        try {
            requestBody.put("x", request.getParameter("x"));
            requestBody.put("y", request.getParameter("y"));
            requestBody.put("r", request.getParameter("r"));
            requestBody.put("type", request.getParameter("type"));
        }
        catch (Exception e) {
            throw new RequestParsingException("Error parsing request body");
        }

        return requestBody;
    }


}
