# Python


## Install software

## PIP: `pip install --user package`

Note we’ve installed here using the user flag to install this Python package only for the current user. However, you might prefer to use a tool like pipx to install Python applications in an isolated environment.

## Conda

Conda is SLOOOOOOOW. If you really need to use conda you can use **Mamba**



## Python script

```python
#!/usr/bin/python
import sys
for arg in reversed(sys.argv[1:]):
    print(arg)
```


## IO Redirection `<` `>`

```python
import sys, numpy

sys.stdout.buffer.write(a.data)
numpy.savetxt( sys.stdout.buffer, a  )
```