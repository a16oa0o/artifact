MODULE target_module
USE auxiliary_module, ONLY : construct_array
USE auxiliary_type, ONLY : my_derived_type
IMPLICIT NONE
public target_subroutine_wrapper_g0_to_a0
INTERFACE target_subroutine_wrapper_g0_to_a0
MODULE PROCEDURE target_subroutine_wrapper_g0_to_a0
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result,dt)
REAL(kind=10) :: result
TYPE ( my_derived_type )  :: dt
REAL(kind=8), DIMENSION(dt%array_dim) :: array
INTEGER :: i
dt%scalar = 2.0_8
CALL construct_array(array)
result = 0
DO i = 1, dt%array_dim
result = result + array(i)
END DO
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g0_to_a0(result,dt)
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
TYPE ( my_derived_type )  :: dt
result_temp = result
CALL target_subroutine(result=result_temp,dt=dt)
result = result_temp
END SUBROUTINE 

END MODULE target_module

