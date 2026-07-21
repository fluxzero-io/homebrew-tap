class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.7.1"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.7.1/flux-macos-arm64"
      sha256 "e10e4784435772de42ae7ffb8783a0429ca2bf746496af9a5dd6be7e4943a51b"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.7.1/flux-macos-amd64"
      sha256 "77b5f6bb40c4d81faddcdb749edc082d2be197bf6534194c5c9ec19148b6385c"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.7.1/flux-linux-amd64"
      sha256 "daffeb91ff7dd9544b7317070d116437ed0363c59f276720600cb0f0428ee95f"
    end
  end

  def install
    binary = if OS.mac?
      Hardware::CPU.arm? ? "flux-macos-arm64" : "flux-macos-amd64"
    else
      "flux-linux-amd64"
    end

    bin.install binary => "fz"
    bin.install_symlink "fz" => "fluxzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fz version")
    assert_equal "fz", File.basename(File.readlink(bin/"fluxzero"))
  end
end
