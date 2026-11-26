class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.36/flux-macos-arm64"
      sha256 "c389222bebd66982a9cdab758f0509a61b8ec0b7f54ef32e0f695458f33beb51"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.36/flux-macos-amd64"
      sha256 "f2da7b3d583af8a04862895ffb1054809effd0cd3198460aa051ded069950173"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.36/flux-linux-amd64"
      sha256 "837794d773ea7b0c8cf0195cb1e7cf733327219f095bb2cd38360272d2059717"
    end
  end

  option "with-cli-update-guard", "Check the version selected by the automatic CLI updater"

  def install
    # Explicit brew upgrades do not set this variable, even if the option is retained in the receipt.
    expected = ENV["HOMEBREW_FLUXZERO_CLI_UPDATE_VERSION"]
    if expected && version.to_s != expected
      raise "CLI update deferred: requested #{expected}, but Homebrew now offers #{version}"
    end

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
