MODULE auxiliary_module
IMPLICIT NONE
public generic_name
INTERFACE generic_name
MODULE PROCEDURE right
MODULE PROCEDURE wrong
END INTERFACE 
CONTAINS
SUBROUTINE right(result,iterations,multiplicand)
REAL(kind=8) :: result
REAL(kind=8), OPTIONAL :: multiplicand
REAL(kind=8) :: m
INTEGER, OPTIONAL :: iterations
INTEGER :: j, i
IF (present(multiplicand)) THEN
m = multiplicand
ELSE
m = 1.0_8
END IF
IF (present(iterations)) THEN
i = iterations
ELSE
i = 1
END IF
result = 1.0_8
DO j = 1, i
result = result + result * m
END DO
END SUBROUTINE 

SUBROUTINE wrong(result)
REAL(kind=16) :: result
result = 0.0_16
END SUBROUTINE 

END MODULE auxiliary_module

