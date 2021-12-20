#define LED_ADDR                0xbfaff000
#define NUM_ADDR                0xbfaff200
#define TIMER                   0xbfafe000

#define SOC_LED            (* (volatile unsigned *)  LED_ADDR      )
#define SOC_NUM            (* (volatile unsigned *)  NUM_ADDR      )
#define SOC_TIMER          (* (volatile unsigned *)  TIMER         )

#define GREEN                   0x000f    // test pass
#define RED                     0x00f0    // test fail
#define DELAY_COUNT 5000000

void delay() {
	int i = 0;
	while(i != DELAY_COUNT) {
		i ++;
	}
}

void init() {
	SOC_LED = RED;
	delay();
}

void print_result(int flag) {
	if(flag == 1){
		while(1) {
			delay();
			SOC_LED = GREEN;
		}
	}
	else{
		SOC_LED = RED;
	}
}