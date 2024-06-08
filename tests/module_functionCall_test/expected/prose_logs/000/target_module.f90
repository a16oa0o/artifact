MODULE target_module
IMPLICIT NONE
REAL(kind=8) :: c0
REAL(kind=8) :: b0
REAL(kind=8) :: a0
REAL(kind=8), DIMENSION(3,2) :: array = reshape((/1.0_8,2.0_8,3.0_8,4.0_8,5.0_8,6.0_8/),(shape(array)),order=(/2,1/))
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=16) :: result
a0 = array(1,1) + array(1,2)
b0 = array(2,1) + array(2,2)
c0 = array(3,1) + array(3,2)
result = a0 + b0 + c0
END SUBROUTINE 

END MODULE target_module

