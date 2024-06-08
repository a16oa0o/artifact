PROGRAM main
USE target_module, ONLY : target_subroutine
IMPLICIT NONE
REAL(kind=16) :: result
INTEGER :: dummy = 0
REAL, DIMENSION(2,2,4) :: array2
array2 = reshape((/3.5,6.0,2.5,2.0,6.5,4.0,4.5,3.0,5.5,6.0,6.5,4.0,7.5,8.0,8.5,5.0/),(shape(array2)),order=(/3,2,1/))
CALL target_subroutine(result,array2)
    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
PRINT *, "out: ",result
PRINT *, "time: ",dummy
END PROGRAM main

