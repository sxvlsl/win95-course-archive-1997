# include <stdio.h>
# include <conio.h>

# define MAX 25

/* Cálculo de los números primos entre 1 y MAX utilizando el algoritmo de la
               ---  CRIBA DE ERATOSTENES       ---                        */

void main(){
        bool EsPrimo[MAX] ;
        int i, j;

// Se inicia la tabla

        EsPrimo[0] = false;
        for (i = 1; i <= MAX-1; i++) EsPrimo[i] = true;

        /* En la criba de Eratostenes se parte de todos los números y se van
   eliminando todos los multiplos de los primos elegidos. Serán primos aquellos
   que, en orden ascendente no hayan sido marcados como multimplos */

   for (i = 2; i <= MAX/2; i ++)
        for (j = 2; j <= MAX/i; j++)
         EsPrimo[(i*j)-1] = false;

   // Se cuenta el número de primos encontrados

   j = 0;
   for (i = 0; i <= MAX-1; i ++)
        if (EsPrimo[i]) j++;

   printf ("Entre el 1 y %d, se han encontrado %d números primos \n", MAX, j);
   for (i = 0; i <= MAX-1; i ++)
                if (EsPrimo[i]) printf ("Nº = %d \n", i+1);
}
