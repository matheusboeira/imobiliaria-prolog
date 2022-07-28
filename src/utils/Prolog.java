package utils;

import org.jpl7.PrologException;
import org.jpl7.Query;

import utils.enums.Color;

public class Prolog {
    private static final String PROLOG = "consult('prolog/real_estate.pl')";
    private static Query query;

    /**
     * Connects to the Prolog 'server' using JPL. 
     * @return true if the connection was successful, false otherwise.
     */
    public static boolean connect() {
        try {
            query = new Query(PROLOG);

            if (query.hasSolution()) {
                App.println(Color.GREEN, "Prolog conectado!\n");
                return true;
            }
        } catch (PrologException e) {
            App.printf(Color.RED, "Conexão com o arquivo de Prolog falhou. ");
            App.printf(Color.RED_BG, "Programa encerrado.\n");
            System.exit(0);
        }
        return false;
    }

    /**
     * Connects to the Prolog 'server' using JPL. 
     * @param file the file to be consulted.
     * @return true if the connection was successful, false otherwise.
     */
    public static boolean connect(String file) {
        try {
            query = new Query(String.format("consult('%s')", file));

            if (query.hasSolution()) {
                App.println(Color.GREEN, "Prolog conectado!\n");
                return true;
            }
        } catch (PrologException e) {
            App.printf(Color.RED, "Conexão com o arquivo de Prolog falhou. ");
            App.printf(Color.RED_BG, "Programa encerrado.\n");
            System.exit(0);
        }
        return false;
    }

   /**
    * Executes a Prolog query.
    * @param term the query to be executed.
    */
    public static boolean consult(String term) {
        query = new Query(term);
        App.println(Color.PURPLE, "\n[RESULTADO]");
        return query.hasSolution();
    }
}
