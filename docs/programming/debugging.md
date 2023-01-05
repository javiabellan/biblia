# Debugging


## Debugging in Python:

- `print()`: too simple
- `import pdb; pdb.set_trace()`: too complex
- `import code; code.interact(local=locals())`: just right
simply drops you into interpreter, perfect for 95% of debugging

https://twitter.com/karpathy/status/1610822271157022720



## Python debugging: `ipdb`
Start the debugger:
- `python -m pdb  my_program.py`
- `python -m ipdb my_program.py`

Debugger commands:
- `s`: step
- `c`: countiue until ends or break
- `p var1`: print value of var1
- `p var1,var2`: print value of var1 and var2
- `p locals()`: print value of all vars
- `l`: list code and see lines
- `b 6`: create a break point at line 6
- `q`: Quit the debugger

## C/C++ debugging
- [gdb](https://www.gnu.org/software/gdb/)


