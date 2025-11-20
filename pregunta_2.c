#include<stdio.h>
#include<stdlib.h>  // Librería para generar números aleatorios
#include<time.h>    // Permite usar time() para inicializar srand()

int main()
{
    srand(time(0)); // Inicializa la semilla para generar números aleatorios diferentes
    int arreglo[15]; // Arreglo de 15 elementos 
    
    printf("----------------------------------------------------------------\n");
    printf("El arreglo es: ");

    // Generación e impresión del arreglo de números aleatorios
    for(int i = 0; i < 15; i++)  // Recorre las posiciones del arreglo de 0 a 14
    {
        arreglo[i] = (rand() % 81) + 1;  // Para evitar números grandes seenera números entre 1 y 80 aleatorios

        printf("%i", arreglo[i]);  // Imprime cada valor generado del arreglo

        if (i < 14) {
            printf(",");  // Imprime una coma entre valores
        }
    }

    printf("\n----------------------------------------------------------------\n");

    // Clasificación de cada número según la suma de sus divisores propios
    for(int i = 0; i < 15; i++)
    {
        int n = arreglo[i]; // Variable auxiliar para trabajar con el valor actual
        int suma = 0;       // Se inicializa la suma de los diviaores

        printf("%d - ", n); // Imprime el número que se está evaluando

        // Cálculo de divisores propios
        for(int x = 1; x < n; x++)  // Recorre desde 1 hasta n-1 buscando divisores
        {
            if(n % x == 0)  // Condicional para seleccionar los divisores propios
            {
                suma += x;  // Se suma los divisores propios
            }
        }

        // Clasificación del número según la suma obtenida
        if (suma < n) {               // Si la suma es menor que el número
            printf("Deficiente\n");
        }
        else if (suma == n) {         // Si coincide con el número
            printf("Perfecto\n");
        }
        else if (suma > n) {          // Si es mayor al número
            printf("Abundante\n");
        }
    }

    printf("examen_p_2");

}