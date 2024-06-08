MODULE auxiliary_module
IMPLICIT NONE
public construct_array
INTERFACE construct_array
MODULE PROCEDURE construct_array_dummy
MODULE PROCEDURE construct_array_target
END INTERFACE 
CONTAINS
SUBROUTINE construct_array_target(array)
REAL(kind=8), DIMENSION(:) :: array
INTEGER :: i
DO i = 1, size(array)
array(i) = 2 ** (i - 1)
END DO
END SUBROUTINE 

SUBROUTINE construct_array_dummy(array)
REAL(kind=16), DIMENSION(:) :: array
INTEGER :: i
DO i = 1, size(array)
array(i) = 2 ** (i - 1)
END DO
END SUBROUTINE 

END MODULE auxiliary_module

