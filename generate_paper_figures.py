#!/usr/bin/env python3

import subprocess
import os

cmd = [
    f"docker run --rm -v {os.getcwd()}:/root/artifact b16oa0o/artifact:env",
    "bash -c",
        "'",
            "source .venv/bin/activate &&",
            "pushd ISSTA24_results/ > /dev/null &&",
            "mkdir paper_visualizations &&",
            "for x in $(find -name generate_figure.py); do",
                "echo running $x;",
                "pushd $(dirname $x) > /dev/null;",
                "python3 generate_figure.py . ;",
                # "python3 generate_figure.py . > /dev/null 2>&1;",
                "mv fig1.html /root/ISSTA24_results/paper_visualizations/fig3_$(basename $(dirname $x)).html;",
                "[[ -f fig2.html ]] && mv fig2.html /root/ISSTA24_results/paper_visualizations/fig4_$(basename $(dirname $x)).html;",
                "popd > /dev/null;",
            "done &&",
            "mv paper_visualizations/fig3_mpas_2.html paper_visualizations/fig5_mpas.html &&",
            "mv paper_visualizations/fig3_mpas_1.html paper_visualizations/fig3_mpas.html &&",
            "mv paper_visualizations/fig4_mpas_1.html paper_visualizations/fig4_mpas.html &&",
            "popd > /dev/null &&",
            "mv ISSTA24_results artifact",
        "'"
]
subprocess.run(" ".join(cmd), shell=True)