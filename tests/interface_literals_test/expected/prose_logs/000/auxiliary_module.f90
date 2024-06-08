MODULE auxiliary_module
USE auxiliary_type, ONLY : param_file_type
IMPLICIT NONE
public get_param
INTERFACE get_param
MODULE PROCEDURE get_param_int
MODULE PROCEDURE get_param_real
END INTERFACE 
CONTAINS
SUBROUTINE get_param_int(CS,modulename,varname,value,desc,units,default,fail_if_missing,do_not_read,do_not_log,static_value,&
layoutParam,debuggingParam)
TYPE ( param_file_type ) , INTENT(IN) :: CS
CHARACTER(len=*), INTENT(IN) :: modulename
CHARACTER(len=*), INTENT(IN) :: varname
INTEGER, INTENT(INOUT) :: value
CHARACTER(len=*), INTENT(IN), OPTIONAL :: desc
CHARACTER(len=*), INTENT(IN), OPTIONAL :: units
INTEGER, INTENT(IN), OPTIONAL :: default
INTEGER, INTENT(IN), OPTIONAL :: static_value
LOGICAL, INTENT(IN), OPTIONAL :: fail_if_missing
LOGICAL, INTENT(IN), OPTIONAL :: do_not_read
LOGICAL, INTENT(IN), OPTIONAL :: do_not_log
LOGICAL, INTENT(IN), OPTIONAL :: layoutParam
LOGICAL, INTENT(IN), OPTIONAL :: debuggingParam
LOGICAL :: do_read, do_log
do_read = .TRUE.
IF (present(do_not_read)) do_read = .NOT.do_not_read
do_log = .TRUE.
IF (present(do_not_log)) do_log = .NOT.do_not_log
IF (do_read) THEN
IF (present(default)) value = default
IF (present(static_value)) value = static_value
PRINT *, "read_param_int called"
END IF
IF (do_log) THEN
PRINT *, "log_param_int called"
END IF
END SUBROUTINE get_param_int

SUBROUTINE get_param_real(CS,modulename,varname,value,desc,units,default,fail_if_missing,do_not_read,do_not_log,static_value,&
debuggingParam,scale,unscaled)
TYPE ( param_file_type ) , INTENT(IN) :: CS
CHARACTER(len=*), INTENT(IN) :: modulename
CHARACTER(len=*), INTENT(IN) :: varname
REAL(kind=8), INTENT(INOUT) :: value
CHARACTER(len=*), INTENT(IN), OPTIONAL :: desc
CHARACTER(len=*), INTENT(IN), OPTIONAL :: units
REAL(kind=8), INTENT(IN), OPTIONAL :: default
REAL(kind=8), INTENT(IN), OPTIONAL :: static_value
LOGICAL, INTENT(IN), OPTIONAL :: fail_if_missing
LOGICAL, INTENT(IN), OPTIONAL :: do_not_read
LOGICAL, INTENT(IN), OPTIONAL :: do_not_log
LOGICAL, INTENT(IN), OPTIONAL :: debuggingParam
REAL(kind=8), INTENT(IN), OPTIONAL :: scale
REAL(kind=8), INTENT(OUT), OPTIONAL :: unscaled
LOGICAL :: do_read, do_log
do_read = .TRUE.
IF (present(do_not_read)) do_read = .NOT.do_not_read
do_log = .TRUE.
IF (present(do_not_log)) do_log = .NOT.do_not_log
IF (do_read) THEN
IF (present(default)) value = default
IF (present(static_value)) value = static_value
END IF
IF (do_log) THEN
do_log = .FALSE.
END IF
IF (present(unscaled)) unscaled = value
IF (present(scale)) value = scale * value
END SUBROUTINE get_param_real

END MODULE auxiliary_module

