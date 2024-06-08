program main
    use target_module, only: target_subroutine
    implicit none

    real(kind=16)   :: result = 0
    integer         :: dummy

    do dummy = 1, 2
        call target_subroutine(result)
    end do

    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
    print *, "out: ", result
    print *, "time: ", dummy
    
end program main