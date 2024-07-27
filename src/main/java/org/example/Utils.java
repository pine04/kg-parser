package org.example;

public class Utils {
    public static String[] splitIfNotEmpty(String s) {
        if (s.equals("")) {
            return new String[0];
        }

        return s.split(",");
    }
}
