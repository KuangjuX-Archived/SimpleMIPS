#include <stdio.h>
#include <stdlib.h>
#include <elf.h>
void binary_out(FILE* out,unsigned char* mem)
{
    char tmp;
    unsigned char num[8];
    int i, j;
    num[0] = 1;
    num[1] = 2;
    num[2] = 4;
    num[3] = 8;
    num[4] = 16;
    num[5] = 32;
    num[6] = 64;
    num[7] = 128;
    for(i=3;i>=0;i--)
    {
        for(j=7;j>=0;j--)
        {
            if( (mem[i] & num[j] ) != 0)
                tmp = '1';
            else
                tmp = '0';
            fprintf(out,"%c",tmp);
        }
    }
    fprintf(out,"\n");
    return;
}

int main(int argc, char* argv[])
{
	FILE *in;
	FILE *out;

	uint8_t *file_bin_name = malloc(80);
	uint8_t *file_data_name = malloc(80);

	int i,j,k;
	unsigned char mem[32];

	strcat(file_bin_name, argv[1]);  
	strcat(file_data_name, argv[2]);

    in = fopen(file_bin_name, "rb");
    out = fopen("inst_rom.coe","w");

	fprintf(out, "memory_initialization_radix = 16;\n");
	fprintf(out, "memory_initialization_vector =\n");
	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
	        fprintf(out, "%02x%02x%02x%02x\n", mem[0], mem[1],	mem[2], mem[3]);
		break;
	     }
	    fprintf(out, "%02x%02x%02x%02x\n", mem[0], mem[1], mem[2],mem[3]);
        }
	fclose(in);
	fclose(out);

    in = fopen(file_data_name, "rb");
    out = fopen("data_ram.coe","w");

	fprintf(out, "memory_initialization_radix = 16;\n");
	fprintf(out, "memory_initialization_vector =\n");
	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
	        fprintf(out, "%02x%02x%02x%02x\n", mem[0], mem[1],	mem[2], mem[3]);
		break;
	     }
	    fprintf(out, "%02x%02x%02x%02x\n", mem[0], mem[1], mem[2],mem[3]);
        }
	fclose(in);
	fclose(out);

    in = fopen(file_data_name, "rb");
    out = fopen("data_ram.mif","w");

	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
            binary_out(out,mem);
		break;
	     }
            binary_out(out,mem);
        }
	fclose(in);
	fclose(out);

    in = fopen(file_bin_name, "rb");
    out = fopen("inst_rom.mif","w");

	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
            binary_out(out,mem);
		break;
	     }
            binary_out(out,mem);
        }
	fclose(in);
	fclose(out);

    return 0;
}
