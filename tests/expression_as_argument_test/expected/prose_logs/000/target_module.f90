MODULE target_module
USE aux_module, ONLY : assert_msg , error_msg
IMPLICIT NONE
TYPE , PRIVATE :: new_type
CHARACTER(len=500) :: mesg
END TYPE new_type
CONTAINS
SUBROUTINE target_subroutine(result)
IMPLICIT NONE
REAL(kind=8) :: pconstant
REAL(kind=8) :: p2
REAL(kind=8) :: p1
REAL(kind=8) :: result
REAL(kind=8), DIMENSION(2), TARGET :: tgt = (/1.,2./)
REAL(kind=8), POINTER, DIMENSION(:) :: ptr
TYPE ( new_type )  :: derived_type_inst
CALL assert_msg(.NOT.associated(ptr),'test fail message 1')
ptr => tgt
CALL assert_msg((associated(ptr)),'test fail message 2')
derived_type_inst%mesg = "hahahaha"
CALL assert_msg(p1 + p2 .EQ. 7.0_8,"test fail message 3: " // trim(derived_type_inst%mesg))
p1 = 3.0_8
p2 = 4.0_8
result = p1 + p2
END SUBROUTINE target_subroutine

END MODULE target_module

