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
  version = "0.19.0-nightly.20251121.5982abeff";

  src = fetchFromGitHub {
    owner = "google-gemini";
    repo = "gemini-cli";
    rev = "v0.19.0-nightly.20251121.5982abeff";
    hash = "sha256-7v3jH1/iDJfyL49PGK2UoaXp9SoOgfXAP1kAgadhhBU=";
  };

  npmDepsHash = "sha256-0FY33bof6vI6oSNa3zd2OSYJNYj0kX7q93i/qLnopEc=";

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
    ${jq}/bin/jq 'del(.optionalDependencies."node-pty")' package.json > package.json.tmp && mv package.json.tmp package.json
    ${jq}/bin/jq 'del(.optionalDependencies."node-pty")' packages/core/package.json > packages/core/package.json.tmp && mv packages/core/package.json.tmp packages/core/package.json
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
