# docker-pytorch

PyTorch docker image(CPU version) based on alpine

```
# Run Jupyter Notebook container (see token in log)
docker run --rm -p 8888:8888 -v $(pwd):/code smizy/pytorch

# Or use PASSWORD environment variable instead of token
docker run --rm -p 8888:8888 -v $(pwd):/code -e PASSWORD=mysecretpass smizy/pytorch

# open browser
open http://$(docker-machine ip default):8888
```