{ lib, stdenv, fetchFromGitHub, makeWrapper, nx-libs, xorg, getopt, gnugrep, gawk, ps, mount, iproute2 }:
stdenv.mkDerivation rec {
  pname = "x11docker";
  version = "7.1.3";
  src = fetchFromGitHub {
    owner = "mviereck";
    repo = "x11docker";
    rev = "v${version}";
    sha256 = "sha256-eSarw5RG2ckup9pNlZtAyZAN8IPZy94RRfej9ppiLfo=";
  };
  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  # Don't install `x11docker-gui`, because requires `kaptain` dependency
  installPhase = ''
    install -D x11docker "$out/bin/x11docker";
    wrapProgram "$out/bin/x11docker" \
      --prefix PATH : "${lib.makeBinPath [ getopt gnugrep gawk ps mount iproute2 nx-libs xorg.xdpyinfo xorg.xhost xorg.xinit ]}"
  '';

  meta = {
    description = "Run graphical applications with Docker";
    homepage = "https://github.com/mviereck/x11docker";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.linux;
  };
}
