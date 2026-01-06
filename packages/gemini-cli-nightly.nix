{ lib
, buildNpmPackage
, fetchFromGitHub
, jq
, pkg-config
, stdenv
, clang_20
, libsecret
, ripgrep
}:

buildNpmPackage (finalAttrs: {
  pname = "gemini-cli-nightly";
  version = "v0.24.0-nightly.20260103.30f5c4af4";

  src = fetchFromGitHub {
    owner = "google-gemini";
    repo = "gemini-cli";
    rev = "v0.24.0-nightly.20260103.30f5c4af4";
    hash = "sha256-DxNgD+feywjK/PyfvgdaJYHwNNl6++TeXlTOfcgVng4=";
  };

  npmDepsHash = "sha256-LX6DUKpvXysZ2OIq9PX266zhWWao+pNi9k6DFBCUzaM=";

  makeCacheWritable = true;
  npmFlags = [ "--ignore-scripts" "--omit=optional" ];

  nativeBuildInputs = [
    jq
    pkg-config
  ] ++ lib.optionals stdenv.isDarwin [ clang_20 ];

  buildInputs = [
    ripgrep
    libsecret
  ];

  preConfigure = ''
    mkdir -p packages/generated
    echo "export const GIT_COMMIT_INFO = { commitHash: '${finalAttrs.src.rev}' };" > packages/generated/git-commit.ts
  '';

  postPatch = ''
    sed -i '/disableAutoUpdate: {/,/}/ s/default: false/default: true/' packages/cli/src/config/settingsSchema.ts
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/{bin,share/gemini-cli}
    cp -r node_modules $out/share/gemini-cli/
    rm -f $out/share/gemini-cli/node_modules/@google/gemini-cli
    rm -f $out/share/gemini-cli/node_modules/@google/gemini-cli-core
    rm -f $out/share/gemini-cli/node_modules/@google/gemini-cli-a2a-server
    rm -f $out/share/gemini-cli/node_modules/@google/gemini-cli-test-utils
    rm -f $out/share/gemini-cli/node_modules/gemini-cli-vscode-ide-companion
    cp -r packages/cli $out/share/gemini-cli/node_modules/@google/gemini-cli
    cp -r packages/core $out/share/gemini-cli/node_modules/@google/gemini-cli-core
    cp -r packages/a2a-server $out/share/gemini-cli/node_modules/@google/gemini-cli-a2a-server
    # Remove dangling symlinks that point to /build directory
    find $out -type l -lname '/build/*' -delete
    ln -s $out/share/gemini-cli/node_modules/@google/gemini-cli/dist/index.js $out/bin/gemini
    chmod +x "$out/bin/gemini"
    runHook postInstall
  '';

  meta = {
    description = "AI agent that brings the power of Gemini directly into your terminal (nightly)";
    homepage = "https://github.com/google-gemini/gemini-cli";
    license = lib.licenses.asl20;
    maintainers = [ ];
    platforms = lib.platforms.all;
    mainProgram = "gemini";
  };
})
