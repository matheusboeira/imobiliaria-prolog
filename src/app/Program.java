package app;

import java.util.Scanner;

import base.Menu;
import base.ResultProlog;
import utils.App;
import utils.Prolog;
import utils.enums.Color;

public class Program {
    public static void main(String[] args) {
        App.clearScreen();
        Prolog.connect();

        int option;
        boolean repeat;
        boolean defaultRepeat;

        try (Scanner input = new Scanner(System.in)) {
            do {
                defaultRepeat = repeat = false;

                Menu.show();
                option = input.nextInt();
                input.nextLine();

                switch (option) {
                    case 1 -> ResultProlog.listClients();
                    case 2 -> ResultProlog.listClient(input);
                    case 3 -> ResultProlog.listTypesByAgency(input);
                    case 4 -> ResultProlog.listClientsByCareer(input);
                    case 5 -> ResultProlog.listAverageAgencies();
                    case 6 -> ResultProlog.alterClient(input);
                    case 7 -> ResultProlog.listAgencyByValueSold();
                    case 8 -> ResultProlog.listSellersByValueSold();
                    case 0 -> {
                        App.println(Color.CYAN, "\nPrograma encerrado!");
                        System.exit(0);
                    }
                    default -> {
                        App.clearScreen();
                        App.println(Color.RED, "Por favor, digite uma opção válida.\n");
                        defaultRepeat = true;
                    }
                }
                if (!defaultRepeat) {
                    repeat = returnToMenu(input);
                }
            } while (repeat || defaultRepeat);
        }
        App.println(Color.CYAN, "\nPrograma encerrado!");
    }

    public static boolean returnToMenu(Scanner scanner) {
        App.printf(Color.WHITE, "\nDeseja retornar ao menu? (S/N):");
        App.printf(" ");
        boolean repeat = scanner.next().toLowerCase().equals("s");
        App.clearScreen();
        return repeat;
    }
}
