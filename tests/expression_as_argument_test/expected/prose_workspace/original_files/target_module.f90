module target_module

    use aux_module, only: assert_msg, error_msg
    implicit none

    type, private :: new_type
        character(len=500) :: mesg
    end type new_type

    contains

    subroutine target_subroutine( result )

        implicit none 
        real(kind=8) :: pconstant
        real(kind=8) :: p1, p2
        real(kind=8) :: result

        real, target  :: tgt(2) = (/1., 2./)
        real, pointer :: ptr(:)

        type(new_type) :: derived_type_inst        

        call assert_msg(.not.associated(ptr), 'test fail message 1')

        ptr => tgt        

        call assert_msg(associated(ptr), 'test fail message 2')

        derived_type_inst%mesg = "hahahaha"

        call assert_msg(p1 + p2 .eq. 7.0, "test fail message 3: "//trim(derived_type_inst%mesg))

        p1 = 3.0
        p2 = 4.0

        result = p1 + p2

    END subroutine target_subroutine

END MODULE TARGET_MODULE
