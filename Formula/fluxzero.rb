class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.12/flux-macos-arm64"
      sha256 "1190b8060f0f5a2bcb5ca27939d3321dfe441cdcd6f17d001d40f855c1908d5c"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.12/flux-macos-amd64"
      sha256 "f5662b1c148a11f3f8e9c956871ca50726df5abdaf29bc5c5ac1de10adb199da"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.12/flux-linux-amd64"
      sha256 "1dd65745f1068c594d0b9d94ab02ba4c58f1e9ba78f6430433b64fcf6bbcc5f8"
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
