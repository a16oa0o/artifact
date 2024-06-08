module auxiliary_module
    use auxiliary_type, only : param_file_type

    implicit none

    public  ::  get_param

    interface get_param
        module procedure get_param_int, get_param_real
    end interface

    contains

    subroutine get_param_int(CS, modulename, varname, value, desc, units, &
        default, fail_if_missing, do_not_read, do_not_log, &
        static_value, layoutParam, debuggingParam)

        type(param_file_type),      intent(in)    :: CS      !< The control structure for the file_parser module,
                                        !! it is also a structure to parse for run-time parameters
        character(len=*),           intent(in)    :: modulename !< The name of the calling module
        character(len=*),           intent(in)    :: varname !< The case-sensitive name of the parameter to read
        integer,                    intent(inout) :: value   !< The value of the parameter that may be
                                        !! read from the parameter file and logged
        character(len=*), optional, intent(in)    :: desc    !< A description of this variable; if not
                                        !! present, this parameter is not written to a doc file
        character(len=*), optional, intent(in)    :: units   !< The units of this parameter
        integer,          optional, intent(in)    :: default !< The default value of the parameter
        integer,          optional, intent(in)    :: static_value !< If this parameter is static, it takes
                                        !! this value, which can be compared for consistency with
                                        !! what is in the parameter file.
        logical,          optional, intent(in)    :: fail_if_missing !< If present and true, a fatal error occurs
                                        !! if this variable is not found in the parameter file
        logical,          optional, intent(in)    :: do_not_read  !< If present and true, do not read a
                                        !! value for this parameter, although it might be logged.
        logical,          optional, intent(in)    :: do_not_log !< If present and true, do not log this
                                        !! parameter to the documentation files
        logical,          optional, intent(in)    :: layoutParam !< If present and true, this parameter is
                                        !! logged in the layout parameter file
        logical,          optional, intent(in)    :: debuggingParam !< If present and true, this parameter is
                                        !! logged in the debugging parameter file

        logical :: do_read, do_log

        do_read = .true. ; if (present(do_not_read)) do_read = .not.do_not_read
        do_log  = .true. ; if (present(do_not_log))  do_log  = .not.do_not_log

        if (do_read) then
        if (present(default)) value = default
        if (present(static_value)) value = static_value
        !call read_param_int(CS, varname, value, fail_if_missing)
        print *, "read_param_int called"
        endif

        if (do_log) then
        ! call log_param_int(CS, modulename, varname, value, desc, units, default, layoutParam, debuggingParam)
        print *, "log_param_int called"
        endif

        end subroutine get_param_int

    subroutine get_param_real(CS, modulename, varname, value, desc, units, &
                default, fail_if_missing, do_not_read, do_not_log, &
                static_value, debuggingParam, scale, unscaled)
        type(param_file_type),      intent(in)    :: CS      !< The control structure for the file_parser module,
                                                !! it is also a structure to parse for run-time parameters
        character(len=*),           intent(in)    :: modulename !< The name of the calling module
        character(len=*),           intent(in)    :: varname !< The case-sensitive name of the parameter to read
        real,                       intent(inout) :: value   !< The value of the parameter that may be
                                                !! read from the parameter file and logged
        character(len=*), optional, intent(in)    :: desc    !< A description of this variable; if not
                                                !! present, this parameter is not written to a doc file
        character(len=*), optional, intent(in)    :: units   !< The units of this parameter
        real,             optional, intent(in)    :: default !< The default value of the parameter
        real,             optional, intent(in)    :: static_value !< If this parameter is static, it takes
                                                !! this value, which can be compared for consistency with
                                                !! what is in the parameter file.
        logical,          optional, intent(in)    :: fail_if_missing !< If present and true, a fatal error occurs
                                                !! if this variable is not found in the parameter file
        logical,          optional, intent(in)    :: do_not_read  !< If present and true, do not read a
                                                !! value for this parameter, although it might be logged.
        logical,          optional, intent(in)    :: do_not_log !< If present and true, do not log this
                                                !! parameter to the documentation files
        logical,          optional, intent(in)    :: debuggingParam !< If present and true, this parameter is
                                                !! logged in the debugging parameter file
        real,             optional, intent(in)    :: scale   !< A scaling factor that the parameter is
                                                !! multiplied by before it is returned.
        real,             optional, intent(out)   :: unscaled !< The value of the parameter that would be
                                                !! returned without any multiplication by a scaling factor.

        logical :: do_read, do_log

        do_read = .true. ; if (present(do_not_read)) do_read = .not.do_not_read
        do_log  = .true. ; if (present(do_not_log))  do_log  = .not.do_not_log

        if (do_read) then
            if (present(default)) value = default
            if (present(static_value)) value = static_value
            !call read_param_real(CS, varname, value, fail_if_missing)
            !print *, "read_param_real called"
        endif

        if (do_log) then
            ! call log_param_real(CS, modulename, varname, value, desc, units, default, debuggingParam)
            !print *, "log_param_real called"
            do_log = .false.
        endif

        if (present(unscaled)) unscaled = value
        if (present(scale)) value = scale*value

    end subroutine get_param_real


end module auxiliary_module