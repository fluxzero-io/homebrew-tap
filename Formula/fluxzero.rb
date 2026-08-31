class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.2/flux-macos-arm64"
      sha256 "374d070fb9e2be44d73e0e6e223c4513d5be05cd3f46eb279ff7a778f4306e73"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.2/flux-macos-amd64"
      sha256 "aa7705d2f90502bc85dbec831ea8a770cfb1fa41dba0e0d0b905f728b59969b0"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.2/flux-linux-amd64"
      sha256 "3e0ce001f271b11b98c647337ea0912fd6a7602b9c931122561a86493acd8cf3"
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
