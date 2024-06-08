program main
    use TARGET_MODULE, only: target_subroutine
    implicit none

    real(kind=8)   :: result
    real(kind=16), parameter :: pconstant = 1e-3
    integer         :: dummy=0

    call target_subroutine(result, pconstant)

    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
    print *, "out: ", result
    print *, "time: ", dummy
    
end program main