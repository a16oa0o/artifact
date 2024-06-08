PROGRAM main
USE target_module, ONLY : target_subroutine_wrapper_g0_to_a0
USE target_module, ONLY : target_subroutine
USE auxiliary_type, ONLY : my_derived_type
IMPLICIT NONE
REAL(kind=16) :: result
INTEGER :: dummy = 0
TYPE ( my_derived_type )  :: dt
dt%array_dim = 3
CALL target_subroutine_wrapper_g0_to_a0(result,dt)
    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
PRINT *, "out: ",result
PRINT *, "time: ",dummy
END PROGRAM main

