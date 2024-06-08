MODULE target_module
IMPLICIT NONE
public construct_array_wrapper_08_to_04
INTERFACE construct_array_wrapper_08_to_04
MODULE PROCEDURE construct_array_wrapper_08_to_04
END INTERFACE 
TYPE , PUBLIC :: my_derived_type
private
INTEGER :: array_dim
REAL(kind=4) :: scalar
END TYPE my_derived_type
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=16) :: result
TYPE ( my_derived_type )  :: dt
REAL(kind=8), DIMENSION(:), ALLOCATABLE :: array
INTEGER :: i
dt%array_dim = 3
dt%scalar = 2.0_4
allocate( array(dt%array_dim) )
CALL construct_array_wrapper_08_to_04(array,dt)
result = 0
DO i = 1, dt%array_dim
result = result + array(i)
END DO
deallocate( array )
END SUBROUTINE 

SUBROUTINE construct_array(array,dt)
TYPE ( my_derived_type )  :: dt
REAL(kind=4), DIMENSION(dt%array_dim) :: array
INTEGER :: i
DO i = 1, dt%array_dim
array(i) = dt%scalar ** (i - 1)
END DO
END SUBROUTINE 

SUBROUTINE construct_array_wrapper_08_to_04(array,dt)
TYPE ( my_derived_type )  :: dt
REAL(kind=8), DIMENSION(dt%array_dim) :: array
REAL(kind=4), DIMENSION(dt%array_dim) :: array_temp
array_temp = array
CALL construct_array(array=array_temp,dt=dt)
array = array_temp
END SUBROUTINE 

END MODULE target_module

