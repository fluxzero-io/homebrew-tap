class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.37/flux-macos-arm64"
      sha256 "3efdc8bf23b61ad02e1dad751158d93bb8a8d2e27072830549f79e496176cbcc"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.37/flux-macos-amd64"
      sha256 "a1aa581765d3bfb06f143e1346b087499e50862d04ac50dbfcc2bb9f8dec9080"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.37/flux-linux-amd64"
      sha256 "32db41c87760ba6e4514457771d21c286b061d0f3fa86201e8f637365a9d506c"
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
