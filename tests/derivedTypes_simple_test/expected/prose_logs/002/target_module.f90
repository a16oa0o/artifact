MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_g_to_a
INTERFACE target_subroutine_wrapper_g_to_a
MODULE PROCEDURE target_subroutine_wrapper_g_to_a
END INTERFACE 
public construct_array_wrapper_04_to_08
INTERFACE construct_array_wrapper_04_to_08
MODULE PROCEDURE construct_array_wrapper_04_to_08
END INTERFACE 
TYPE , PUBLIC :: my_derived_type
private
INTEGER :: array_dim
REAL(kind=8) :: scalar
END TYPE my_derived_type
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=10) :: result
TYPE ( my_derived_type )  :: dt
REAL(kind=4), DIMENSION(:), ALLOCATABLE :: array
INTEGER :: i
dt%array_dim = 3
dt%scalar = 2.0_8
allocate( array(dt%array_dim) )
CALL construct_array_wrapper_04_to_08(array,dt)
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

SUBROUTINE construct_array_wrapper_04_to_08(array,dt)
TYPE ( my_derived_type )  :: dt
REAL(kind=4), DIMENSION(dt%array_dim) :: array
REAL(kind=8), DIMENSION(dt%array_dim) :: array_temp
array_temp = array
CALL construct_array(array=array_temp,dt=dt)
array = array_temp
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_a(result)
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

