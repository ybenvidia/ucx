#!/bin/bash

# setup
# --output=/.autodirect/mtrsysgwork/ybenabou/parallel-collectives-benchmarks/runs/main_ucc_a2a.out \
# --error=/.autodirect/mtrsysgwork/ybenabou/parallel-collectives-benchmarks/runs/main_ucc_a2a.err \
# --container-image /mswg2/E2E/Regression_logs/squash/parallel_collectives_benchmark.sqsh \
# --container-image /.autodirect/mswg2/E2E/Regression_logs/squash/qos-uccx-check.sqsh \
# --container-image /mswg2/E2E/Regression_logs/squash/pytorch-25_02-qos.sqsh
# /.autodirect/mswg2/E2E/Regression_logs/squash/pytorch-25_02-qos_uccx.sqsh
# /.autodirect/mswg2/E2E/Regression_logs/squash/pytorch-25_02.sqsh \
# /.autodirect/mswg2/E2E/Regression_logs/squash/qos-v2.sqsh \
# /.autodirect/mswg2/E2E/Regression_logs/squash/qos.sqsh
# /.autodirect/mswg2/E2E/Regression_logs/squash/pytorch-25_02-no-local-copy.sqsh
# /opt/hpcx/ucc/bin/ucc_perftest -n 50 -w 20 -c allgather -b 1 -e 32M -m cuda -T -F -d int8
# python /workspace/parallel_collectives_benchmark/main.py /tmp/config.yaml
# UCC_CL_BASIC_TLS=ucp,^cuda,^nccl \
# UCC_CONFIG_FILE= \
# UCX_LOG_LEVEL=info \
# UCX_LOG_PRINT_ENABLE=y \
# UCC_LOG_LEVEL=debug \
# UCC_TL_UCP_ALLGATHER_KN_RADIX=2 \
# UCC_TL_UCP_TUNE=allgather:@0 \
# UCC_COLL_TRACE=info \
# NCCL_P2P_DISABLE=1 \
# NCCL_SHM_DISABLE=1 \
# NCCL_PXN_DISABLE=1 \
# NCCL_SOCKET_IFNAME=eno8303 \
# UCC_TL_MLX5_TUNE=0 \
# UCC_TL_NCCL_TUNE=0 \

export MPLCONFIGDIR=/.autodirect/mtrsysgwork/ybenabou/.config/matplotlib \
MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1) \
MASTER_PORT=12340 \
OMPI_MCA_btl=tcp,self \
OMPI_MCA_btl_tcp_if_include=eno03 \
UCX_IB_GID_INDEX=auto \
UCC_TL_UCP_ALLGATHER_KN_RADIX=2 \
UCC_TL_UCP_TUNE=allgather:@0 \
UCC_CLS=basic \
UCC_TLS=ucp \
UCX_TLS=rc,cuda_copy \
UCC_TL_MLX5_TUNE=0 \
UCC_TL_NCCL_TUNE=0 \
UCC_LOG_LEVEL=debug \
UCX_LOG_LEVEL=debug \
MELLANOX_VISIBLE_DEVICES=0,3,4,5,6,9,10,11 \
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 \
UCC_CL_BASIC_TLS=ucp \
UCX_RNDV_SCHEME=get_zcopy

export LD_LIBRARY_PATH="/mtrsysgwork/ybenabou/qos/lib:$LD_LIBRARY_PATH"

srun -p GAIA -N 1 \
--ntasks=8 \
--gpus=8 \
/.autodirect/mtrsysgwork/ybenabou/bind.sh \
/mtrsysgwork/ybenabou/qos/bin/ucc_perftest -n 50 -w 20 -c allgather -b 1 -e 32M -m cuda -T -F -d int8
