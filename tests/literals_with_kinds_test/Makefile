FC = gfortran
FFLAGS = -ffree-line-length-none -fno-range-check -fdefault-real-8

default: main

main: main.f90 target_module
	$(FC) $(FFLAGS) -o main main.f90 target_module.o

target_module: target_module.f90
	$(FC) $(FFLAGS) -c target_module.f90

clean:
	rm -rf *.mod *.o main prose_logs preprocessed_* initial_config.txt *.rmod rose* prose_workspace