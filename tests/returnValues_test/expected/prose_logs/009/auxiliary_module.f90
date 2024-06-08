MODULE auxiliary_module
IMPLICIT NONE
public external_implicit_foo_real_wrapper_4_to_8
INTERFACE external_implicit_foo_real_wrapper_4_to_8
MODULE PROCEDURE external_implicit_foo_real_wrapper_4_to_8
END INTERFACE 
public external_bar, external_foo
INTERFACE external_foo
MODULE PROCEDURE external_implicit_foo_real
MODULE PROCEDURE external_explicit_foo_int
END INTERFACE 
INTERFACE external_bar
MODULE PROCEDURE external_implicit_bar_int
MODULE PROCEDURE external_explicit_bar_real
END INTERFACE 
CONTAINS
REAL(kind=8) FUNCTION external_implicit_foo_real(x)
REAL(kind=8) :: x
external_implicit_foo_real = 3.141592653589793_8 * x
END  FUNCTION 

 FUNCTION external_explicit_foo_int(x) result(foo_return)
INTEGER :: x
REAL(kind=8) :: foo_return
foo_return = 3.141592653589793_8 * x
END  FUNCTION 

REAL(kind=8) FUNCTION external_implicit_bar_int(x)
INTEGER :: x
external_implicit_bar_int = 2.718281828459045_8 * x
END  FUNCTION 

 FUNCTION external_explicit_bar_real(x) result(bar_return)
REAL(kind=8) :: x
REAL(kind=8) :: bar_return
bar_return = 2.718281828459045_8 * x
END  FUNCTION 

REAL(kind=8) FUNCTION external_implicit_foo_real_wrapper_4_to_8(x) result(returnValue)
REAL(kind=4) :: x
REAL(kind=8) :: x_temp
x_temp = x
returnValue = external_implicit_foo_real(x=x_temp)
x = x_temp
END  FUNCTION 

END MODULE auxiliary_module

