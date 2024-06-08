MODULE target_module
USE auxiliary_module, ONLY : construct_array
USE auxiliary_type, ONLY : my_derived_type
IMPLICIT NONE
public target_subroutine_wrapper_g_to_a
INTERFACE target_subroutine_wrapper_g_to_a
MODULE PROCEDURE target_subroutine_wrapper_g_to_a
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=10) :: result
TYPE ( my_derived_type )  :: dt
REAL(kind=8), DIMENSION(:), ALLOCATABLE :: array
INTEGER :: i
dt%array_dim = 3
dt%scalar = 2.0_8
allocate( array(dt%array_dim) )
CALL construct_array(array,dt)
result = 0
DO i = 1, dt%array_dim
result = result + array(i)
END DO
deallocate( array )
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_a(result)
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

