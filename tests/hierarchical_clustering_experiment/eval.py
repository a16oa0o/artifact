import sys, os

def read_runout(runout_filepath):
    runout = open(runout_filepath)
    line = runout.readline()
    result = float(line.split()[1])
    line = runout.readline()
    time = float(line.split()[1])
    return result, time

if __name__ == "__main__":
    logPath = sys.argv[1]

    initial_result, initial_time = read_runout("000_runout.txt")
    current_result, current_time = read_runout(os.path.join(logPath, "000_runout.txt"))

    # check correctness:
    if abs((current_result-initial_result)/(initial_result)) >= 0.01:
        print(0.0)
    else:
        print(max(float(int(current_time)), 1e-08))