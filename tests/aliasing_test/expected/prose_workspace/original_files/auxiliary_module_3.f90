module auxiliary_module_3

    implicit none; private

    public  ::  bar, baz, buzz

    contains

    subroutine bar()
        call sleep(1)
    end subroutine

    subroutine baz()
        call sleep(1)
    end subroutine

    subroutine buzz()
        call sleep(1)
    end subroutine

end module auxiliary_module_3