package utils;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class Validator {
    private static final Set<BigDecimal> availableXValues = new TreeSet<>(List.of(new BigDecimal("-3"),
            new BigDecimal("-2"),
            new BigDecimal("-1"),
            new BigDecimal("0"),
            new BigDecimal("1"),
            new BigDecimal("2"),
            new BigDecimal("3"),
            new BigDecimal("4"),
            new BigDecimal("5")));
    private static final Set<BigDecimal> availableRValues = new TreeSet<>(List.of(new BigDecimal("1"),
            new BigDecimal("2"),
            new BigDecimal("3"),
            new BigDecimal("4"),
            new BigDecimal("5")));
    private static final BigDecimal Y_MIN = new BigDecimal("-5");
    private static final BigDecimal Y_MAX = new BigDecimal("3");

    public static boolean validateData(HashMap<String, String> requestBody) {
        return availableXValues.contains(new BigDecimal(requestBody.get("x"))) && availableRValues.contains(new BigDecimal(requestBody.get("r"))) && new BigDecimal(requestBody.get("y")).compareTo(Y_MIN) >= 0 && new BigDecimal(requestBody.get("y")).compareTo(Y_MAX) <= 0;
    }
}
