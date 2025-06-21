package com.make_invoice.utility;

import java.io.IOException;

public class DatabaseUtil {

    public static boolean backup(String dbUsername, String dbPassword, String dbName, String outputFile) {
        // Specify the path to mysqldump without quotes
        String mysqldumpPath = "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysqldump.exe";
        String[] command = { mysqldumpPath, "-u" + dbUsername, "-p" + dbPassword, dbName, "-r", outputFile };

        try {
            Process process = Runtime.getRuntime().exec(command);
            int processComplete = process.waitFor();
            return processComplete == 0; // Returns true if backup was successful
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        } catch (InterruptedException e) {
            e.printStackTrace();
            Thread.currentThread().interrupt(); // Preserve interrupt status
            return false;
        }
    }
}
