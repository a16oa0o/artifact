# %%
import pandas as pd
import numpy as np
import plotly.express as px
import plotly.graph_objects as go
import os
from glob import glob
import xarray as xr
from copy import deepcopy
import subprocess
import pickle
import sys
from plotly.subplots import make_subplots

# %%

def plot_performance_vs_correctness_L2(df, error_type, error_threshold):
    
    df_plot = df.dropna(subset=["Cost", f"{error_type}, Relative Error (L2 Norm)"])

    baseline_cost = df[(df['Configuration Number'] == 0)]['Cost'].iloc[0]
    
    fig = px.scatter(
        df_plot,
        x = "Improvement",
        y = f"{error_type}, Relative Error (L2 Norm)",
        color = '32-bit %',
        hover_data = ['Configuration Number'],
        log_y=True,
    )
    fig.update_traces(
        marker={
            'size' : 14,
            'opacity' : 0.5,
            'line_width' : 1,
            'line_color' : "black",
        }
    )
    if not df_plot[df_plot["Configuration Number"] == 1].empty:
        fig.add_trace(
            go.Scatter(
                x = df_plot[df_plot["Configuration Number"] == 1]["Improvement"],
                y = df_plot[df_plot["Configuration Number"] == 1][f"{error_type}, Relative Error (L2 Norm)"],
                mode = "markers+text",
                marker_symbol = 'circle-open',
                marker_size = 14,
                marker_color = "black",
                marker_line_width = 3,
                marker_line_color = "black",
                name = "Uniform 32-bit",
                showlegend=False,
                text=["Uniform 32-bit"],
                textposition=["top right"],
            )
        )

    fig.update_layout(
        title_text = "MPAS-A",
        coloraxis_showscale = True,
        yaxis_tickformat = ".0e",
        xaxis_tickformat = ".1f",
        xaxis_ticksuffix = "x",
        xaxis_title = "",
        yaxis_title = "Relative Error",
        coloraxis={
            "cmin" : 0,
            "cmax" : 100,
            "colorbar" : {
                'title' : "% 32-bit<br>(Hotspot)",
            },
        },
    )

    fig.add_vline(x=1.0, line_width=2, line_dash="dash", line_color="grey")
    fig.add_hline(y=error_threshold, line_width=2, line_dash="dash", line_color="grey")

    return fig


def get_MPAS_data(search_log_path):

    with open(search_log_path, "r") as f:
        search_log_lines = f.readlines()

    df_entire = []
    df_subset = []
    for line in search_log_lines:
        row = {}

        try:
            row['Configuration Number'] = int(line.split(":")[0])
        except ValueError:
            continue
        config_dir_path = os.path.join(os.path.dirname(search_log_path), f"{row['Configuration Number']:0>4}")

        config_path = glob(f"{config_dir_path}/config*")
        assert ( len(config_path) == 1)
        row['Configuration Path'] = config_path[0]

        float_count = 0
        double_count = 0
        with open(row['Configuration Path'], "r" ) as f:
            llines = f.readlines()
            for lline in llines:
                if ",4" in lline:
                    float_count += 1
                elif ",8" in lline:
                    double_count += 1

        row['32-bit %'] = 100*(float_count / (double_count + float_count))

        if "[PASSED]" in line:
            row['Label'] = "Passed"
        elif "error threshold was exceeded" in line:
            row['Label'] = "Exceeded Error Threshold"
        elif "(timeout)" in line:
            row['Label'] = "Timeout"
        elif "(runtime failure)" in line:
            row['Label'] = "Runtime Error"
        elif "(compilation error)" in line:
            row['Label'] = 'Compilation Error'
        elif "(plugin error)" in line:
            row['Label'] = 'Prose Plugin Error'
        else:
            continue

        try:
            errors_df = pd.read_pickle(os.path.join(config_dir_path, "errors.pckl"))
            row["Kinetic energy at a cell center, Relative Error (L2 Norm)"] = np.linalg.norm(errors_df["ke"], ord=2)
        except FileNotFoundError:
            row["Kinetic energy at a cell center, Relative Error (L2 Norm)"] = np.nan

        try:
            row['Cost'] = float(line.split()[4])
        except ValueError:
            try:
                row['Cost'] = float(line.split()[5])
            except ValueError:
                row['Cost'] = np.nan

        df_entire.append(deepcopy(row))

        try:
            with open(os.path.join(config_dir_path, "gptl_subset_info.pckl"), "rb") as f:
                gptl_subset_info = pickle.load(f)

            subprocess.run(
                f"tar -xvf gptl_timing.tar.gz",
                shell = True,
                cwd = config_dir_path,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
            )

            execution_counts = {}
            with open(os.path.join(config_dir_path, "timing.000000"), "r") as f:
                for line in f.readlines():
                    if line[2:].lstrip().startswith("::"):
                        procedure_name = line[2:].split()[0].strip().lower()
                        execution_count = float(line[2:].split()[1].strip())
                        execution_counts[procedure_name] = execution_count

            subprocess.run(
                f"rm timing.*",
                shell = True,
                cwd = config_dir_path,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
            )

            for key, value in gptl_subset_info.items():
                row['Procedure Name'] = key
                row['CPU Time'] = value
                try:
                    row["Execution Count"] = execution_counts[row['Procedure Name'].lower()]
                except KeyError:
                    row["Execution Count"] = np.nan
                float_count = 0
                double_count = 0
                config_hash = ""
                with open(row['Configuration Path'], "r" ) as f:
                    llines = f.readlines()
                    for lline in llines:
                        if lline.strip().lower().startswith(key.lower() + "::"):
                            if ",4" in lline:
                                float_count += 1
                                config_hash = config_hash + "4"
                            elif ",8" in lline:
                                double_count += 1
                                config_hash = config_hash + "8"
                
                row["config_hash"] = hash(config_hash)

                try:
                    row['32-bit %'] = 100*(float_count / (double_count + float_count))
                except Exception as e:
                    row['32-bit %'] = np.nan

                df_subset.append(deepcopy(row))

        except FileNotFoundError:
            continue

    return pd.DataFrame(df_entire), pd.DataFrame(df_subset)

# %%
try:
    df_entire, df_subset = get_MPAS_data(os.path.join(sys.argv[1],"prose_logs/search_log.txt"))
except FileNotFoundError:
    try:
        df_entire, df_subset = get_MPAS_data(os.path.join(sys.argv[1],"prose_logs/search_log_intermediate.txt"))
    except FileNotFoundError:
        df_entire, df_subset = get_MPAS_data(glob(os.path.join(sys.argv[1], "prose_logs/*search_log*.txt"))[0])


# %%
fig = plot_performance_vs_correctness_L2(df_entire, error_type="Kinetic energy at a cell center", error_threshold=140.47898543748735)
fig.write_html("fig1.html")

# %%

if len(df_subset) > 0:

    df_subset["Average CPU Time Per Call"] = df_subset["CPU Time"] / df_subset["Execution Count"]
    for procedure_name in df_subset[df_subset["Procedure Name"].str.contains("::")]["Procedure Name"].unique():
        for config_hash in df_subset[df_subset["Procedure Name"] == procedure_name]["config_hash"].unique():
            df_subset.loc[(df_subset["Procedure Name"] == procedure_name) & (df_subset["config_hash"] == config_hash), "Average CPU Time Per Call"] = df_subset.loc[(df_subset["Procedure Name"] == procedure_name) & (df_subset["config_hash"] == config_hash), "Average CPU Time Per Call"].mean()

    baseline_costs = {
        '::atm_time_integration::atm_recover_large_step_variables_work': 5.636109375,
        '::atm_time_integration::atm_compute_solve_diagnostics_work': 5.1494765625,
        '::atm_time_integration::atm_compute_dyn_tend_work': 5.122546875,
        '::atm_time_integration::atm_advance_acoustic_step_work': 2.343265625,
        '::atm_time_integration::atm_advance_scalars_work': 1.619515625,
        '::atm_time_integration::atm_advance_scalars_mono_work': 1.5976249999999999,
        '::atm_time_integration::atm_set_smlstep_pert_variables_work': 1.20053125,
        '::atm_time_integration::fluxes': 0.6117890625,
        '::atm_time_integration::atm_compute_vert_imp_coefs_work': 0.45317968750000004
    }

    procedure_percentages = {
        '::atm_time_integration::atm_recover_large_step_variables_work': "23.9",#23.85573770006054,
        '::atm_time_integration::atm_compute_solve_diagnostics_work': "21.7",#21.700467145964527,
        '::atm_time_integration::atm_compute_dyn_tend_work': "21.5",#21.513575486114263,
        '::atm_time_integration::atm_advance_acoustic_step_work': "9.9",#9.919105842657316,
        '::atm_time_integration::atm_advance_scalars_work': "6.8",#6.83143553651823,
        '::atm_time_integration::atm_advance_scalars_mono_work': "6.7",#6.694520671454317,
        '::atm_time_integration::atm_set_smlstep_pert_variables_work': "5.1",#5.1078795517645865,
        '::atm_time_integration::fluxes': "2.6",#2.598569413169517,
        '::atm_time_integration::atm_compute_vert_imp_coefs_work': "1.9",#1.9165194230321565
    }

    fig = make_subplots(len(baseline_costs),1, subplot_titles=tuple([f'{x[x.rfind(":") + 1:]} ({procedure_percentages[x]}%)' for x in baseline_costs.keys()]), shared_xaxes=True)
    for i, procedure_name in enumerate(baseline_costs.keys()):
        df_plot = df_subset[df_subset["Procedure Name"] == procedure_name]
        baseline_cost = df_plot[df_plot["Configuration Number"] == 0]["Average CPU Time Per Call"].values[0]
        df_plot = df_plot.assign(Improvement = baseline_cost/df_plot['Average CPU Time Per Call'])
        df_plot = df_plot.drop_duplicates(subset=["config_hash"])
        fig.add_trace(
            go.Scatter(
                x = df_plot["Improvement"],
                y = np.random.rand(len(df_subset)),
                mode = 'markers',
                customdata=df_plot["Configuration Number"],
                hovertemplate="%{customdata}",
                marker = dict(
                    size = 10,
                    color=df_plot["32-bit %"],
                    line_width = 1,
                    line_color = "black",
                    opacity = 0.6,
                    coloraxis="coloraxis1",
                    symbol = "diamond",
                ),
                showlegend=False
            ),
            i + 1,
            1
        )
        if i == 0:
            fig.update_traces(
                marker_colorbar_title = "% 32-bit",
                marker_colorscale = "Plasma",
            )

    fig.update_layout(
        coloraxis_showscale=True,
        showlegend = False,
        title_text = "MPAS-A",
        coloraxis={
            "cmin" : 0,
            "cmax" : 100,
            "colorbar" : {
                'title' : "% 32-bit<br>(Procedure)",
            },
        },
    )

    fig.update_xaxes(ticksuffix="x")
    fig.update_xaxes(title="Speedup", row=len(baseline_costs), col=1)
    fig.update_yaxes(visible=False)
    fig.update_annotations(yshift=-5, font_size=18)
    fig.add_vline(x=1.0, line_width=2, line_dash="dash", line_color="grey")
    fig.write_html("fig2.html")