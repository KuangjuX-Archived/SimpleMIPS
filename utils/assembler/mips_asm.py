import sys
import asmgen

'''
notice:
    suitable for MIPSel (little endian)
usage:
    $ python3 mips_asm.py asm.s
    or
    $ python3 mips_asm.py asm.s out.[hex/bin]
'''

def main():
    # judge the count of arguments
    if len(sys.argv) < 2:
        exit(1)

    # read arguments
    path = sys.argv[1]
    if len(sys.argv) >= 3:
        bin_path = sys.argv[2]
    else:
        bin_path = path[:path.rfind('.')] + '.bin'

    # generate file
    generator = asmgen.AsmGenerator()
    with open(path, 'r') as f:
        for l in f.readlines():
            line = l.strip()
            if not generator.update(line):
                print('unknown instruction: %s' % line)
                exit(1)

    # output file
    with open(bin_path, 'w') as f:
        f.write(generator.generate() + '\n')

if __name__ == '__main__':
    main()