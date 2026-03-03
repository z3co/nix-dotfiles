{
rustPlatform,
fetchFromGitHub,
lib,
nasm,
pkg-config
}:
rustPlatform.buildRustPackage rec {
	pname = "imagineer";
	version= "0.24.0";
	src = fetchFromGitHub {
		owner = "foresterre";
		repo = "imagineer";
		tag = "v${version}";
		hash = "sha256-pnnMRRccxSA5F6oIbe9wvdMmuSUMI7Da+NtwyH2psjo=";
	};
	nativeBuildInputs = [
		pkg-config
		nasm
	];
	cargoHash = "sha256-6QMMP6Uss9r6zNd/S6w7yo19IBOQyLmFvcn2o0MkOq4=";
	meta = {
		description = "Imagineer is a cli tool for working with images";
		homepage = "https://github.com/foresterre/imagineer";
		license = lib.licenses.asl20;
		platforms = lib.platforms.linux;

	};
}
