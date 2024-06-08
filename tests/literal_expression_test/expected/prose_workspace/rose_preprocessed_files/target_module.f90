MODULE target_module
IMPLICIT NONE
REAL :: a1 = 4.0, b1 = 5.0, c1 = 6.0
REAL :: a0 = 1.0, b0 = 2.0, c0 = 3.0
CONTAINS
SUBROUTINE target_subroutine(result)
REAL :: a2, b2, c2
INTEGER :: i = 3
REAL(kind=8), INTENT(INOUT) :: result
a2 = a0 + a1
b2 = b0 + b1
c2 = c0 + c1
result = a2 + b2 + c2
CALL power(result,i)
result = sum(90. - result,b1)
END SUBROUTINE 

REAL FUNCTION sum(x,y)
REAL(kind=8), INTENT(IN) :: x
REAL, INTENT(IN) :: y
sum = x + y
END  FUNCTION 

SUBROUTINE power(x,y)
REAL(kind=8), INTENT(INOUT) :: x
INTEGER :: k, y
DO k = 1, y
x = x * x
END DO
END SUBROUTINE 

END MODULE target_module

