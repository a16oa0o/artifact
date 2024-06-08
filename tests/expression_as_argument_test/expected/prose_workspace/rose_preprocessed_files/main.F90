# 1 "/glade/u/home/jdvanover/precimonious-w-rose/tests/expression_as_argument_test/prose_workspace/prose_workspace-b277e6a1.F90"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/glade/u/home/jdvanover/precimonious-w-rose/tests/expression_as_argument_test/prose_workspace/prose_workspace-b277e6a1.F90"
PROGRAM main
USE target_module, ONLY : target_subroutine
IMPLICIT NONE
REAL(kind=8) :: result
INTEGER :: dummy = 0
CALL target_subroutine(result)
    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
PRINT *, "out: ",result
PRINT *, "time: ",dummy
END PROGRAM main

