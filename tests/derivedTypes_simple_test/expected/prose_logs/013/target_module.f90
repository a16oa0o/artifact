MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_g_to_8
INTERFACE target_subroutine_wrapper_g_to_8
MODULE PROCEDURE target_subroutine_wrapper_g_to_8
END INTERFACE 
TYPE , PUBLIC :: my_derived_type
private
INTEGER :: array_dim
REAL(kind=8) :: scalar
END TYPE my_derived_type
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
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

SUBROUTINE construct_array(array,dt)
TYPE ( my_derived_type )  :: dt
REAL(kind=8), DIMENSION(dt%array_dim) :: array
INTEGER :: i
DO i = 1, dt%array_dim
array(i) = dt%scalar ** (i - 1)
END DO
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_8(result)
REAL(kind=16) :: result
REAL(kind=8) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

