class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.13/flux-macos-arm64"
      sha256 "dbe436e8d9ef419acfd29a60567c07ba776f261a9be5a3c957e1523c7de499cd"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.13/flux-macos-amd64"
      sha256 "095811e33037d5f69fa7ea52d4dd2035c88b720479f4b97633b01dc44c935b43"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.13/flux-linux-amd64"
      sha256 "efdd819983d27a4fcb95d815c7570879a5653a6cbf1a8d69b21a44464cd009c3"
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
