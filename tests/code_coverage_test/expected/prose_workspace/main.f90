PROGRAM main
USE target_module, ONLY : target_subroutine
IMPLICIT NONE
REAL(kind=16) :: result = 0
INTEGER :: dummy
DO dummy = 1, 2
CALL target_subroutine(result)
END DO
    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
PRINT *, "out: ",result
PRINT *, "time: ",dummy
END PROGRAM main

