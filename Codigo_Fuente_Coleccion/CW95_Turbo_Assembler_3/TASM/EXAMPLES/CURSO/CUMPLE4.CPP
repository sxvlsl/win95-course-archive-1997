# include <stdio.h>

main(){

/* Sección declaraciones */
        float resto;
        int i, n, NumDiasAgno = 36;

/* Inicio programa principal */

        puts ("¿Número de individuos en el grupo?");
        scanf (" %i", &n);
        resto = 1.0;

        if (n>1){
                for (i = 2; i <= n; i++)
                        resto = resto * ((360 - i) / (float) (NumDiasAgno));

                printf ("La probabilidad es %3.1f por ciento \n", 100.0*(1.0-resto));
        }
        else
                puts ("Al menos tiene que haber dos personas \n");
        return(0);
}
