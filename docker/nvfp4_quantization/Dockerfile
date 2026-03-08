FROM nvcr.io/nvidia/pytorch:25.12-py3

RUN pip install -U datasets huggingface_hub accelerate transformers
RUN pip install llmcompressor --no-deps 
RUN pip install loguru compressed_tensors
RUN git clone https://github.com/ealexeev/llm-quantization /workspace/llm-quantization

# Silence VLLM warnings
ENV TOKENIZERS_PARALLELISM=false

# Faster vLLM loading: https://docs.vllm.ai/en/v0.9.2/models/extensions/fastsafetensor.html
ENV USE_FASTSAFETENSOR=true
ENV SAFETENSORS_FAST_GPU=1

# Force huggingface to not DL anything, this should not happen from within a container
ENV HF_HUB_OFFLINE=1
