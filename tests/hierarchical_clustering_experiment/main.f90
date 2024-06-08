program main
    use target_module, only: target_subroutine
    implicit none

    real(kind=8):: result
    real        :: rate
    integer     :: cr, cm, start, end

    
    call system_clock(count_rate=cr)
    call system_clock(count_max=cm)
    rate = real(cr)

    call system_clock(start)
    call target_subroutine(result)
    call system_clock(end)

    print *, "out: ", result
    print *, "time: ", (end-start)/rate
    
end program main