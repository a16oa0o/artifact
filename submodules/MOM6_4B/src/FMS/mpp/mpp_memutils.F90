!***********************************************************************
!*                   GNU Lesser General Public License
!*
!* This file is part of the GFDL Flexible Modeling System (FMS).
!*
!* FMS is free software: you can redistribute it and/or modify it under
!* the terms of the GNU Lesser General Public License as published by
!* the Free Software Foundation, either version 3 of the License, or (at
!* your option) any later version.
!*
!* FMS is distributed in the hope that it will be useful, but WITHOUT
!* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
!* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
!* for more details.
!*
!* You should have received a copy of the GNU Lesser General Public
!* License along with FMS.  If not, see <http://www.gnu.org/licenses/>.
!***********************************************************************
module mpp_memutils_mod

  use mpp_mod, only: mpp_min, mpp_max, mpp_sum, mpp_pe, mpp_root_pe
  use mpp_mod, only: mpp_error, FATAL, stderr, mpp_npes, get_unit

  implicit none
  private

  public :: mpp_print_memuse_stats, mpp_mem_dump
  public :: mpp_memuse_begin, mpp_memuse_end

  real(kind=8)    :: begin_memuse
  logical :: memuse_started = .false.

contains

  !#######################################################################
  subroutine mpp_memuse_begin
#if defined(__sgi) || defined(__aix) || defined(__SX)
    integer :: memuse
#endif

    if(memuse_started) then
       call mpp_error(FATAL, "mpp_memutils_mod: mpp_memuse_begin was already called")
    endif
    memuse_started = .true.

#if defined(__sgi) || defined(__aix) || defined(__SX)
    begin_memuse = memuse()*1e-3
#else
    call mpp_mem_dump(begin_memuse)
#endif 

  end subroutine mpp_memuse_begin

  !#######################################################################
  subroutine mpp_memuse_end( text, unit )

    character(len=*), intent(in) :: text
    integer, intent(in), optional :: unit
    real(kind=8)    :: m, mmin, mmax, mavg, mstd, end_memuse
    integer :: mu
#if defined(__sgi) || defined(__aix) || defined(__SX)
    integer :: memuse
#endif

    if(.NOT.memuse_started) then
       call mpp_error(FATAL, "mpp_memutils_mod: mpp_memuse_begin must be called before calling mpp_memuse_being")
    endif
    memuse_started = .false.

#if defined(__sgi) || defined(__aix) || defined(__SX)
    end_memuse = memuse()*1e-3
#else
    call mpp_mem_dump(end_memuse)
#endif 

    mu = stderr(); if( PRESENT(unit) )mu = unit
    m = end_memuse - begin_memuse
    mmin = m; call mpp_min(mmin)
    mmax = m; call mpp_max(mmax)
    mavg = m; call mpp_sum(mavg); mavg = mavg/mpp_npes()
    mstd = (m-mavg)**2; call mpp_sum(mstd); mstd = sqrt( mstd/mpp_npes() )
    if( mpp_pe().EQ.mpp_root_pe() )write( mu,'(a64,4es11.3)' ) &
         'Memory(MB) used in '//trim(text)//'=', mmin, mmax, mstd, mavg

    return    

  end subroutine mpp_memuse_end

  !#######################################################################

  subroutine mpp_print_memuse_stats( text, unit )

    character(len=*), intent(in) :: text
    integer, intent(in), optional :: unit
    real(kind=8) :: m, mmin, mmax, mavg, mstd
    integer :: mu
!memuse is an external function: works on SGI
!use #ifdef to generate equivalent on other platforms.
#if defined(__sgi) || defined(__aix) || defined(__SX)
    integer :: memuse !default integer OK?
#endif 

    mu = stderr(); if( PRESENT(unit) )mu = unit
#if defined(__sgi) || defined(__aix) || defined(__SX)
    m = memuse()*1e-3
#else
    call mpp_mem_dump(m)
#endif 
    mmin = m; call mpp_min(mmin)
    mmax = m; call mpp_max(mmax)
    mavg = m; call mpp_sum(mavg); mavg = mavg/mpp_npes()
    mstd = (m-mavg)**2; call mpp_sum(mstd); mstd = sqrt( mstd/mpp_npes() )
    if( mpp_pe().EQ.mpp_root_pe() )write( mu,'(a64,4es11.3)' ) &
         'Memuse(MB) at '//trim(text)//'=', mmin, mmax, mstd, mavg

    return
  end subroutine mpp_print_memuse_stats

!#######################################################################

subroutine mpp_mem_dump ( memuse )

real(kind=8), intent(out) :: memuse

! This routine returns the memory usage on Linux systems.
! It does this by querying a system file (file_name below).
! It is intended for use by print_memuse_stats above.

character(len=32) :: file_name = '/proc/self/status'
character(len=32) :: string
integer :: mem_unit
real    :: multiplier

  memuse = 0.0
  multiplier = 1.0

  mem_unit = get_unit()
  open(mem_unit, file=file_name, form='FORMATTED', action='READ', access='SEQUENTIAL')
  
  do; read (mem_unit,'(a)', end=10) string
    if ( INDEX ( string, 'VmHWM:' ) == 1 ) then
      read (string(7:LEN_TRIM(string)-2),*) memuse
      exit
    endif
  enddo
  
  if (TRIM(string(LEN_TRIM(string)-1:)) == "kB" ) &
    multiplier = 1.0/1024. ! Convert from kB to MB

10 close (mem_unit)
   memuse = memuse * multiplier

  return
end subroutine mpp_mem_dump


end module mpp_memutils_mod
