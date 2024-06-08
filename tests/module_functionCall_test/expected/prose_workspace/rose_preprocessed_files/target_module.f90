MODULE target_module
IMPLICIT NONE
REAL :: a0, b0, c0
REAL, DIMENSION(3,2) :: array = reshape((/1.0,2.0,3.0,4.0,5.0,6.0/),(shape(array)),order=(/2,1/))
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=16) :: result
a0 = array(1,1) + array(1,2)
b0 = array(2,1) + array(2,2)
c0 = array(3,1) + array(3,2)
result = a0 + b0 + c0
END SUBROUTINE 

END MODULE target_module

