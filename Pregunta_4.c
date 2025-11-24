#include <Arduino.h>
#include <stdio.h>
#include <stdint.h>

//declarar regitros y designacion de punteros
#define SENS_SAR_START_FORCE_REG  (*(volatile uint32_t*)0x3FF4882C)
#define SENS_SAR_READ_CTRL_REG (*(volatile uint32_t*)0x3FF48800)
#define SENS_SAR_ATTEN1_REG (*(volatile uint32_t*)0x3FF48834)
#define SENS_SAR_MEAS_START1_REG (*(volatile uint32_t*)0x3FF48854)
//puntros para la salidas 
#define GPIO_ENABLE_REG (*(volatile uint32_t*)0x3FF44020)
#define GPIO_OUT_W1TS_REG (*(volatile uint32_t*)0x3FF44008)
#define GPIO_OUT_W1TC_REG  (*(volatile uint32_t*)0x3FF4400C)
// punteros para la entrada
#define GPIO_IN_REG (*(volatile uint32_t*)0x3FF4403C)
//punteros para las reistencias pull up
#define IO_MUX_GPIO4_REG (*(volatile uint32_t*)0x3FF49048) 
#define IO_MUX_GPIO5_REG (*(volatile uint32_t*)0x3FF4906C)
//#define IO_MUX_GPIO5_REG (*(volatile uint32_t*)0x3FF49034)
//#define IO_MUX_GPIO4_REG (*(volatile uint32_t*)0x3FF49038)

#define SW1 5
#define SW2 4
#define potenciometro 34
#define pot_canal 6
#define led_B 25
#define led_G 26
#define led_R 27

//variables globales
int tiempo_muestreo = 0;  
int tiempo_cambio = 0;
unsigned long ultimo_cambio = 0;

// Estados previos de los botones (para detectar flanco)
int sw1_anterior = 1;   // suelto (pull-up)
int sw2_anterior = 1;   // suelto (pull-up)


void configurar_adc1(void)
{
  //configuracion de la atenuación  
  SENS_SAR_ATTEN1_REG &= ~(0x3 << 12);
  //Activacion del control digital del ADC1
  SENS_SAR_READ_CTRL_REG |= (1 << 27);
  //cinfiguracion de la resolucion a 12bits
  SENS_SAR_READ_CTRL_REG |= (1 << 16);
  SENS_SAR_READ_CTRL_REG |= (1 << 17);
  //Habilitacion del modo star force
  SENS_SAR_START_FORCE_REG |= (0x3 << 0);
}

uint32_t leer_adc1(void)
{
  //habilitacion del canal 6 del ADC1
  SENS_SAR_MEAS_START1_REG |= (1 << 25);
  //iniciacion de la conversion 
  SENS_SAR_MEAS_START1_REG |= (1 << 31) | ( 1<< 18) | ( 1<< 17);

  uint32_t timeout = 1000000;  // límite para esperar

  while((SENS_SAR_MEAS_START1_REG & (1 << 16)) == 0 && timeout>0)
  {
     timeout--;
  }
  if (timeout==0)
  {
    return 0xFFFF;
  }
   return SENS_SAR_MEAS_START1_REG & 0XFFFF;
}


uint32_t promedio_ADC(int tiempo)
{
  uint32_t muestras[10];
  uint32_t suma = 0;

  for (int i = 0; i < 10; i++)
  {
    muestras[i] = leer_adc1();   // leer valor ADC real
    suma += muestras[i];         // acumular

    delay(tiempo* 100);   // esperar según el tiempo configurado
  }
    return suma / 10; //promedio de 10 muestras
}

int leer_boton(int PIN)
{
    uint32_t estado = GPIO_IN_REG & (1 << PIN);

    // Pullup PRESIONADO = 0
    if (estado == 0)
        return 1;
    else
        return 0;
}


 void definir_tiempo()
{
    int sw1_actual = leer_boton(SW1);   // incremento
    int sw2_actual = leer_boton(SW2);   // decremento

    //incremento
    if (sw1_actual == 1 && sw1_anterior == 0)
    {
        tiempo_muestreo += 2;
        if (tiempo_muestreo > 20)
            tiempo_muestreo = 20;

        tiempo_cambio = 1;
        ultimo_cambio = millis();  
    }
    //decremento
    if (sw2_actual == 1 && sw2_anterior == 0)
    {
        tiempo_muestreo -= 2;
        if (tiempo_muestreo < 2)
            tiempo_muestreo = 2;

        tiempo_cambio = 1;
        ultimo_cambio = millis();  
    }

    // Guardar estado anterior
    sw1_anterior = sw1_actual;
    sw2_anterior = sw2_actual;
}
  
void actualizar_led_Tiempo_definido()
{
    //inicializacion de led apagados
  GPIO_OUT_W1TC_REG |= ( 1<< led_B);
  GPIO_OUT_W1TC_REG |= ( 1<< led_G);
  GPIO_OUT_W1TC_REG |= ( 1<< led_R);

 if(tiempo_muestreo >= 2 && tiempo_muestreo <=10){
   GPIO_OUT_W1TS_REG |= (1 << led_R);   // led ROJO 
 }
 else if (tiempo_muestreo >= 12 && tiempo_muestreo <= 16){
   GPIO_OUT_W1TS_REG |= (1 << led_B);   // led AZUL
 }
 else if (tiempo_muestreo == 18 || tiempo_muestreo == 20){
    GPIO_OUT_W1TS_REG |= (1 << led_G);   // led VERDE
 }
}

void apagar_leds()
{
    GPIO_OUT_W1TC_REG |= (1 << led_R);
    GPIO_OUT_W1TC_REG |= (1 << led_G);
    GPIO_OUT_W1TC_REG |= (1 << led_B);
}

void setup() {
 //halitacion de las salidas
  GPIO_ENABLE_REG |= ( 1<< led_B);
  GPIO_ENABLE_REG |= ( 1<< led_G);
  GPIO_ENABLE_REG |= ( 1<< led_R);
  //inicializacion de led apagados
  GPIO_OUT_W1TC_REG |= ( 1<< led_B);
  GPIO_OUT_W1TC_REG |= ( 1<< led_G);
  GPIO_OUT_W1TC_REG |= ( 1<< led_R);

  //habiliracion de las entradas
  GPIO_ENABLE_REG &= ~( 1<< SW2);
  GPIO_ENABLE_REG &= ~( 1<< SW1);

  //Activar la resistencia pull up IO_MUX
  IO_MUX_GPIO4_REG |= (1 << 8);
  IO_MUX_GPIO5_REG |= (1 << 8);
  // desactivar resistencia pull-down IO_MUX
  IO_MUX_GPIO4_REG &= ~(1 << 7);
  IO_MUX_GPIO5_REG &= ~(1 << 7);

  Serial.begin(115200);
  Serial.println("Hello, ESP32!");
   configurar_adc1();
 
}


void loop() 
{
   definir_tiempo();

   // si pasa mas de 3segundos sin cambio
   if (millis() - ultimo_cambio > 3000 && tiempo_cambio == 1)
  
    {
        actualizar_led_Tiempo_definido(); // configuracionn de tiempo por el usuario
        uint32_t promedio = promedio_ADC(tiempo_muestreo);
        apagar_leds();
        printf("Promedio obtenido del ADC = %d\n", promedio);
        printf("Tiempo de muestreo configurado = %d\n", tiempo_muestreo);
        
        tiempo_cambio = 0;   // limpiar la bandera
        tiempo_muestreo =0 ;  // limpiar para un nuevo ciclo
    }
    delay(50);   // para evitar rebotes
  
}
