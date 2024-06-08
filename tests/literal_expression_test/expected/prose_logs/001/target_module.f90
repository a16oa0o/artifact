MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_8_to_4
INTERFACE target_subroutine_wrapper_8_to_4
MODULE PROCEDURE target_subroutine_wrapper_8_to_4
END INTERFACE 
REAL(kind=4) :: c1 = 6.0
REAL(kind=4) :: b1 = 5.0
REAL(kind=4) :: a1 = 4.0
REAL(kind=4) :: c0 = 3.0
REAL(kind=4) :: b0 = 2.0
REAL(kind=4) :: a0 = 1.0
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: c2
REAL(kind=4) :: b2
REAL(kind=4) :: a2
INTEGER :: i = 3
REAL(kind=4), INTENT(INOUT) :: result
a2 = a0 + a1
b2 = b0 + b1
c2 = c0 + c1
result = a2 + b2 + c2
CALL power(result,i)
result = sum(90._4 - result,b1)
END SUBROUTINE 

REAL(kind=4) FUNCTION sum(x,y)
REAL(kind=4), INTENT(IN) :: x
REAL(kind=4), INTENT(IN) :: y
sum = x + y
END  FUNCTION 

SUBROUTINE power(x,y)
REAL(kind=4), INTENT(INOUT) :: x
INTEGER :: k, y
DO k = 1, y
x = x * x
END DO
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_8_to_4(result)
REAL(kind=8), INTENT(INOUT) :: result
REAL(kind=4) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

