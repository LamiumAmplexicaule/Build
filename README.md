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
hipsolver-dev
hipsparse-dev
miopen-hip-dev
rccl-dev
rocblas-dev
rocprim-dev
rocrand-dev
rocthrust-dev
```

### Environment Variables

#### OpenCV

```bash
OPENCV_BRANCH # OPENCV_BRANCH specifies the branch to be cloned. The default is master.
```

#### PyTorch

```bash
PYTORCH_BRANCH # PYTORCH_BRANCH specifies the branch to be cloned. The default is main.
TORCHVISION_BRANCH # TORCHVISION_BRANCH specifies the branch to be cloned. The default is main.
PYTHON # PYTHON specifies the Python command name. The default is python3.
```
