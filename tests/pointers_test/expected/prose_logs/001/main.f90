PROGRAM main
USE target_module, ONLY : target_subroutine_wrapper_8g_to_4a
USE target_module, ONLY : target_subroutine
IMPLICIT NONE
REAL(kind=16) :: result
INTEGER :: dummy = 0
REAL(kind=8), DIMENSION(2,2,4) :: array2
array2 = reshape((/3.5_8,6.0_8,2.5_8,2.0_8,6.5_8,4.0_8,4.5_8,3.0_8,5.5_8,6.0_8,6.5_8,4.0_8,7.5_8,8.0_8,8.5_8,5.0_8/),(shape(array2))&
,order=(/3,2,1/))
CALL target_subroutine_wrapper_8g_to_4a(result,array2)
    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
PRINT *, "out: ",result
PRINT *, "time: ",dummy
END PROGRAM main

