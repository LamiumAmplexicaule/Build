# Build

Build script collection

- nvtop
- opencv
- pytorch

## Requiremetns

### OpenCV

```
cuda
```

### PyTorch

#### ROCm

```
hipcub-dev
hipfft-dev
hipsparse-dev
miopen-hip-dev
rccl-dev
rocblas-dev
rocprim-dev
rocrand-dev
hipsolver-dev
rocthrust-dev
```

### Environment Variables

#### OpenCV

```bash
OPENCV_BRANCH # OPENCV_BRANCH specifies the branch to be cloned. The default is is master.
```

#### PyTorch

```bash
PYTORCH_BRANCH # OPENCV_BRANCH specifies the branch to be cloned. The default is is main.
PYTHON # PYTHON specifies the Python command name. The default is python3.
```
