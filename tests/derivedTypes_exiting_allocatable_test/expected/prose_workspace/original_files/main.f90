program main
    use target_module, only: target_subroutine
    implicit none

    real (kind=16)  :: result
    integer         :: dummy=0

    call target_subroutine(result)

    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
    print *, "out: ", result
    print *, "time: ", dummy
    
end program main