# docker-pytorch
[![](https://images.microbadger.com/badges/image/smizy/pytorch.svg)](https://microbadger.com/images/smizy/pytorch "Get your own image badge on microbadger.com") 
[![](https://images.microbadger.com/badges/version/smizy/pytorch.svg)](https://microbadger.com/images/smizy/pytorch "Get your own version badge on microbadger.com")
[![CircleCI](https://circleci.com/gh/smizy/docker-pytorch.svg?style=svg)](https://circleci.com/gh/smizy/docker-pytorch)

PyTorch docker image(CPU version) based on alpine

```
# Run Jupyter Notebook container (see token in log)
docker run --rm -p 8888:8888 -v $(pwd):/code smizy/pytorch

# Or use PASSWORD environment variable instead of token
docker run --rm -p 8888:8888 -v $(pwd):/code -e PASSWORD=mysecretpass smizy/pytorch

# open browser
open http://$(docker-machine ip default):8888
```