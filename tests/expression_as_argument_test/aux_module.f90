module aux_module
    implicit none
 
    contains

    function is_root_pe()
        logical :: is_root_pe
        is_root_pe = .true.
        return        
    end function is_root_pe

    subroutine error_msg(level, message, all_print)
        integer,           intent(in) :: level
        character(len=*),  intent(in) :: message
        logical, optional, intent(in) :: all_print
        logical :: write_msg
      
        write_msg = is_root_pe()
        if (present(all_print)) write_msg = write_msg .or. all_print
      
    end subroutine error_msg

    subroutine assert_msg(logical_arg, msg)
        logical, intent(in) :: logical_arg !< If false causes a FATAL error
        character(len=*), intent(in) :: msg !< Message to issue in case of failed assertion
      
        if (.not. logical_arg) then
          call error_msg(1, msg)
        endif
      
      end subroutine assert_msg

end module aux_module