public class AutomataFuncionJava {

    static final int E = -1;
    static final int Q0 = 0;
    static final int V1 = 1;
    static final int V2 = 2;
    static final int V3 = 3;
    static final int Q1 = 4;
    static final int Q2 = 5;
    static final int Q3 = 6;
    static final int Q3B = 7;
    static final int Q4 = 8;
    static final int Q5 = 9;
    static final int Q6 = 10;
    static final int Q7 = 11;

    static final String[] NOMBRE_ESTADO = {
        "q0", "q0 (leyendo 'void')", "q0 (leyendo 'void')",
        "q0 (leyendo 'void')", "q1", "q2", "q3", "q3",
        "q4", "q5", "q6", "q7"
    };

    static final String[] ESPERADO = {
        "la palabra 'void'",
        "la palabra 'void'",
        "la palabra 'void'",
        "la palabra 'void'",
        "al menos un espacio despues de 'void'",
        "el nombre de la funcion",
        "mas letras, digitos, espacios o '('",
        "'(' despues del nombre",
        "')' para cerrar los parametros",
        "'{' para abrir el cuerpo",
        "'}' para cerrar el cuerpo",
        "nada mas, solo espacios al final"
    };

    static boolean esEspacio(char c) {
        return Character.isWhitespace(c);
    }

    static boolean esInicioNombre(char c) {
        return Character.isLetter(c) || c == '_' || c == '$';
    }

    static boolean esParteNombre(char c) {
        return esInicioNombre(c) || Character.isDigit(c);
    }

    static int siguienteEstado(int estado, char c) {
        switch (estado) {
            case Q0:
                if (c == 'v') return V1;
                if (esEspacio(c)) return Q0;
                return E;

            case V1:
                return c == 'o' ? V2 : E;

            case V2:
                return c == 'i' ? V3 : E;

            case V3:
                return c == 'd' ? Q1 : E;

            case Q1:
                return esEspacio(c) ? Q2 : E;

            case Q2:
                if (esEspacio(c)) return Q2;
                if (esInicioNombre(c)) return Q3;
                return E;

            case Q3:
                if (esParteNombre(c)) return Q3;
                if (esEspacio(c)) return Q3B;
                if (c == '(') return Q4;
                return E;

            case Q3B:
                if (esEspacio(c)) return Q3B;
                if (c == '(') return Q4;
                return E;

            case Q4:
                return c == ')' ? Q5 : E;

            case Q5:
                if (esEspacio(c)) return Q5;
                if (c == '{') return Q6;
                return E;

            case Q6:
                return c == '}' ? Q7 : Q6;

            case Q7:
                return esEspacio(c) ? Q7 : E;

            default:
                return E;
        }
    }

    public static String validar(String texto) {
        int estado = Q0;
        int profundidad = 0;
        int linea = 1;
        int columna = 0;

        for (int i = 0; i < texto.length(); i++) {
            char c = texto.charAt(i);

            if (c == '\n') {
                linea++;
                columna = 0;
            } else {
                columna++;
            }

            if (estado == Q6) {
                if (c == '{') {
                    profundidad++;
                    continue;
                }

                if (c == '}' && profundidad > 0) {
                    profundidad--;
                    continue;
                }
            }

            int siguiente = siguienteEstado(estado, c);

            if (siguiente == E) {
                return "Linea " + linea
                    + ", columna " + columna
                    + ": caracter inesperado '"
                    + visible(c) + "' en el estado "
                    + NOMBRE_ESTADO[estado]
                    + ". Se esperaba "
                    + ESPERADO[estado] + ".";
            }

            estado = siguiente;
        }

        if (estado != Q7) {
            return "El archivo termino en el estado "
                + NOMBRE_ESTADO[estado]
                + " (no es de aceptacion). Se esperaba "
                + ESPERADO[estado] + ".";
        }

        return null;
    }

    static String visible(char c) {
        if (c == '\n') return "\\n";
        if (c == '\t') return "\\t";
        if (c == '\r') return "\\r";
        return String.valueOf(c);
    }
}
