MODULE target_module
IMPLICIT NONE
INTERFACE my_sum
MODULE PROCEDURE my_sum_2d
MODULE PROCEDURE my_sum_3d
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result,array2)
REAL(kind=8), DIMENSION(4,4), TARGET :: array1
REAL(kind=8), DIMENSION(2,2,4), OPTIONAL :: array2
REAL(kind=8), POINTER, DIMENSION(:,:,:) :: ptr2
REAL(kind=8), POINTER, DIMENSION(:,:) :: ptr1
REAL(kind=16) :: result
array1 = reshape((/3.5_8,6.0_8,2.5_8,2.0_8,6.5_8,4.0_8,4.5_8,3.0_8,5.5_8,6.0_8,6.5_8,4.0_8,7.5_8,8.0_8,8.5_8,5.0_8/),(shape(array1))&
,order=(/2,1/))
ptr1 => array1(2:3,2:3)
IF (present(array2)) THEN
allocate( ptr2(2,2,4) )
ptr2 = array2
ELSE
ptr2 => null()
END IF
result = my_sum(ptr1) + my_sum(ptr2)
IF (present(array2)) THEN
array2 = ptr2
deallocate( ptr2 )
END IF
END SUBROUTINE 

 FUNCTION my_sum_2d(ptr) result(return_value)
REAL(kind=8), POINTER, DIMENSION(:,:) :: ptr
REAL(kind=8) :: return_value
INTEGER :: i, j
INTEGER, DIMENSION(2) :: arr_shape
arr_shape = shape(ptr)
return_value = 0
DO i = 1, arr_shape(1)
DO j = 1, arr_shape(2)
return_value = return_value + ptr(i,j)
END DO
END DO
END  FUNCTION 

 FUNCTION my_sum_3d(ptr) result(return_value)
REAL(kind=8), POINTER, DIMENSION(:,:,:) :: ptr
REAL(kind=8) :: return_value
INTEGER :: i, j, k
INTEGER, DIMENSION(3) :: arr_shape
arr_shape = shape(ptr)
return_value = 0
DO i = 1, arr_shape(1)
DO j = 1, arr_shape(2)
DO k = 1, arr_shape(3)
return_value = return_value + ptr(i,j,k)
END DO
END DO
END DO
END  FUNCTION 

END MODULE target_module
