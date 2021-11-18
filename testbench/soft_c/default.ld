OUTPUT_ARCH(mips)
ENTRY(_start)
SECTIONS
{
        . = 0xbfc00000;
        .text : 
        {
            *(.text)
            _etext = .;
        }

        . = 0x80000000;
        .data : 
        {
            _fdata = . ;
            _stack = _fdata + 0x04000 -32;
            *(.data)              
            *(.rodata)
            _gp = ALIGN(16) + 0x7ff0;            
        }

	.bss :
        {
            *(.bss)
        }

} 
