import os

user_programs = ['add', 'fib', 'leap-year', 'quick-sort', 'prime']

for program in user_programs:
    os.system("make USER_PROGRAM?={}".format(program))