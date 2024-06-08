FC = gfortran
FFLAGS = -g -ffree-line-length-none -fno-range-check

default: main

main: main.F90 target_module
	$(FC) $(FFLAGS) -o main main.F90 target_module.o

target_module: target_module.f90
	$(FC) $(FFLAGS) -c target_module.f90

clean:
	rm -rf *.mod *.o main prose_logs preprocessed_* initial_config.txt *.rmod rose* prose_workspace *postprocessed*