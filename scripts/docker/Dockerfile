FROM ubuntu:18.04
WORKDIR /root/

# rose depends 1
RUN /bin/bash -c 'echo && \
    apt-get update && \
    apt-get install -y \
        git=1:2.17.1-1ubuntu0.18 \
        wget=1.19.4-1ubuntu2.2 \
        build-essential=12.4ubuntu1 \
        libtool=2.4.6-2 \
        automake=1:1.15.1-3ubuntu2 \
        flex=2.6.4-6 \
        bison=2:3.0.4.dfsg-1build1 \
        openjdk-8-jre=8u372-ga~us1-0ubuntu1~18.04 \
        openjdk-8-jdk=8u372-ga~us1-0ubuntu1~18.04 \
        ghostscript=9.26~dfsg+0-0ubuntu0.18.04.18 \
        libopenblas-dev=0.2.20+ds-4'

# rose depends 2 (gfortran 7.4.0)
RUN /bin/bash -c 'echo && \
    git clone --depth 1 -b releases/gcc-7.4.0 https://github.com/gcc-mirror/gcc.git && \
    cd /root/gcc && \
    wget --no-check-certificate -O gmp-4.3.2.tar.gz https://ftp.gnu.org/gnu/gmp/gmp-4.3.2.tar.gz && \
    tar -xf gmp-4.3.2.tar.gz && \ 
    mv gmp-4.3.2 gmp && \
    wget --no-check-certificate -O mpfr-3.1.0.tar.gz https://www.mpfr.org/mpfr-3.1.0/mpfr-3.1.0.tar.gz && \
    tar -xf mpfr-3.1.0.tar.gz && \
    mv mpfr-3.1.0 mpfr && \
    wget --no-check-certificate -O mpc-1.0.1.tar.gz https://ftp.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz && \
    tar -xf mpc-1.0.1.tar.gz && \
    mv mpc-1.0.1 mpc && \
    mkdir /root/gcc-build && \
    cd /root/gcc-build && \
    /root/gcc/configure --disable-multilib --enable-languages=fortran && \
    make && \
    make install && \
    cd /root && \
    rm -rf /root/gcc-build /root/gcc'

# rose depends 3 (boost 1.57.0)
RUN /bin/bash -c 'echo && \
    mkdir -p  /usr/lib/boost/1.57.0 && \
    wget -O boost-1.57.0.tar.bz2 http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2/download && \ 
    tar xf boost-1.57.0.tar.bz2 && \
    rm boost-1.57.0.tar.bz2 && \
    pushd boost_1_57_0 && \
    ./bootstrap.sh --prefix=/usr/lib/boost/1.57.0 --with-libraries=chrono,date_time,filesystem,iostreams,program_options,random,regex,serialization,signals,system,thread,wave,graph && \
    ./b2 --prefix=/usr/lib/boost/1.57.0 -sNO_BZIP2=1 install && \
    popd && \
    rm -rf boost_1_57_0'

# mom6 depends
RUN /bin/bash -c 'echo && \
    export DEBIAN_FRONTEND=noninteractive && \
    export TZ=Etc/UTC && \
    apt-get update && \
    apt-get install -y \
        tzdata=2023c-0ubuntu0.18.04 \
        csh=20110502-3ubuntu0.18.04.1 \
        make=4.1-9.1ubuntu1 \
        openmpi-bin=2.1.1-8 \
        libopenmpi-dev=2.1.1-8 \
        libnetcdf-dev=1:4.6.0-2build1 \
        libnetcdff-dev=4.4.4+ds-3 \
        netcdf-bin=1:4.6.0-2build1'

# mpas depends
RUN /bin/bash -c 'echo && \
        wget https://parallel-netcdf.github.io/Release/parallel-netcdf-1.8.1.tar.gz && \
        tar -xvf parallel-netcdf-1.8.1.tar.gz && \
        rm parallel-netcdf-1.8.1.tar.gz && \
        pushd parallel-netcdf-1.8.1 && \
        export CC=gcc && \
        export FC=gfortran && \
        export F77=gfortran && \
        export MPICC=mpicc && \
        export MPIF90=mpif90 && \
        export MPIF77=mpif90 && \
        export PNETCDF=/root/pnetcdf && \
        ./configure --prefix=${PNETCDF} --disable-cxx && \
        make && \
        make install && \
        popd && \
        rm -rf parallel-netcdf-1.8.1 && \
        wget https://github.com/NCAR/ParallelIO/archive/refs/tags/pio1_7_1.tar.gz && \
        tar -xvf pio1_7_1.tar.gz && \
        rm pio1_7_1.tar.gz && \
        pushd ParallelIO-pio1_7_1/pio && \
        export MPIFC=mpif90 && \
        export PNETCDF_PATH=${PNETCDF} && \
        export PIO=/root/PIO && \
        ./configure --prefix=${PIO} --disable-netcdf --disable-mpiio && \
        make && \
        make install && \
        popd && \
        rm -rf ParallelIO-pio1_7_1/'

ENV LD_LIBRARY_PATH="/usr/local/lib64:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:/usr/lib/boost/1.57.0/lib:${LD_LIBRARY_PATH}"

# build ROSE
RUN /bin/bash -c 'echo && \
    git clone --depth 1 -b precimonious-w-rose https://github.com/ucd-plse/ROSE /root/ROSE && \
    cd ROSE && \
    ./build && \
    mkdir -p /usr/lib/ROSE/build && \
    cd /usr/lib/ROSE/build && \
    /root/ROSE/configure --prefix=/usr/lib/ROSE/install --enable-languages=fortran --with-boost=/usr/lib/boost/1.57.0 && \
    make core -j$(nproc --all) && \
    make install-core -j$(nproc --all) && \
    rm -rf /root/ROSE'

# build GPTL
RUN /bin/bash -c 'echo && \
    wget https://github.com/jmrosinski/GPTL/releases/download/v8.1.1/gptl-8.1.1.tar.gz && \
    tar -xvf gptl-8.1.1.tar.gz && \
    rm gptl-8.1.1.tar.gz && \
    mv gptl-8.1.1 gptl-8.1.1_src && \
    mkdir -p gptl-8.1.1/install && \
    pushd gptl-8.1.1_src && \
    export CC=mpicc && \ 
    export FC=mpif90 && \
    ./configure --prefix=/root/gptl-8.1.1/install && \
    make && \
    make install && \
    popd && \
    rm -rf gptl-8.1.1_src'


# set up python
RUN /bin/bash -c 'echo && \
    apt-get -y install \
        python3.8=3.8.0-3ubuntu1~18.04.2 \
        virtualenv=15.1.0+ds-1.1 && \
    virtualenv --python=python3.8 .venv && \
    echo "source .venv/bin/activate" >> .bashrc && \
    source .venv/bin/activate && \
    pip3 install \
        plotly==5.18.0 \
        numpy==1.24 \
        pandas==2.0.3 \
        networkx==3.1 \
        xarray==2023.1.0 \
        scipy==1.10.1'

# environment
ENV LD_LIBRARY_PATH="/root/gptl-8.1.1/install/lib:${LD_LIBRARY_PATH}"
ENV PATH="/root/artifact/scripts:/usr/lib/ROSE/install/bin:${PATH}"
ENV ROSE_EXE_PATH="/usr/lib/ROSE/install/bin"
ENV PROSE_PLUGIN_PATH="/root/artifact/src/cpp"
ENV PIO="/root/PIO"
ENV PNETCDF="/root/pnetcdf"
ENV PROSE_REPO_PATH="/root/artifact"
ENV OMPI_MCA_btl_vader_single_copy_mechanism="none"
RUN /bin/bash -c 'git config --global --add safe.directory "*"'