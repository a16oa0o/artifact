#!/usr/bin/env python3

import sys
import os
import subprocess

# process command line args
assert(len(sys.argv) > 1)

target_name = sys.argv[1].lower()
assert(target_name in ["funarc", "mom6", "mpas_1", "mpas_2"])

if target_name != "funarc":
    assert(len(sys.argv) == 3)

    workload_size = sys.argv[2].lower()
    assert(workload_size in ["recommended", "paper"])
    workload_selector = ""
    if workload_size == "recommended":
        workload_selector = "_small"

artifact_path = "/root/artifact"
cmd = [f"docker run --rm -v {os.getcwd()}:{artifact_path} b16oa0o/artifact:env bash -c 'source .venv/bin/activate"]
tuning_targets_path = os.path.join(artifact_path, "submodules")

if target_name == "funarc":
    experiment_path = os.path.join(tuning_targets_path, 'funarc-tuning')
    cmd += [
        f"cd {experiment_path}",
        "prose_check_progress.py > prose_logs/search_log_intermediate.txt",
        "python3 generate_paper_vis.py",
        f"mv funarc.html {os.path.join(artifact_path, 'my_fig2_funarc.html')}",
    ]

elif target_name == "mom6":
    experiment_path = os.path.join(tuning_targets_path, f'MOM6-tuning/experiments/benchmark_zstar{workload_selector}')

    cmd += [
        f"cd {experiment_path}",
        "prose_check_progress.py > prose_logs/search_log_intermediate.txt",
        "cd ..",
        f"python3 generate_figure.py benchmark_zstar{workload_selector}",
        f"mv fig1.html {os.path.join(artifact_path, f'my_fig3_mom6{workload_selector}.html')}",
        f"mv fig2.html {os.path.join(artifact_path, f'my_fig4_mom6{workload_selector}.html')}",
    ]

elif "mpas" in target_name:
    
    if target_name == "mpas_1":
        experiment_selector = "_experiment1"
    elif target_name == "mpas_2":
        experiment_selector = "_experiment2"

    experiment_path = os.path.join(tuning_targets_path, f'MPAS-tuning/experiments/240km_uniform{workload_selector}{experiment_selector}') 

    cmd += [
        f"cd {experiment_path}",
        "prose_check_progress.py > prose_logs/search_log_intermediate.txt",
        "cd ..",
        f"python3 generate_figure.py 240km_uniform{workload_selector}{experiment_selector}",
    ]

    if target_name == "mpas_1":
        cmd += [
            f"mv fig1.html {os.path.join(artifact_path, f'my_fig3_mpas-a{workload_selector}.html')}",
            f"mv fig2.html {os.path.join(artifact_path, f'my_fig4_mpas-a{workload_selector}.html')}",
        ]
    elif target_name == "mpas_2":
        cmd += [
            f"mv fig1.html {os.path.join(artifact_path, f'my_fig5_mpas-a{workload_selector}.html')}",
        ]

n_variants = len([x for x in os.listdir(os.path.join(experiment_path, "prose_logs").replace(artifact_path, ".")) if x.isnumeric()])
response = ""
while response.lower() not in ['y', 'n']:
    response = input(f"# of generated variants so far: {n_variants}\nProceed with generating figure? (y/n): ")
if response.lower() == "n":
    print("\tOk; exiting")
    exit(0)
else:
    cmd = " && ".join(cmd) + "'"
    print(cmd)
    subprocess.run(cmd, shell=True)