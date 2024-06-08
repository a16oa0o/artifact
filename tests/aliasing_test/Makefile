FC = gfortran
FFLAGS = -ffree-line-length-none -fno-range-check

default: main

main: main.f90 target_module
	$(FC) $(FFLAGS) -o main main.f90 target_module.o auxiliary_module_1.o auxiliary_module_2.o auxiliary_module_3.o 

target_module: target_module.f90 auxiliary_modules
	$(FC) $(FFLAGS) -c target_module.f90

auxiliary_modules: auxiliary_module_1 auxiliary_module_3 auxiliary_module_2

auxiliary_module_1: auxiliary_module_1.f90
	$(FC) $(FFLAGS) -c auxiliary_module_1.f90

auxiliary_module_2: auxiliary_module_2.f90
	$(FC) $(FFLAGS) -c auxiliary_module_2.f90

auxiliary_module_3: auxiliary_module_3.f90
	$(FC) $(FFLAGS) -c auxiliary_module_3.f90

clean:
	rm -rf *.mod *.o main prose_logs preprocessed_* initial_config.txt *.rmod rose* prose_workspace