# include <stdio.h>
# include <conio.h>

void Eco();

bool final(char c);

void main(){
        clrscr();
   printf ("Con una \"S\" se acabó el eco \n");
   Eco();
   clrscr();
   printf ("\n \n Se acabó. \n \n ");
}

void Eco(){
        char seguir;

   do{
      seguir = char getchar();
      printf ("%c", seguir);
   } while (!final(seguir));
}

bool final(char c){
        if ((c == 's') || (c == 'S'))
        return(true);
        else
        return(false);
}
