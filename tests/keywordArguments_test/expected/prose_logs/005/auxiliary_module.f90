MODULE auxiliary_module
IMPLICIT NONE
public right_wrapper_840_to_880
INTERFACE right_wrapper_840_to_880
MODULE PROCEDURE right_wrapper_840_to_880
END INTERFACE 
public right_wrapper_4xx_to_880
INTERFACE right_wrapper_4xx_to_880
MODULE PROCEDURE right_wrapper_4xx_to_880
END INTERFACE 
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

SUBROUTINE right_wrapper_4xx_to_880(result)
REAL(kind=4) :: result
REAL(kind=8) :: result_temp
result_temp = result
CALL right(result=result_temp)
result = result_temp
END SUBROUTINE 

SUBROUTINE right_wrapper_840_to_880(result,iterations,multiplicand)
REAL(kind=8) :: result
REAL(kind=4), OPTIONAL :: multiplicand
REAL(kind=8), POINTER :: multiplicand_temp
INTEGER :: iterations
IF (PRESENT(multiplicand)) THEN
allocate( multiplicand_temp )
multiplicand_temp = multiplicand
ELSE
multiplicand_temp => NULL()
END IF
CALL right(result=result,iterations=iterations,multiplicand=multiplicand_temp)
IF (PRESENT(multiplicand)) THEN
multiplicand = multiplicand_temp
deallocate( multiplicand_temp )
END IF
END SUBROUTINE 

END MODULE auxiliary_module

