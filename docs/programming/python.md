
### Python script

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