package utils;

import java.util.Scanner;

import utils.enums.Color;

public class App {
    public static final String RESET = "\u001B[1;0m";
    public static final String BLACK = "\u001B[1;30m";
    public static final String RED = "\u001B[1;31m";
    public static final String GREEN = "\u001B[0;32m";
    public static final String YELLOW = "\u001B[1;33m";
    public static final String BLUE = "\u001B[0;34m";
    public static final String PURPLE = "\u001B[1;35m";
    public static final String CYAN = "\u001B[0;36m";
    public static final String WHITE = "\u001B[4;37m";
    public static final String BLACK_BG = "\u001B[1;40m";
    public static final String RED_BG = "\u001B[1;41m";
    public static final String GREEN_BG = "\u001B[1;42m";
    public static final String GREEN_BL = "\u001B[4;42m";
    public static final String YELLOW_BG = "\u001B[1;43m";
    public static final String BLUE_BG = "\u001B[1;44m";
    public static final String PURPLE_BG = "\u001B[1;45m";
    public static final String CYAN_BG = "\u001B[1;46m";
    public static final String WHITE_BG = "\u001B[1;47m";

    /**
     * Gets the ANSI code of the specified color. This is
     * an auxiliary method of {@code printf()}.
     * 
     * @param color the color
     * @return the ANSI code of the specified color
     */
    private static String getColor(Color color) {
        switch (color) {
            case BLACK ->       { return BLACK; }
            case RED ->         { return RED; }
            case GREEN ->       { return GREEN; }
            case YELLOW ->      { return YELLOW; }
            case BLUE ->        { return BLUE; }
            case PURPLE ->      { return PURPLE; }
            case CYAN ->        { return CYAN; }
            case WHITE ->       { return WHITE; }
            case BLACK_BG ->    { return BLACK_BG; }
            case RED_BG ->      { return RED_BG; }
            case GREEN_BG ->    { return GREEN_BG; }
            case GREEN_BL ->    { return GREEN_BL; }
            case YELLOW_BG ->   { return YELLOW_BG; }
            case BLUE_BG ->     { return BLUE_BG; }
            case PURPLE_BG ->   { return PURPLE_BG; }
            case CYAN_BG ->     { return CYAN_BG; }
            case WHITE_BG ->    { return WHITE_BG; }
            default ->          { return RESET; }
        }
    }

    /**
     * This method will print out a string with a specified color, format
     * and arguments. It'll use the {@code System.out.printf()}. This method
     * is just a convenience to not use ANSI codes directly.
     * 
     * @param c    the color to choose
     * @param s    the text accepting the format syntax of {@code printf()}
     * @param args the arguments
     */
    public static void printf(Color c, Object s, Object... args) {
        System.out.printf(getColor(c) + s + RESET, args);
    }

    /**
     * Print out the text specified using {@code System.out.printf()}
     * behind it. This method will be called when the color is not specified.
     * 
     * @param s    the text accepting the format syntax of {@code printf()}
     * @param args the arguments
     * 
     * @see #printf(Color, Object, Object)
     */
    public static void printf(Object s, Object... args) {
        printf(Color.NONE, s, args);
    }

    /**
     * This method will print out a string with a specified color. 
     * It'll use the {@code System.out.prinln()} with a {@code \n} at the end.
     * This method is just a convenience to not use ANSI codes directly.
     * 
     * @param c    the color to choose
     * @param s    the text to output
     */
    public static void println(Color c, Object s) {
        System.out.println(getColor(c) + s + RESET);
    }

    /**
     * Print out the text specified using {@code System.out.println()}
     * behind it. This method will be called when the color is not specified.
     * 
     * @param s    the text to output
     * 
     * @see {@link #println(Color, Object)
     */
    public static void println(Object s) {
        println(Color.NONE, s);
    }

    /**
     * Clears the screen. 
     */
    public static void clearScreen() {
        try {
            new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * Get the buffer of the Scanner specified. This method
     * should be used after using Scanner on a {@code Number}.
     * 
     * @param input the Scanner instance
     */
    public static void getBuffer(Scanner input) {
        input.nextLine();
    }

    /**
     * Prints the text specified and wait one second to proceed.
     * @param c         the color to choose
     * @param s         the text to output
     * @param seconds   the seconds to wait
     */    
    public static void printfAndWait(Color c, String s, long millis) {
        printf(c, s);

        try {
            Thread.sleep(millis);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
