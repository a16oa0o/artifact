MODULE target_module
USE auxiliary_module_1, ONLY : foo_alias => foo
USE auxiliary_module_2, ONLY : bar_alias , baz_alias
USE auxiliary_module_3, ONLY : buzz
IMPLICIT NONE
public target_subroutine_wrapper_8_to_4
INTERFACE target_subroutine_wrapper_8_to_4
MODULE PROCEDURE target_subroutine_wrapper_8_to_4
END INTERFACE 
public foo_wrapper_4_to_8
INTERFACE foo_wrapper_4_to_8
MODULE PROCEDURE foo_wrapper_4_to_8
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: result
result = - 3.14_4
CALL bar_alias()
result = 2.718281828459045_4 * foo_wrapper_4_to_8(result)
CALL baz_alias()
END SUBROUTINE 

 FUNCTION foo(x)
INTEGER :: foo
REAL(kind=8) :: x
CALL buzz()
foo = foo_alias(x)
END  FUNCTION 

INTEGER FUNCTION foo_wrapper_4_to_8(x) result(returnValue)
REAL(kind=4) :: x
REAL(kind=8) :: x_temp
x_temp = x
returnValue = foo(x=x_temp)
x = x_temp
END  FUNCTION 

SUBROUTINE target_subroutine_wrapper_8_to_4(result)
REAL(kind=8) :: result
REAL(kind=4) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

