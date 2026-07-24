class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.11.0"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.0/flux-macos-arm64"
      sha256 "7c913ced08eca1b77bbcc94b4d65946058ec70e2116f8aea755d46e107fe5e6a"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.0/flux-macos-amd64"
      sha256 "a5d4383c45ed096096c3302e806156372f054d96657fde2102cdfe32dd02d8ce"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.0/flux-linux-amd64"
      sha256 "8830d638a953fa3f4a1d11cf3cfb78ef526ee2407584edab1b3d8a50c0946138"
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
