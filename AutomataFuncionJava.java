
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
            "q0", "q0 (leyendo 'void')", "q0 (leyendo 'void')", "q0 (leyendo 'void')",
            "q1", "q2", "q3", "q3", "q4", "q5", "q6", "q7"
    };

    static final String[] ESPERADO = {
            "la palabra 'void'",
            "la palabra 'void'",
            "la palabra 'void'",
            "la palabra 'void'",
            "al menos un espacio después de 'void'",
            "el nombre de la función (empieza con letra, '_' o '$')",
            "más letras/dígitos del nombre, espacios o '('",
            "'(' después del nombre",
            "')' para cerrar los parámetros",
            "'{' para abrir el cuerpo",
            "'}' para cerrar el cuerpo",
            "nada más (solo espacios en blanco al final)"
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

}