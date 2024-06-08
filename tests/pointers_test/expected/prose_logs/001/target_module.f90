MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_8g_to_4a
INTERFACE target_subroutine_wrapper_8g_to_4a
MODULE PROCEDURE target_subroutine_wrapper_8g_to_4a
END INTERFACE 
INTERFACE my_sum
MODULE PROCEDURE my_sum_2d
MODULE PROCEDURE my_sum_3d
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result,array2)
REAL(kind=4), DIMENSION(4,4), TARGET :: array1
REAL(kind=4), DIMENSION(2,2,4), OPTIONAL :: array2
REAL(kind=4), POINTER, DIMENSION(:,:,:) :: ptr2
REAL(kind=4), POINTER, DIMENSION(:,:) :: ptr1
REAL(kind=10) :: result
array1 = reshape((/3.5_4,6.0_4,2.5_4,2.0_4,6.5_4,4.0_4,4.5_4,3.0_4,5.5_4,6.0_4,6.5_4,4.0_4,7.5_4,8.0_4,8.5_4,5.0_4/),(shape(array1))&
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
REAL(kind=4), POINTER, DIMENSION(:,:) :: ptr
REAL(kind=4) :: return_value
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
REAL(kind=4), POINTER, DIMENSION(:,:,:) :: ptr
REAL(kind=4) :: return_value
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

SUBROUTINE target_subroutine_wrapper_8g_to_4a(result,array2)
REAL(kind=8), DIMENSION(2,2,4), OPTIONAL :: array2
REAL(kind=4), POINTER, DIMENSION(:,:,:) :: array2_temp
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
IF (PRESENT(array2)) THEN
allocate( array2_temp(SIZE(array2,1),SIZE(array2,2),SIZE(array2,3)) )
array2_temp = array2
ELSE
array2_temp => NULL()
END IF
result_temp = result
CALL target_subroutine(result=result_temp,array2=array2_temp)
IF (PRESENT(array2)) THEN
array2 = array2_temp
deallocate( array2_temp )
END IF
result = result_temp
END SUBROUTINE 

END MODULE target_module

