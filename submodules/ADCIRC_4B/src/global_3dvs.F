!******************************************************************************
! PADCIRC VERSION 45.12 03/17/2006                                            *
!  last changes in this file VERSION 45.11                                    *
!                                                                             *
! This module declares the 3D exclusive global variables.  It also uses some  *
! general global variables that were declared in module GLOBAL.               *
! The module also allocates the required arrays.                              *
!                                                                             *
!******************************************************************************
!
      MODULE GLOBAL_3DVS
!...
!...BRING IN NECESSARY VARIABLES FROM GLOBAL
!...
      USE SIZES,
     &     ONLY : SZ, !size of reals (4 or 8 bytes), set during compile time
     &     NBYTE,
     &     MNP,
     &     MNE,
     &     MNEI,
     &     MNVEL,
     &     MNFEN,
     &     MYProc,
     &     INPUTDIR,
     &     LOCALDIR
     
      USE GLOBAL,
     &     ONLY :
     &       WSX1, WSY1,     !WSX1(MNP),WSY1(MNP) = Wind stress components at time level s
     &       WSX2, WSY2,     !WSX2(MNP),WSY2(MNP) = Wind stress components at time level s+1
     &       DASigT,
     &       ETA1, ETA2,     !ETA1(MNP),ETA2(MNP) = water surf elev at time levels s, s+1
     &       CORIF,          !CORIF(MNP) = nodal values of Coriolis parameter
     &       IFNLCT,                       !nonlinear advection flag (1=yes, 0=no) (jgf45.11)
!orbitt 120328: Apply Advection Locally
     &       IFNLCTE,        !Global nonlinear advection flag (1=yes, 0=no)
     &       IFNLFA,         !nonlinear finite amplitude flag (1=yes,0=no) (jgf45.11)
     &       NScreen,        !flag to suppress or allow screen output
     &       ScreenUnit,     !i/o for screen output
     &       IHOT,           !flag to specify if coldstart (=0) or hotstart file to read from (63 or 64)
     &       IHOTSTP,        !hotstart file record counter
     &       NWS,
     &       IDen,           !flag telling whether salinity, temperature and/or sigmaT are being used
     &       RhoWat0, SigT0, G,
     &       RUNDES, RDES4, RDES8,
     &       RUNID, RID4, RID8,
     &       CBaroclinic,
     &       C3DVS,
     &       DTDP,           !DTDP = timestep declared as real(8)
     &       allMessage, logMessage, DEBUG, ECHO, INFO, WARNING, ERROR,
     &       setMessageSource, unsetMessageSource, mom_lv_x

      USE BOUNDARIES,ONLY:NETA,NVEL
      IMPLICIT NONE

      SAVE

!...DECLARE 3D GLOBAL ARRAYS

      ! jgf: Explicitly declare pointer variables instead of assigning
      ! them in the USE GLOBAL, ONLY statement above.
      ! BSX(MNP),BSY(MNP) = bottom stress computed after velocity solution
      REAL(kind=8), POINTER :: BSX(:)  ! => BSX1
      REAL(kind=8), POINTER :: BSY(:)  ! => BSY1
      ! UU(MNP),VV(MNP) = vertically averaged velocity components
      REAL(kind=8), POINTER :: UU(:)   ! => UU2
      REAL(kind=8), POINTER :: VV(:)   ! => VV2
      REAL(kind=8), POINTER :: DAFluxX(:)   ! => QX2
      REAL(kind=8), POINTER :: DAFluxY(:)   ! => QY2
      ! DUU(MNP),DVV(MNP),DUV(MNP) = velocity dispersion terms
      REAL(kind=8), POINTER :: DUU(:)       ! => DUU1
      REAL(kind=8), POINTER :: DUV(:)       ! => DUV1
      REAL(kind=8), POINTER :: DVV(:)       ! => DVV1
      ! BTP(MNP) = barotropic pressure (incl TP & wl) at time levels s+1/2
      REAL(kind=8), POINTER :: BTP(:)       ! => MOM_LV_X
      ! QNORMSP1(MNVel) = specified normal flux boundary condition at time level s+1
      REAL(kind=8), POINTER :: QNORMSP1(:)  ! => QN2
      REAL(kind=8), POINTER :: DelT    !DelT = altername for timestep real(8)                

!.RJW merged 9/02/2008 Casey 071219: Added the following variable for cumulative mass balance.
      REAL(kind=8) :: MASSCUM

      COMPLEX(SZ),ALLOCATABLE  :: Gamma(:)   !  Gamma(NFEN): horizontal velocity solution in the complex form u+iv for a specific node
      COMPLEX(SZ),ALLOCATABLE  :: Q(:,:)     !  Q(MNP,NFEN): horizontal velocity solution in the complex form u+iv for all nodes
      REAL(kind=8),ALLOCATABLE :: SIGMA(:)       !  Sigma(NFEN): stretched vertical coordinate levels (-1 to 1)
      REAL(kind=8),ALLOCATABLE :: EVTot(:)       !  EVTot(NFEN): vertical eddy viscosity values at a node
      REAL(kind=8),ALLOCATABLE :: INM(:,:)       !  INM(NFEN,3): Integral used in vertical FE assembly
      REAL(kind=8),ALLOCATABLE :: LVN(:)         !  LVN(NFEN): Integral used in vertical FE assembly
      REAL(kind=8),ALLOCATABLE,TARGET :: WZ(:,:)        !  WZ(MNP,NFEN): "z" vertical velocity, all nodes
      REAL(kind=8),ALLOCATABLE,TARGET :: SIGT(:,:)      !  SIGT(MNP,NFEN): sigma T, all nodes
      REAL(kind=8),ALLOCATABLE,TARGET :: Temp(:,:)      !  TEMP(MNP,NFEN): temperature, all nodes
      REAL(kind=8),ALLOCATABLE,TARGET :: Sal(:,:)       !  Sal(MNP,NFEN): salinity, all nodes
      REAL(kind=8),ALLOCATABLE :: BCP(:,:)       !  BCP(MNP,NFEN): baroclinic pressure, integrated down from surface,all nodes
      REAL(kind=8),ALLOCATABLE,TARGET :: Q20(:,:)       !  Q20(MNP,NFEN): Turbulent Kinetic Energy computed by Mellor-Yamada L2.5 closure, all nodes
      REAL(kind=8),ALLOCATABLE,TARGET :: L(:,:)         !  L(MNP,NFEN): turbulent length scale computed by Mellor-Yamada L2.5 closure, all nodes
      REAL(kind=8),ALLOCATABLE,TARGET :: EV(:,:)        !  EV(MNP,NFEN): Vertical eddy viscosity, all nodes

! arash 12/08/2015: variables for biharmonic viscosity operator
      COMPLEX(SZ),ALLOCATABLE  :: Biharmonic_auxiliary_var(:,:)         ! since we need to compute the Laplacian twice, we need an auxiliary variable to store the first Laplacian for U and V.
! arash 12/21/2015: variables for modified Leith viscosity
      COMPLEX(SZ),ALLOCATABLE  :: d_dx_q_nodes (:,:), d_dy_q_nodes (:,:)
! arash 01/04/2016: biharmonic for transport equation
      REAL(kind=8),Allocatable  :: Biharmonic_viscosity_modified_Leith (:,:)
      REAL(kind=8),ALLOCATABLE  :: Biharmonic_auxiliary_var_SalOrTemp (:,:)
      REAL(kind=8),ALLOCATABLE  :: d_dx_SalOrTemp_nodes (:,:), d_dy_SalOrTemp_nodes (:,:)

!     kmd45.12 Added in variables for transport

      REAL(kind=8),ALLOCATABLE :: Gammatrans(:)  !  Gammatrans(NFEN): horizontal transport soln for a specific node
      REAL(kind=8),ALLOCATABLE :: Tempkp1(:,:)   !  Tempkp1(MNP,NFEN): temperature of all nodes at future time level
      REAL(kind=8),ALLOCATABLE :: Salkp1(:,:)    !  Salkp1(MNP,NFEN): salinity of all nodes at future time level

!     kmd45.12 Added in these variables for the top boundary conditions
!     associated with the temperature field

      REAL(kind=8), ALLOCATABLE, TARGET :: qsurfkp1(:)
      REAL(kind=8), ALLOCATABLE :: qsurf(:)

!     kmd45.12 Added in the variables for saving 3D velocities for two
!     time levels

      COMPLEX(SZ),ALLOCATABLE  :: Qkp1(:,:) !  Qkp1(MNP,NFEN): horiz vel in the complex form u+iv for all nodes at the future time level
!arash 2016 Mar 22
      COMPLEX(SZ),ALLOCATABLE  :: Qkm1(:,:) !  Qkm1(MNP,NFEN): horiz vel in the complex form u+iv for all nodes at the previous time level
      REAL(kind=8),ALLOCATABLE :: WZkm1(:,:)    !  WZkm1(MNP,NFEN): "z" vertical velocity at all nodes for the previous time level

      REAL(kind=8),ALLOCATABLE :: WZkp1(:,:)    !  WZkp1(MNP,NFEN): "z" vertical velocity at all nodes for the future time level

!     kmd45.12 added in for baroclinic changes

      COMPLEX(SZ), ALLOCATABLE :: BPG(:,:)
      COMPLEX(SZ), ALLOCATABLE :: BPG_nodes(:,:)

!     kmd48.33bc - added these variables for the vertical diffusion terms in the transport equation
!              Note: terms used when vertical eddy viscosity is defined from Mellor-Yamada
      REAL(kind=8),ALLOCATABLE :: NTVTot(:)     !  NTVTot(NFEN): vertical diffusion values for transport
      REAL(kind=8),ALLOCATABLE :: DV(:,:)       !  DV(MNP,NFEN): Vertical diffusion, all nodes

!     kmd48.33bc - added these variables for boundary condtions
      REAL(kind=8),ALLOCATABLE :: RESSAL(:,:)    !  RESSAL(NETA,NFEN): Vertical salinity boundary condition used in transport
      REAL(kind=8),ALLOCATABLE :: RESSAL1(:,:)   !  RESSAL1(NETA,NFEN): Vertical salinity boundary condition used in transport
      REAL(kind=8),ALLOCATABLE :: RESSAL2(:,:)   !  RESSAL2(NETA,NFEN): Vertical salinity boundary condition used in transport
      REAL(kind=8),ALLOCATABLE :: RESTEMP(:,:)   !  RESTEMP(NETA,NFEN): Vertical temperature boundary condition used in transport
      REAL(kind=8),ALLOCATABLE :: RESTEMP1(:,:)  !  RESTEMP1(NETA,NFEN): Vertical temperature boundary condition used in transport
      REAL(kind=8),ALLOCATABLE :: RESTEMP2(:,:)  !  RESTEMP2(NETA,NFEN): Vertical temperature boundary condition used in transport
!     ! kmd - added these variables for river boundary conditions in baroclinic simulation
      REAL(kind=8),ALLOCATABLE :: BCRivSal(:,:)    !  BCRivSal(NVEL,NFEN) : Vertical salinity boundary information for rivers
      REAL(kind=8),ALLOCATABLE :: BCRivSalN1(:,:)  !  BCRivSal(NVEL,NFEN) : Vertical salinity boundary information for rivers
      REAL(kind=8),ALLOCATABLE :: BCRivSalN2(:,:)  !  BCRivSal(NVEL,NFEN) : Vertical salinity boundary information for rivers
      REAL(kind=8),ALLOCATABLE :: BCRivTemp(:,:)   !  BCRivTemp(NVEL,NFEN): Vertical temperature boundary information for rivers
      REAL(kind=8),ALLOCATABLE :: BCRivTempN1(:,:) !  BCRivTemp(NVEL,NFEN): Vertical temperature boundary information for rivers
      REAL(kind=8),ALLOCATABLE :: BCRivTempN2(:,:) !  BCRivTemp(NVEL,NFEN): Vertical temperature boundary information for rivers

!...  DECLARE 3D GLOBAL SCALARS

      REAL(kind=8) :: GORho                ! = G/RhoWat0
      REAL(kind=8) :: GORhoOAMB            ! = GORho/AMB
      INTEGER  :: IGC                  !vertical grid code
      REAL(kind=8) :: KP                   !3D bottom friction coefficient
      REAL(kind=8) :: EVMin, EVCon         !minimum vertical eddy viscosity and vertical eddy viscosity constant
      REAL(kind=8) :: Z0S, Z0B             !surface and bottom roughnesses 
      REAL(kind=8) :: Alp1,Alp2,Alp3       !time stepping coefficients
      REAL(kind=8) :: DTALP2, DT1MALP2     !DelT*alpha2, DelT*(1-alpha2)
      REAL(kind=8) :: DTALP3, DT1MALP3     !DelT*alpha3, DelT*(1-alpha3)
      REAL(kind=8) :: THETA1, THETA2       !timestepping coefficients for MY L2.5 TKE calculations
      REAL(kind=8), PARAMETER ::  A= 1.E0  !Value of Sigma at the surface
      REAL(kind=8), PARAMETER ::  B=-1.E0  !Value of Sigma at the bottom
      REAL(kind=8), PARAMETER ::  AMB=A-B

      INTEGER  :: NFEN                 !Number of nodes in the vertical
      INTEGER  :: ISLIP                !bottom slip coefficient flag (0=no slip, 1=linear, 2=quadratic)
      INTEGER  :: IEVC                 !eddy viscosity flag determine type of EV used

      COMPLEX(SZ) :: IDTALP1              !i*DelT*alpha1
      COMPLEX(SZ) :: IDT1MALP1            !i*DelT*(1-alpha1)
      COMPLEX(SZ),  PARAMETER ::  iy=(0.0e0, 1.0e0)   !imaginary i

!...Terms added for the transport parameters !kmd45.11 transport
      REAL(kind=8) :: NLSD, NVSD           !diffusion coefficients for the salinity field
      REAL(kind=8) :: NLTD, NVTD           !diffusion coefficients for the temperature field
      REAL(kind=8) :: Alp4                 !time weighting coefficient for the vertical diffusion term in the transport equation
      INTEGER :: NTF                  !Flag for the top boundary condition for the temperature field in the transport equation
      REAL(kind=8) :: DTALP4, DT1MALP4     !DelT*alpha4, DelT*(1-alpha4)

!   kmd48.33bc - added term for baroclinic
      INTEGER :: EQNSTATE ! determine equation of state to be used

!...Declare and initialize logical variables

      LOGICAL  :: C3D_BTrans     = .FALSE.      !if true, then 3D prognostic baroclinic run
      LOGICAL  :: C3D_PTrans     = .FALSE.      !if true, then 3D passive scalar transport included
      LOGICAL  :: turb_allocated = .FALSE.
!
      REAL(kind=8) :: TO3DSDS, TO3DSDF !3D Density station output start & end times
      REAL(kind=8) :: TO3DSVS, TO3DSVF !3D Velocity station output start&end times
      REAL(kind=8) :: TO3DSTS, TO3DSTF !3D Turbulence station output start&end times
      REAL(kind=8) :: TO3DGDS, TO3DGDF !3D Global density output start&end times
      REAL(kind=8) :: TO3DGVS, TO3DGVF !3D Global velocity output start&end times
      REAL(kind=8) :: TO3DGTS, TO3DGTF !3D Global turbulence output start&end times
!...3D Station Density Output (fort.41)

!     I3DSD    - flag for 3D station density output
!       If ABS(I3DSD)>0 densities are interpolated to stations and written out
!       If ABS(I3DSD)=1, output is ascii. If ABS(I3DSD)=2, output is binary.
      INTEGER :: I3DSD
      INTEGER :: NSpo3DSD     !3D station density output interval in timesteps
      INTEGER :: NTO3DSDS     !TO3DSDS converted to timesteps after StaTime
      INTEGER :: NTO3DSDF     !TO3DSDF converted to timesteps after StaTime
      INTEGER :: NDSet3DSD    !total number of times that 3D density station data will be written
      INTEGER :: N3DSD        !counter to determine if it is time to write 3D density station data
      INTEGER :: I3DSDRec     !record counter for binary file writes
      INTEGER :: NSta3DD      !number of 3D density stations
      INTEGER :: NSta3DD_G    !jgf47.06 global number of 3D density stations
      INTEGER :: MNSta3DD     !larger of 1 or NSta3DD, used to dimension arrays
      INTEGER, ALLOCATABLE :: NE3DD(:)     !element number containing 3D density station N
      REAL(8),ALLOCATABLE :: StaI3DD1(:)   !interpolating factor used to compute output at 3D density station N
      REAL(8),ALLOCATABLE :: StaI3DD2(:)   !interpolating factor used to compute output at 3D density station N
      REAL(8),ALLOCATABLE :: StaI3DD3(:)   !interpolating factor used to compute output at 3D density station N
      REAL(kind=8),ALLOCATABLE,TARGET :: SigTSta(:,:)   !3D Sigma T station output - not a global variable but easier to allocate here
      REAL(kind=8),ALLOCATABLE,TARGET :: TempSta(:,:)   !3D Temperature station output - not a global variable but easier to allocate here
      REAL(kind=8),ALLOCATABLE,TARGET :: SalSta(:,:)    !3D Salinity station output - not a global variable but easier to allocate here
      CHARACTER(50), ALLOCATABLE, TARGET  :: STATNAMED(:)!density station names
      REAL(8),ALLOCATABLE,TARGET :: XED(:)  ! station x coordinate (cartesian)
      REAL(8),ALLOCATABLE,TARGET :: YED(:)  ! station y coordinate (cartesian)
      REAL(8),ALLOCATABLE,TARGET :: SLED(:) ! station lon coordinate
      REAL(8),ALLOCATABLE,TARGET :: SFED(:) ! station lat coordinate


!...3D Velocity station output variables

      INTEGER :: I3DSV        !flag for whether to have 3D station velocity output and format of this output
      INTEGER :: NSpo3DSV     !3D station velocity output interval in timesteps
      INTEGER :: NTO3DSVS     !TO3DSVS converted to timesteps after StaTime
      INTEGER :: NTO3DSVF     !TO3DSVF converted to timesteps after StaTime
      INTEGER :: NDSet3DSV    !total number of times that 3D velocity station data will be written
      INTEGER :: N3DSV        !counter to determine if it is time to write 3D velocity station data
      INTEGER :: I3DSVRec     !record counter for binary file writes
      INTEGER :: NSta3DV      !number of 3D velocity stations
      INTEGER :: NSta3DV_G    !jgf47.06 global number of 3D velocity stations
      INTEGER :: MNSta3DV     !larger of 1 or NSta3DV, used to dimension arrays
      INTEGER, ALLOCATABLE :: NE3DV(:)     !element number containing 3D velocity station N
      REAL(8),ALLOCATABLE :: StaI3DV1(:)   !interpolating factor used to compute output at 3D velocity station N
      REAL(8),ALLOCATABLE :: StaI3DV2(:)   !interpolating factor used to compute output at 3D velocity station N
      REAL(8),ALLOCATABLE :: StaI3DV3(:)   !interpolating factor used to compute output at 3D velocity station N
      REAL(kind=8),ALLOCATABLE,TARGET :: WZSta(:,:)     !vertical velocity station output - not a global variable but easier to allocate here
      !jgf48.50 Declare COMPLEX as size SZ
      COMPLEX(SZ),ALLOCATABLE,TARGET :: qSta(:,:)       !3D velocity station output - not a global variable but easier to allocate here
      CHARACTER(50), ALLOCATABLE, TARGET  :: STATNAMEV3D(:) !vel station names
      REAL(8),ALLOCATABLE,TARGET :: XE3DV(:)  ! station x coordinate (cartesian)
      REAL(8),ALLOCATABLE,TARGET :: YE3DV(:)  ! station y coordinate (cartesian)
      REAL(8),ALLOCATABLE,TARGET :: SLE3DV(:) ! station lon coordinate
      REAL(8),ALLOCATABLE,TARGET :: SFE3DV(:) ! station lat coordinate

!...3D Turbulence station output variables

      INTEGER :: I3DST        !flag for whether to have 3D station turbulence output and format of this output
      INTEGER :: NSpo3DST     !3D station turbulence output interval in timesteps
      INTEGER :: NTO3DSTS     !TO3DSTS converted to timesteps after StaTime
      INTEGER :: NTO3DSTF     !TO3DSTF converted to timesteps after StaTime
      INTEGER :: NDSet3DST    !total number of times that 3D turbulence station data will be written
      INTEGER :: N3DST        !counter to determine if it is time to write 3D turbulence station data
      INTEGER :: I3DSTRec     !record counter for binary file writes
      INTEGER :: NSta3DT      !number of 3D turbulence stations
      INTEGER :: NSta3DT_G    !jgf47.06 global number of 3D turbulence stations
      INTEGER :: MNSta3DT     !larger of 1 or NSta3DT, used to dimension arrays
      INTEGER, ALLOCATABLE :: NE3DT(:)     !element number containing 3D turbulence station N
      REAL(8),ALLOCATABLE :: StaI3DT1(:)   !interpolating factor used to compute output at 3D turbulence station N
      REAL(8),ALLOCATABLE :: StaI3DT2(:)   !interpolating factor used to compute output at 3D turbulence station N
      REAL(8),ALLOCATABLE :: StaI3DT3(:)   !interpolating factor used to compute output at 3D turbulence station N
      REAL(kind=8),ALLOCATABLE, TARGET :: q20Sta(:,:)    !TKE station output - not a global variable but easier to allocate here
      REAL(kind=8),ALLOCATABLE, TARGET :: lSta(:,:)      !turb length scale station output - not a global variable but easier to allocate here
      REAL(kind=8),ALLOCATABLE, TARGET :: EVSta(:,:)     !vertical viscosity station output - not a global variable but easier to allocate here
      CHARACTER(50), ALLOCATABLE, TARGET  :: STATNAMET(:) !turb station names
      REAL(8),ALLOCATABLE,TARGET :: XET(:)  ! station x coordinate (cartesian)
      REAL(8),ALLOCATABLE,TARGET :: YET(:)  ! station y coordinate (cartesian)
      REAL(8),ALLOCATABLE,TARGET :: SLET(:) ! station lon coordinate
      REAL(8),ALLOCATABLE,TARGET :: SFET(:) ! station lat coordinate

!...3D Global density output variables

      INTEGER :: I3DGD        !flag for whether to have 3D global density output and format of this output
      INTEGER :: NSpo3DGD     !3D global density output interval in timesteps
      INTEGER :: NTO3DGDS     !TO3DSDS converted to timesteps after StaTime
      INTEGER :: NTO3DGDF     !TO3DSDF converted to timesteps after StaTime
      INTEGER :: NDSet3DGD    !total number of times that 3D global density data will be written
      INTEGER :: N3DGD        !counter to determine if it is time to write 3D global density data
      INTEGER :: I3DGDRec     !record counter for binary file writes

!...3D Global velocity output variables

      INTEGER :: I3DGV        !flag for whether to have 3D global velocity output and format of this output
      INTEGER :: NSpo3DGV     !3D global velocity output interval in timesteps
      INTEGER :: NTO3DGVS     !TO3DGVS converted to timesteps after StaTime
      INTEGER :: NTO3DGVF     !TO3DGVF converted to timesteps after StaTime
      INTEGER :: NDSet3DGV    !total number of times that 3D global velocity data will be written
      INTEGER :: N3DGV        !counter to determine if it is time to write 3D global velocity data
      INTEGER :: I3DGVRec     !record counter for binary file writes

!...3D Global turbulence output variables

      INTEGER :: I3DGT        !flag for whether to have 3D global turbulence output and format of this output
      INTEGER :: NSpo3DGT     !3D global turbulence output interval in timesteps
      INTEGER :: NTO3DGTS     !TO3DGTS converted to timesteps after StaTime
      INTEGER :: NTO3DGTF     !TO3DGTF converted to timesteps after StaTime
      INTEGER :: NDSet3DGT    !total number of times that 3D global turbulence data will be written
      INTEGER :: N3DGT        !counter to determine if it is time to write 3D global turbulence data
      INTEGER :: I3DGTRec     !record pointer for binary file writes

!     jgf49.44: These variables represent fulldomain arrays and are
!     used in hstart.F for reading fulldomain hotstart files as well as in
!     write_output.F/writeHotstart and writer.F/writeHotstart_through_HSwriter
!     for writing fulldomain hotstart files.
      REAL(kind=8), ALLOCATABLE, TARGET :: DUU_g(:)
      REAL(kind=8), ALLOCATABLE, TARGET :: DUV_g(:)
      REAL(kind=8), ALLOCATABLE, TARGET :: DVV_g(:)
      REAL(kind=8), ALLOCATABLE, TARGET :: UU_g(:)
      REAL(kind=8), ALLOCATABLE, TARGET :: VV_g(:)
      REAL(kind=8), ALLOCATABLE, TARGET :: BSX_g(:)
      REAL(kind=8), ALLOCATABLE, TARGET :: BSY_g(:)
      COMPLEX(SZ), ALLOCATABLE :: Q_g(:,:)
      REAL(kind=8), ALLOCATABLE, TARGET :: WZ_g(:,:)
      REAL(kind=8), ALLOCATABLE, TARGET :: q20_g(:,:)
      REAL(kind=8), ALLOCATABLE, TARGET :: l_g(:,:)
      REAL(kind=8), ALLOCATABLE, TARGET :: EV_g(:,:)
      REAL(kind=8), ALLOCATABLE, TARGET :: SigT_g(:,:)
      REAL(kind=8), ALLOCATABLE, TARGET :: Sal_g(:,:)
      REAL(kind=8), ALLOCATABLE, TARGET :: Temp_g(:,:)
!
!     global array sizes for use in globalio
      integer,allocatable,target :: imap_sta3Dd_lg(:)
      integer,allocatable,target :: imap_sta3Dv_lg(:)
      integer,allocatable,target :: imap_sta3Dt_lg(:)


!-------------------end of data declarations----------------------------------C


      CONTAINS

!
!     Allocate space for arrays used in 3D VS routines
!
      SUBROUTINE ALLOC_3DVS()
      USE GLOBAL, ONLY : DUU1, DUV1, DVV1, BSX1, BSY1, UU2, VV2,
     &   QX2, QY2, QN2
      USE BOUNDARIES, ONLY : NETA, NVEL
      IMPLICIT NONE
      ! jgf: Moved the following line from alloc_main1a since it only 
      ! applies to 3D.
      ALLOCATE(DUU1(MNP),DUV1(MNP),DVV1(MNP),
     &        BSX1(MNP),BSY1(MNP))
      ALLOCATE( SIGMA(NFEN), EVTOT(NFEN) )
      ALLOCATE( GAMMA(NFEN), INM(NFEN,3), LVN(NFEN) )
      ALLOCATE( Q(MNP,NFEN), WZ(MNP,NFEN) )
      ALLOCATE( SIGT(MNP,NFEN), TEMP(MNP,NFEN) )
      ALLOCATE( SAL(MNP,NFEN), BCP(MNP,NFEN) )
      ALLOCATE( Q20(MNP,NFEN), L(MNP,NFEN), EV(MNP,NFEN) )
      ALLOCATE( Gammatrans(NFEN) )
      ALLOCATE( Qkp1(MNP,NFEN), WZkp1(MNP,NFEN) )
! arash 2016 Mar 22
      ALLOCATE( Qkm1(MNP,NFEN), WZkm1(MNP,NFEN) )

      ALLOCATE( SALkp1(MNP,NFEN), TEMPkp1(MNP,NFEN) )
      ALLOCATE( qsurfkp1(MNP), qsurf(MNP) )
      ALLOCATE( BPG(MNP,NFEN) )
! arash
      ALLOCATE( Biharmonic_auxiliary_var(MNP,NFEN) )
      ALLOCATE( d_dx_q_nodes(MNP,NFEN), d_dy_q_nodes(MNP,NFEN) )
! arash 01/04/2016
      Allocate( Biharmonic_viscosity_modified_Leith (MNP,NFEN) ) 
      ALLOCATE( Biharmonic_auxiliary_var_SalOrTemp (MNP,NFEN) )
!      ALLOCATE( d_dx_SalOrTemp_nodes (MNP,NFEN), d_dy_SalOrTemp_nodes (MNP,NFEN) )

!      ALLOCATE( BPG_nodes(MNP,NFEN) )
!   kmd48.33bc - allocate arrays
      ALLOCATE( NTVTot(NFEN), DV(MNP,NFEN) )
      ALLOCATE( RESSAL(NETA,NFEN), RESSAL1(NETA,NFEN) )
      ALLOCATE( RESSAL2(NETA,NFEN), RESTEMP(NETA,NFEN) )
      ALLOCATE( RESTEMP1(NETA,NFEN), RESTEMP2(NETA,NFEN) )
      ! jgf49.60: Explicitly initialize arrays that would otherwise
      ! be used without initialization.
      EVTot(:) = 0.0e0
!   kmd - add arrays for river boundary condition in baroclinic simulation
      ALLOCATE( BCRivSal(NVEL,NFEN), BCRivSalN1(NVEL,NFEN) )
      ALLOCATE( BCRivSalN2(NVEL,NFEN), BCRivTemp(NVEL,NFEN) )
      ALLOCATE( BCRivTempN1(NVEL,NFEN), BCRivTempN2(NVEL,NFEN) )
      !
      ! jgf: Assign pointers explicitly here after memory allocation 
      ! for targets in 2DDI code instead of assigning them in the 
      ! USE GLOBAL, ONLY statement above.  
      BSX => BSX1
      BSY => BSY1
      UU => UU2
      VV => VV2
      DAFluxX => QX2
      DAFluxY => QY2
      DUU => DUU1
      DUV => DUV1
      DVV => DVV1
      BTP => MOM_LV_X  
      QNORMSP1 => QN2   

      RETURN
      END SUBROUTINE ALLOC_3DVS

!
!     Allocate space for arrays used in 3D Density station output
!
      SUBROUTINE ALLOC_3DSD()
      IMPLICIT NONE
      ALLOCATE( NE3DD(MNSta3DD) )
      ALLOCATE( StaI3DD1(MNSta3DD), StaI3DD2(MNSta3DD),
     &                              StaI3DD3(MNSta3DD) )
      ALLOCATE( SigTSta(MNSTA3DD,NFEN), SalSta(MNSTA3DD,NFEN),
     &          TempSta(MNSTA3DD,NFEN) )
      ALLOCATE(STATNAMED(MNSTA3DD))
      ALLOCATE(XED(MNSTA3DD),YED(MNSTA3DD),
     &         SLED(MNSTA3DD),SFED(MNSTA3DD))
      RETURN
      END SUBROUTINE ALLOC_3DSD

!
!     Allocate space for arrays used in 3D Velocity station output
!
      SUBROUTINE ALLOC_3DSV()
      IMPLICIT NONE
      ALLOCATE( NE3DV(MNSta3DV) )
      ALLOCATE( StaI3DV1(MNSta3DV), StaI3DV2(MNSta3DV),
     &                              StaI3DV3(MNSta3DV) )
      ALLOCATE( qSta(MNSTA3DV,NFEN), WZSta(MNSTA3DV,NFEN) )
      ALLOCATE(STATNAMEV3D(MNSTA3DV))
      ALLOCATE(XE3DV(MNSTA3DV),YE3DV(MNSTA3DV),
     &         SLE3DV(MNSTA3DV),SFE3DV(MNSTA3DV))
      RETURN
      END SUBROUTINE ALLOC_3DSV

!
!     Allocate space for arrays used in 3D Turbulence station output
!
      SUBROUTINE ALLOC_3DST()
      IMPLICIT NONE
      ALLOCATE( NE3DT(MNSta3DT) )
      ALLOCATE( StaI3DT1(MNSta3DT), StaI3DT2(MNSta3DT),
     &                              StaI3DT3(MNSta3DT) )
      ALLOCATE( q20Sta(MNSTA3DT,NFEN), lSta(MNSTA3DT,NFEN),
     &          EVSta(MNSTA3DT,NFEN) )
      ALLOCATE(STATNAMET(MNSTA3DT))
      ALLOCATE(XET(MNSTA3DT),YET(MNSTA3DT),
     &         SLET(MNSTA3DT),SFET(MNSTA3DT))
      RETURN
      END SUBROUTINE ALLOC_3DST

!***********************************************************************
!                                                                      *
!     SUBROUTINE TO SET UP THE VERTICAL FINITE ELEMENT GRID            *
!                                                                      *
!                           6/16/2005                                  *
!***********************************************************************
!
      SUBROUTINE FEGRIDS(IGC,H)
      USE GLOBAL, ONLY : ScreenUnit

      IMPLICIT NONE
      INTEGER :: IGC,N,NFEN2,IANS,NUM,I,NH
      REAL(kind=8) :: H,DETA,SSTAR,DENOM,SIG0,SS,SB,RP,AVAL,EPS
!
      call setMessageSource("fegrids")
#if defined(GLOBAL_3DVS_TRACE) || defined(ALL_TRACE)
      call allMessage(DEBUG,"Enter.")
#endif

      select case(igc)
!
!     igc = 0 - Read in grid from UNIT 15 in subroutine READ_INPUT_3DVS
!

!
!     igc = 1 - Evenly spaced grid
!
      case(1)
         if(nfen.le.1) nfen = 2
         deta = (a-b)/(nfen-1)
         sigma(1) = b
         do n=2,nfen-1
            sigma(n) = b + deta*(n-1)
         end do
         nfen2 = nfen/2
         if(2*nfen2.ne.nfen) sigma(nfen2+1) = 0.e0
         sigma(nfen) = a
!
!     igc = 2 - logarithmically grid  (after Davies 1991)
!
      case(2)
         write(screenunit,*) '   '
         write(screenunit,*) '********** Depth = ',H,' ***********'
         write(screenunit,*) '********** So = ',Z0B,' *********'
         Sb = Z0B
!     write(screenunit,*) '********** Enter So from the keyboard ***********'
!     write(screenunit,*) '   '
!     read(*,*) Sb
         if(nfen.le.1) nfen = 2
         deta = 1.e0/(nfen-1)
         sigma(1) = b
         do n=2,nfen-1
            sigma(n) = b + (a-b)*Sb/H*(((H+Sb)/Sb)**(deta*(n-1))-1.e0)
         enddo
         sigma(nfen) = a
!
!     igc = 3 - log-linear grid  (after Davies 1991)
!
      case(3)
         write(screenunit,*) '   '
         write(screenunit,*) '********** Depth = ',H,' ***********'
         write(screenunit,*) '********** So = ',Z0B,' ****'
         write(screenunit,*) '********** S* = ',-H-Sb,' **********'
         Sb = Z0B
         Sstar = -H-Sb
         write(screenunit,*)
     &      '******** Enter So from the keyboard *******'
         write(screenunit,*) '   '
         read(*,*) Sb
         write(screenunit,*)
     &      '******** Enter S* from the keyboard *******'
         write(screenunit,*) '   '
         read(*,*) Sstar
         if(nfen.le.1) nfen = 2
         deta = 1.e0/(nfen-1)
         denom = log((H+Sb)/Sb) + H/Sstar
         sigma(1) = b
         do n=2,nfen-1
            sig0 = b + (a-b)*deta*(n-1)
            do while(.true.)
               sigma(n)= b - (a-b)*Sstar/H*(log(1.e0+H/Sb*(sig0-b)/(a-b))
     +              -denom*deta*(n-1))
               if(abs(sigma(n)-sig0).ge.1.d-8)then
                  sig0 = sigma(n)
                  cycle
               endif
               exit
            enddo
         enddo
         sigma(nfen) = a
!
!     igc = 4 - Double logarithmic grid
!
      case(4)
         write(screenunit,*) '   '
         write(screenunit,*) '********** Depth = ',H,' ***********'
         write(screenunit,*)
     &       '********** So bottom = ',Z0B,' ***********'
         Sb = Z0B
         write(screenunit,*)
     &       '********** So surface = ',Z0S,' ***********'
         Ss = Z0S
!
!     write(screenunit,*) '******* Enter So bottom from the keyboard ********'
!     write(screenunit,*) '   '
!     read(*,*) Sb
!     write(screenunit,*) '******* Enter So surface from the keyboard *******'
!     write(screenunit,*) '   '
!     read(*,*) Ss
!
         write(screenunit,*) '   '
         if(mod(nfen,2).eq.0) then
            write(screenunit,*)
     &         '**********************************WARNING*****',
     &         '******************************'
            write(screenunit,*)
     &         '**** You have specified a double log grid with',
     &           ' an even number of nodes. ****'
            write(screenunit,*)
     &           '**** Much better results are obtained using an',
     &           ' an odd number of nodes.  ****'
            write(screenunit,*)
     &           '**** Do you want to terminate now or continue?',
     &           '  0=Terminate/1=continue. ****'
            write(screenunit,*) '  '
            read(*,*) ians
            if(ians.ne.1) CALL EXIT(1)
            num = nfen/2
         else
            num=(nfen-1)/2
            sigma(num+1)=(a+b)/2.
         endif
         deta = 2.e0/(nfen-1)
         sigma(1) = b
         sigma(nfen) = a
         do n=2,num
            sigma(n)
     &        = b + 0.5e0*(a-b)*Sb/H*(((H+Sb)/Sb)**(deta*(n-1))-1.e0)
            sigma(nfen+1-n) = a - 0.5e0*(a-b)*Ss/H*(((H+Ss)/Ss)**
     &           (deta*(n-1))-1.e0)
         enddo
!
!     igc = 5 - "P-grid" after Fortunato and Baptista (IJNMF submitted 12/1994)
!     optimal p value of 0.25 may be used as default for tidal flow problems
!     note: p = 1 - uniform, p<1 makes fine grid near bottom,p>1 makes
!     fine grid near sfc
!     sigma converted to range from -1 to 1 in ADCIRC
!
      case(5)
         if(nfen.le.1) nfen = 2
         write(screenunit,*)
         write(screenunit,*)' Enter P value for P - grid'
         write(screenunit,*)
         read(*,*)rp
         do i = 1,nfen
            sigma(i) = -1.e0 + 2.e0
     &          *(1.e0+((1.e0-i)/(1.e0-nfen))**(1.e0/rp) - 1.e0)
         end do
!
!     igc = 6 - "sine grid" after Naimie,Lynch
!     Value of A determines stretching at ends, check in unit 18
!     sigma converted to range from -1 to 1 in ADCIRC
!
      case(6)
         if(nfen.le.1) nfen = 2
         write(screenunit,*)
         write(screenunit,*)' Enter A value for sine grid'
         write(screenunit,*)
         read(*,*)aval
         do i = 1,nfen
            eps = float(i-1)/float(nfen-1)
            sigma(i) = -1.e0
     &         + (2.e0/H)*(eps*H-aval*sin(2.e0*3.14159e0*eps))
         end do
      case default
         write(screenunit,4321) igc
4321     format('The value of igc=',I2,' is not valid. There are seven',
     &   /,'choices for specifying the vertical grid spacing in 3D.',
     &   /,'Please specify a value for igc from 0 to 6.',
     &   /,'**ADCIRC run terminated due to bad value for igc.**')
         CALL EXIT(1)

      end select

#if defined(GLOBAL_3DVS_TRACE) || defined(ALL_TRACE)
      call allMessage(DEBUG,"Return.")
#endif
      call unsetMessageSource()
      RETURN

!******************************************************************************
      END SUBROUTINE FEGRIDS
!******************************************************************************



      END MODULE GLOBAL_3DVS
