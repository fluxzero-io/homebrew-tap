class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.4.0"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.4.0/flux-macos-arm64"
      sha256 "f8641e65cadfd696dca7dbc074eb11d6cb3ebb803c4964c55f91057d676904ee"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.4.0/flux-macos-amd64"
      sha256 "03a775504acefc72c342ff412a4330d48900fba944f4eaef1f7f130da54163cd"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.4.0/flux-linux-amd64"
      sha256 "240d5b1c53d193ed8c23e208906838ee12ff64b78a9b76a711645385ddc62d5e"
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
