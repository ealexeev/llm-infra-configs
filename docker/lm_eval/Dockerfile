FROM nvcr.io/nvidia/vllm:26.02-py3

RUN pip install --no-deps lm_eval[vllm]
RUN pip install -U dill evaluate jsonlines more_itertools numexpr peft pybind11 pytablewriter rouge-score sacrebleu scikit-learn  sqlitedict tqdm-multiprocess  word2number zstandard langdetect immutabledict

# Upgrade to latest transformers to allow latest models.
# RUN pip install git+https://github.com/huggingface/transformers.git

# Faster vLLM loading: https://docs.vllm.ai/en/v0.9.2/models/extensions/fastsafetensor.html
ENV USE_FASTSAFETENSOR=true
ENV SAFETENSORS_FAST_GPU=1

# NCCL interface ids to define interconnect

ENV OMPI_MCA_btl_tcp_if_include=enp1s0f1np1
ENV NCCL_SOCKET_IFNAME=enp1s0f1np1
ENV UCX_NET_DEVICES=enp1s0f1np1

# NCCL optimizations:  https://docs.nvidia.com/deeplearning/nccl/user-guide/docs/env.html
ENV NCCL_SOCKET_NTHREADS=4
ENV NCCL_DEBUG=INFO
ENV NCCL_DEBUG_FILE="/tmp/nccl_debug.log"

# Ray extended timeout
ENV RAY_CGRAPH_get_timeout=1200

# Force huggingface to not DL anything, this should not happen from within a container
ENV HF_HUB_OFFLINE=1

# Install ray cluster start up script.
COPY --chmod=755 common/start_ray.sh /usr/local/bin/

# DGX Spark CPU count
ENV NUMEXPR_MAX_THREADS=20

# Default value to start as a non-head node
ENV RAY_NODE_TYPE="other"

ENTRYPOINT [ "/usr/local/bin/start_ray.sh", "start"]

