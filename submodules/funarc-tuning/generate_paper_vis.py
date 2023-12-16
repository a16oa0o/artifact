# %%
import pandas as pd
import numpy as np
import plotly.express as px
import os
from glob import glob
import plotly.graph_objects as go

# %%
def plot_performance_vs_correctness(df, emphasis):
    
    df_plot = df.dropna()
    
    baseline_cost = df[(df['Configuration Number'] == 0)]['Cost'].iloc[0]
    baseline_output = df[(df['Configuration Number'] == 0)]['Output'].iloc[0]
    df_plot = df_plot.assign(Improvement = baseline_cost/df_plot['Cost'])
    df_plot = df_plot.assign(Error = ((baseline_output - df_plot['Output'])/baseline_output).abs())

    if emphasis:

        fig = px.scatter(
            df_plot[ (df_plot['Configuration Number'] != 0) & (df_plot['Configuration Number'] != 1) ],
            x="Improvement",
            y="Error",
            color = "Label",
            color_discrete_sequence = [px.colors.qualitative.Plotly[1], px.colors.qualitative.Plotly[0]],
            hover_data = ['Configuration Number'],
        )

        if not df_plot[df_plot["Configuration Number"] == 1].empty:
            fig.add_trace(
                go.Scatter(
                    x = df_plot[df_plot["Configuration Number"] == 1]["Improvement"],
                    y = df_plot[df_plot["Configuration Number"] == 1]["Error"],
                    mode = "markers",
                    marker_symbol = 'star',
                    marker_size = 20,
                    marker_color = "red",
                    marker_line_width = 1,
                    marker_line_color = "black",
                    name = "Uniform 32-bit"
                )
            )

        if not df_plot[df_plot["Configuration Number"] == 0].empty:
            fig.add_trace(
                go.Scatter(
                    x = df_plot[df_plot["Configuration Number"] == 0]["Improvement"],
                    y = df_plot[df_plot["Configuration Number"] == 0]["Error"],
                    mode = "markers",
                    marker_symbol = 'star',
                    marker_size = 20,
                    marker_color = "blue",
                    marker_line_width = 1,
                    marker_line_color = "black",
                    name = "Uniform 64-bit"
                )
            )
    
        fig.update_traces(
            marker={
                'size' : 14,
                'line_width' : 1,
                'line_color' : "black",
            }
        )

    else:

        fig = px.scatter(
            df_plot[ (df_plot['Configuration Number'] != 0) & (df_plot['Configuration Number'] != 1) ],
            x="Improvement",
            y="Error",
            hover_data = ['Configuration Number'],
        )

        fig.update_traces(
            marker={
                'size' : 14,
                'opacity' : 0.1,
                'color' : "black"
            },
            showlegend = False,
        )

    fig.add_vline(x=1.0, line_width=2, line_dash="dash", line_color="grey")

    fig.update_layout(
        width = 600,
        height = 400,
        title=dict(
            text = "funarc",
            y = 0.95,
            x = 0.15,
            xanchor = 'left',
            yanchor = 'top',
        ),
        yaxis_tickformat = ".0e",
        xaxis_tickformat = ".1f",
        xaxis_ticksuffix = "x",
        xaxis_title = "Speedup",
        yaxis_title = "Relative Error",
        font_size = 20,
        legend = dict(
            bgcolor = "#E5ECF6",
            entrywidth = 130,
            orientation = "h",
            yanchor = "bottom",
            xanchor = "right",
            x = 1.0,
            y = 1.02,
            title_text = ""
        ),
        margin = dict(
            r = 0,
            t = 0,
            b = 0,
            l = 0,
        )
    )

    return fig


def plot_label_frequency(df):

    fig = px.histogram(
        df,
        x = "Label",
    )
    fig.update_layout(
        font_size = 18
    )
    
    return fig


def get_funarc_data(search_log_path):
    
    with open(search_log_path, "r") as f:
        search_log_lines = f.readlines()

    df = []
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

        if "[PASSED]" in line:
            row['Label'] = "Passed"
            row['Cost'] = float(line.split()[4])
        elif "error threshold was exceeded" in line:
            row['Label'] = "Failed"
            row['Cost'] = float(line.split()[4])
        elif "(timeout)" in line:
            row['Label'] = "Timeout"
            row['Cost'] = float(line.split()[4])
        elif "(runtime failure)" in line:
            row['Label'] = "Runtime Error"
            row['Cost'] = np.nan
        elif "(compilation error)" in line:
            row['Label'] = 'Compilation Error'
            row['Cost'] = np.nan
        elif "(plugin error)" in line:
            row['Label'] = 'Prose Plugin Error'
            row['Cost'] = np.nan
        else:
            continue

        try:
            with open(os.path.join(config_dir_path,"outlog.txt"), "r") as f:
                
                line = f.readlines()[0]
                if line.startswith(" out:"):
                    row["Output"] = float(line.strip().split()[-1])
                else:
                    row["Output"] = np.nan

        except (FileNotFoundError, IndexError):
            row["Output"] = np.nan

        df.append(row)

    return pd.DataFrame(df)

# %%
try:
    df_brute = get_funarc_data("./prose_logs/search_log.txt")
except FileNotFoundError:
    df_brute = get_funarc_data("./prose_logs/search_log_intermediate.txt")

# %%
fig = plot_performance_vs_correctness(df_brute, emphasis=False)
fig.write_html("funarc.html")
