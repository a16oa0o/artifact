PROGRAM main
USE target_module, ONLY : target_subroutine_wrapper_g_to_a
USE target_module, ONLY : target_subroutine
IMPLICIT NONE
REAL(kind=16) :: result
INTEGER :: dummy = 0
CALL target_subroutine_wrapper_g_to_a(result)
    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
PRINT *, "out: ",result
PRINT *, "time: ",dummy
END PROGRAM main

