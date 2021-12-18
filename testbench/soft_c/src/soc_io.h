#define LED_ADDR                0xbfaff000
#define NUM_ADDR                0xbfaff200
#define TIMER                   0xbfafe000

#define SEG_7				    0xbfaff010


#define SOC_LED            (* (volatile unsigned *)  LED_ADDR      )
#define SOC_NUM            (* (volatile unsigned *)  NUM_ADDR      )
#define SOC_TIMER          (* (volatile unsigned *)  TIMER         )
#define SOC_SEG_7		   (* (volatile unsigned *)  SEG_7         )

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
			SOC_SEG_7 = 0xff00;
		}
	}
	else{
		SOC_LED = RED;
		SOC_SEG_7 = 0x00ff;
	}
}