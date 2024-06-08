MODULE target_module
IMPLICIT NONE
REAL(kind=8) :: c1 = 6.0
REAL(kind=8) :: b1 = 5.0
REAL(kind=8) :: a1 = 4.0
REAL(kind=4) :: c0 = 3.0
REAL(kind=4) :: b0 = 2.0
REAL(kind=4) :: a0 = 1.0
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: c2
REAL(kind=8) :: b2
REAL(kind=8) :: a2
REAL(kind=16) :: result
INTEGER :: i
a2 = a0 + a1
b2 = b0 + b1
c2 = c0 + c1
DO i = 0, 10
result = result + a2 + b2 + c2
END DO
END SUBROUTINE 

END MODULE target_module

