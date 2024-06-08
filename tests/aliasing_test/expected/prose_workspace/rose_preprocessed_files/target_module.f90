MODULE target_module
USE auxiliary_module_1, ONLY : foo_alias => foo
USE auxiliary_module_2, ONLY : bar_alias , baz_alias
USE auxiliary_module_3, ONLY : buzz
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
result = - 3.14
CALL bar_alias()
result = 2.718281828459045 * foo(result)
CALL baz_alias()
END SUBROUTINE 

 FUNCTION foo(x)
INTEGER :: foo
REAL(kind=8) :: x
CALL buzz()
foo = foo_alias(x)
END  FUNCTION 

END MODULE target_module

