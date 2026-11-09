class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.7/flux-macos-arm64"
      sha256 "afff77ce31184fcdc193cc104f72c1a669c8e6d4fe6c81ffac580467a7583262"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.7/flux-macos-amd64"
      sha256 "7d7d9e513a2210879a45a0a3745c35f83a9b898a5137f0f2ab3d93c902a7f5bd"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.7/flux-linux-amd64"
      sha256 "2fbfa40b7c5c8446d57016d1e0f2ac0facde985e62be3d8bad8f08fa8710b63f"
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
