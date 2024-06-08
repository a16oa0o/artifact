MODULE target_module
USE auxiliary_module, ONLY : external_foo , external_bar
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
REAL(kind=8) :: eebr = 6.0
REAL(kind=8) :: eifr = 5.0
REAL(kind=8) :: eb = 4.0
REAL(kind=8) :: ib = 3.0
INTEGER :: eefi = 7, eibi = 8
result = implicit_bar(ib) + explicit_bar(eb) + external_foo(eifr)
result = result + external_foo(eefi) + external_bar(eibi) + external_bar(eebr)
END SUBROUTINE 

REAL(kind=8) FUNCTION implicit_bar(x)
REAL(kind=8) :: x
implicit_bar = 2.718281828459045_8 * x
END  FUNCTION 

 FUNCTION explicit_bar(x) result(bar_return)
REAL(kind=8) :: x
REAL(kind=8) :: bar_return
bar_return = 2.718281828459045_8 * x
END  FUNCTION 

END MODULE target_module

