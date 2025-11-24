#include <stdint.h>
#define GPIO0_BASE 0x50000000  // registro base

//declaracion de las direcciones usando offsets
#define GPIO0_OUT (GPIO0_BASE + 0x504) // Write GPIO port
#define GPIO0_OUTSET (GPIO0_BASE + 0x508)  // Set individual bits
#define GPIO0_OUTCLR (GPIO0_BASE + 0x50C)   // Clear individual bits
#define GPIO0_IN (GPIO0_BASE + 0x510)  // Read GPIO port
#define GPIO0_DIR (GPIO0_BASE + 0x514)  // Direction of GPIO pins
#define GPIO0_DIRSET (GPIO0_BASE + 0x518)   // DIR set register
#define GPIO0_DIRCLR (GPIO0_BASE + 0x51C)   // DIR clear register

void setup(){
//creacion de punteros hacia cada resgistro
volatile uint32_t* p_gpio_out = (uint32_t*)GPIO0_OUT;
volatile uint32_t* p_gpio_outset = (uint32_t*)GPIO0_OUTSET;
volatile uint32_t* p_gpio_outclr = (uint32_t*)GPIO0_OUTCLR;
volatile uint32_t* p_gpio_in = (uint32_t*)GPIO0_IN;
volatile uint32_t* p_gpio_dir = (uint32_t*)GPIO0_DIR;
volatile uint32_t* p_gpio_dirset = (uint32_t*)GPIO0_DIRSET;
volatile uint32_t* p_gpio_dirclr = (uint32_t*)GPIO0_DIRCLR;
}