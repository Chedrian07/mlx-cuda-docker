# Dockerfile for MLX on CUDA 12 with Ubuntu 24.04
# Use the official NVIDIA CUDA 12 runtime base image on Ubuntu 24.04:contentReference[oaicite:4]{index=4}
FROM nvidia/cuda:12.9.0-runtime-ubuntu24.04

# Prevent interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install Python3 and pip
# (Ubuntu 24.04 base ensures glibc>=2.35, required by MLX:contentReference[oaicite:5]{index=5})
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# (Optional) Upgrade pip to the latest version
RUN pip3 install --no-cache-dir --upgrade pip

# Install MLX with CUDA support via pip (includes MLX framework and CUDA backend)
# This will pull MLX from PyPI; MLX's docs recommend using "mlx[cuda]" for CUDA support:contentReference[oaicite:6]{index=6}
RUN pip3 install --no-cache-dir "mlx[cuda]"

# (Optional) Install MLX-LM or other MLX extensions if needed, e.g.:
# RUN pip3 install --no-cache-dir mlx-lm

# Set the default command (for demonstration, we'll run nvidia-smi to verify GPU)
CMD ["nvidia-smi"]

