#!/bin/bash

# META_TOPOLOGY_FILE=/.autodirect/mtrsysgwork/ybenabou/ucx/topology_config.txt

export UCX_TLS=rc,cuda_copy \
UCX_RNDV_SCHEME=get_zcopy \
UCC_TL_UCP_TUNE=allreduce:@knomial \
MELLANOX_VISIBLE_DEVICES=0,3,4,5,6,9,10,11 \
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 \
UCX_IB_GID_INDEX=3 \
UCC_CLS=basic UCX_RNDV_THRESH=0 \
UCC_TLS=ucp OMPI_MCA_btl=tcp,self \
OMPI_MCA_btl_tcp_if_include=eno8303 \
LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:/.autodirect/mtrsysgwork/ybenabou/aware/install/lib:$LD_LIBRARY_PATH \
PATH=/.autodirect/mtrsysgwork/ybenabou/aware/install/bin:$PATH

srun --mpi=pmix -p ISR1-PRE -N 14 \
--ntasks-per-node=1 \
--gpus-per-node=1 \
/mtrsysgwork/ybenabou/bind.sh \
/.autodirect/mtrsysgwork/ybenabou/aware/install/bin/ucc_perftest -c allreduce -b 1 -e 512M -d int8 -m cuda -F 

 