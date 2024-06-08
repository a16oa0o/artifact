MODULE target_module
USE auxiliary_module_1, ONLY : foo_wrapper_4_to_8
USE auxiliary_module_1, ONLY : foo_alias => foo
USE auxiliary_module_2, ONLY : bar_alias , baz_alias
USE auxiliary_module_3, ONLY : buzz
IMPLICIT NONE
public foo_wrapper_8_to_4
INTERFACE foo_wrapper_8_to_4
MODULE PROCEDURE foo_wrapper_8_to_4
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
result = - 3.14_8
CALL bar_alias()
result = 2.718281828459045_8 * foo_wrapper_8_to_4(result)
CALL baz_alias()
END SUBROUTINE 

 FUNCTION foo(x)
INTEGER :: foo
REAL(kind=4) :: x
CALL buzz()
foo = foo_wrapper_4_to_8(x)
END  FUNCTION 

INTEGER FUNCTION foo_wrapper_8_to_4(x) result(returnValue)
REAL(kind=8) :: x
REAL(kind=4) :: x_temp
x_temp = x
returnValue = foo(x=x_temp)
x = x_temp
END  FUNCTION 

END MODULE target_module

