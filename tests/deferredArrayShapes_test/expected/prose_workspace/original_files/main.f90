program main
    use target_module, only: target_subroutine
    use auxiliary_type, only: my_derived_type
    implicit none

    real (kind=16)          :: result
    integer                 :: dummy=0
    type(my_derived_type)   :: dt

    dt%array_dim = 3

    call target_subroutine(result, dt)

    ! time left blank intentionally for regression testing
    ! see eval.py for code that generates cost metric
    print *, "out: ", result
    print *, "time: ", dummy
    
end program main