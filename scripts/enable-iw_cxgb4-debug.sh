#!/bin/bash

#All
function all_print()
{
	local p=$1
	echo -n "module iw_cxgb4 ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo "all prints: ${p}"
}

#Connection & config
function config_print()
{
	local p=$1
	echo -n "file drivers/infiniband/hw/cxgb4/cm.c ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "file drivers/infiniband/hw/cxgb4/device.c ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "file drivers/infiniband/hw/cxgb4/provider.c ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func rdma_init ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func build_rtr_msg ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func rdma_fini ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func post_terminate ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_ib_modify_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_modify_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo "config prints: ${p}"
}

#Mem 
function mem_print()
{
	local p=$1
	echo -n "file drivers/infiniband/hw/cxgb4/mem.c ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "file drivers/infiniband/hw/cxgb4/resource.c ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo "mem prints: ${p}"
}

#IO
function io_print()
{
	local p=$1
	echo -n "func poll_cq ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_poll_cq_one ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func flush_completed_wrs ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_count_rcqes ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_flush_hw_cq ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_flush_rq ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func insert_recv_cqe ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func insert_sq_cqe ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func __flush_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_post_send ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_post_receive ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "file drivers/infiniband/hw/cxgb4/ev.c ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo "io prints: ${p}"
}

#Resource 
function resource_print()
{
	local p=$1
	echo -n "func c4iw_destroy_cq ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_create_cq ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func create_cq ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_create_cq ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_qp_add_ref ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_qp_rem_ref ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func queue_qp_free ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_destroy_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_create_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func free_qp_work ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func create_qp  ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_get_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_ib_modify_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo -n "func c4iw_modify_qp ${p}f" > /sys/kernel/debug/dynamic_debug/control
	echo "resource prints: ${p}"
}

OPTIND=1

# Initialize our own variables:
pctl=""

while getopts "h?a:c:m:i:r:" opt; do
    case "$opt" in
    h|\?)
				echo -e "\tUsage:"
        echo -e "\t-a <1/0>\t - Enable/Disable all iw_cxgb4 prints"
        echo -e "\t-c <1/0>\t - Enable/Disable only Config/Connection path prints"
        echo -e "\t-i <1/0>\t - Enable/Disable only IO path prints"
        echo -e "\t-m <1/0>\t - Enable/Disable only Memory alloc/dealloc path prints"
        echo -e "\t-r <1/0>\t - Enable/Disable only RDMA Resource alloc/dealloc path prints"
        echo -e "\t-h      \t - help"
				echo -e "\t Ex: sh enable_debug.sh -c1 -m1"
        exit 0
        ;;
    a)  if [[ $OPTARG == "0" ]];then
					pctl="-p"
				else
					pctl="+p"
				fi
				all_print $pctl
        ;;
    c)  if [[ $OPTARG == "0" ]];then
					pctl="-p"
				else
					pctl="+p"
				fi
				config_print $pctl
        ;;
    i)  if [[ $OPTARG == "0" ]];then
					pctl="-p"
				else
					pctl="+p"
				fi
				io_print $pctl
        ;;
    m)  if [[ $OPTARG == "0" ]];then
					pctl="-p"
				else
					pctl="+p"
				fi
				mem_print $pctl
        ;;
    r)  if [[ $OPTARG == "0" ]];then
					pctl="-p"
				else
					pctl="+p"
				fi
				resource_print $pctl
        ;;
    esac
done

