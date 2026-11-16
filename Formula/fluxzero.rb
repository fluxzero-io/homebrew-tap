class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.21/flux-macos-arm64"
      sha256 "3643b01aeb7992ed0b99ce9050871ff1c8aa1f8477222c04705836ef31722904"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.21/flux-macos-amd64"
      sha256 "34c57b4d911f6b07d66c34ab7fa36beb5aeb578e3d75e24b5b44dbe2900ea103"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.21/flux-linux-amd64"
      sha256 "ac71be9557bad15544fa07df286affee162efb382b76bfe06f1f6c25476f0b36"
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
