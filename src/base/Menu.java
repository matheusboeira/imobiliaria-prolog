package base;

import utils.App;
import utils.enums.Color;

public class Menu {
    public static void show() {
        App.printf(Color.PURPLE, "[MENU DE OPÇÕES]\n\n");
        App.printf("    1 - Listar Clientes\n");
        App.printf("    2 - Listar Cliente\n");
        App.printf("    3 - Listar Vendas\n");
        App.printf("    4 - Listar Clientes por Profissão\n");
        App.printf("    5 - Listar Valor Médio de Venda\n");
        App.printf("    6 - Alterar Informação de Cliente\n");
        App.printf("    7 - Listar Imobiliária com Maior Venda\n");
        App.printf("    8 - Listar Vendedor por Valor de Vendas\n");
        App.printf("    0 - Sair\n");
        App.printf(Color.YELLOW, "\nDigite uma das opções acima: ");
    }
}
