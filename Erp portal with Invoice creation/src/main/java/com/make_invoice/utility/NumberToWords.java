package com.make_invoice.utility;



public class NumberToWords {

    private static final String[] units = {
        "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", 
        "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", 
        "Eighteen", "Nineteen"
    };
    
    private static final String[] tens = {
        "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
    };
    
    private static final String[] thousands = {
        "", "Thousand", "Million", "Billion"
    };

    public static String convertToWords(int number) {
        if (number == 0) {
            return "Zero";
        }

        String words = "";
        int thousandCounter = 0;

        while (number > 0) {
            if (number % 1000 != 0) {
                words = convertLessThanThousand(number % 1000) + thousands[thousandCounter] + " " + words;
            }
            number /= 1000;
            thousandCounter++;
        }

        return words.trim();
    }

    private static String convertLessThanThousand(int number) {
        String result;

        if (number % 100 < 20) {
            result = units[number % 100];
            number /= 100;
        } else {
            result = units[number % 10];
            number /= 10;

            result = tens[number % 10] + " " + result;
            number /= 10;
        }
        if (number == 0) {
            return result;
        }
        return units[number] + " Hundred " + result;
    }
    
   

    
}
