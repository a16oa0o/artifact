import subprocess
import os

subprocess.run(["profmerge", "-prof_dir", "prose_workspace/profiling"])
subprocess.run(["codecov", "-txtlcov", "-spi", "prose_workspace/profiling/pgopti.spi", "-dpi", "prose_workspace/profiling/pgopti.dpi"])
subprocess.run(["mv", "CodeCoverage", "prose_workspace/profiling/code_coverage"])
subprocess.run(["mv", "CODE_COVERAGE.TXT", "prose_workspace/profiling"])

file_paths = [os.path.join("prose_workspace/profiling/code_coverage",x) for x in os.listdir("prose_workspace/profiling/code_coverage") if x.endswith(".LCOV")]

for file_path in file_paths:
    
    with open(file_path, "r") as f:
        lines = f.readlines()

    count_dict = {}
    for line in lines:
        line_collection = line.split(':')
        count = -1
        line_no = -1

        if line_collection[0].strip() == "#####":
            count = 0

        try:
            line_no = int(line_collection[1])
            count = int(line_collection[0])
        except ValueError:
            pass

        if line_no > 0:

            # when would this happen?
            if line_no in count_dict.keys():
                if count >= 0:
                    count_dict[line_no] = count_dict[line_no] + count
            else:
                count_dict[line_no] = count

    outfile_name = file_path[:file_path.rfind(".")] + ".bcov"
    with open(outfile_name, "w") as f:
        for line_no, count in count_dict.items():
            f.write(f"{line_no}:{count}\n")