# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]
# See env_vars.sh for extra environment variables
source gfortran-install/gfortran_utils.sh

function build_wheel {
    if [ -z "$IS_OSX" ]; then
        unset FFLAGS
        export LDFLAGS="-shared -Wl,-strip-all"
        # Work round build dependencies spec in pyproject.toml
        build_bdist_wheel $@
    else
        export FFLAGS="$FFLAGS -fPIC"
        build_osx_wheel $@
    fi
}

function set_arch {
    local arch=$1
    export CC="clang $arch"
    export CXX="clang++ $arch"
    export CFLAGS="$arch"
    export FFLAGS="$arch"
    export FARCH="$arch"
    export LDFLAGS="$arch"
}

function build_osx_wheel {
    # Build 64-bit wheel
    # Standard gfortran won't build dual arch objects.
    local repo_dir=${1:-$REPO_DIR}
    local py_ld_flags="-Wall -undefined dynamic_lookup -bundle"

    install_gfortran
    # 64-bit wheel
    local arch="-m64"
    set_arch $arch
    # Build wheel
    export LDSHARED="$CC $py_ld_flags"
    export LDFLAGS="$arch $py_ld_flags"
    export PYFMMLIB_BUILD_MODE="setuptools"
    export FOPT="-Ofast -fopenmp"
    export OPT="-Ofast"
    export EXTRA_LINK_ARGS="-fopenmp"
    build_wheel_cmd "bdist_wheel_cmd" "$repo_dir"
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python -c 'import pyfmmlib'
}

