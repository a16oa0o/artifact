# 1 "/glade/u/home/jdvanover/precimonious-w-rose/tests/constant_as_argument_test/prose_workspace/prose_workspace-6e3e8c59.F90"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/glade/u/home/jdvanover/precimonious-w-rose/tests/constant_as_argument_test/prose_workspace/prose_workspace-6e3e8c59.F90"
PROGRAM main
USE TARGET_MODULE, ONLY : target_subroutine
IMPLICIT NONE
REAL(kind=8) :: result
REAL(kind=16), PARAMETER :: pconstant = 1e-3
INTEGER :: dummy = 0
CALL target_subroutine(result,pconstant)
    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
PRINT *, "out: ",result
PRINT *, "time: ",dummy
END PROGRAM main

