defmodule LY10SystemRpi3.MixProject do
  use Mix.Project

  @app :ly10_system_rpi3
  @version Path.join(__DIR__, "VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.6",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      aliases: [loadconfig: [&bootstrap/1], docs: ["docs", &copy_images/1]],
      docs: [extras: ["README.md"], main: "readme"]
    ]
  end

  def application do
    []
  end

  defp bootstrap(args) do
    System.put_env("MIX_TARGET", "ly10_rpi3")
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  defp nerves_package do
    [
      type: :system,
      artifact_sites: [
        {:prefix, "https://ly-archive.iotcloud.io/"}
      ],
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      checksum: package_files()
    ]
  end

  defp deps do
    [
      {:nerves_system_br, github: "bcdevices/nerves_system_br", tag: "v1.5.2", runtime: false},
      {:nerves, "~> 1.3", runtime: false},
      {:nerves_toolchain_arm_unknown_linux_gnueabihf, "1.1.0", runtime: false},
      {:nerves_system_linter, "~> 0.3.0", runtime: false},
      {:ex_doc, "~> 0.18", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    LY10 Nerves System - Raspberry Pi 3 B / B+
    """
  end

  defp package do
    [
      maintainers: ["Blue Clover Devices"],
      files: package_files(),
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/bcdevices/ly10-system-rpi3"}
    ]
  end

  defp package_files do
    [
      "package",
      "external.mk",
      "fwup_include",
      "rootfs_overlay",
      "CHANGELOG.md",
      "cmdline.txt",
      "config.txt",
      "fwup-revert.conf",
      "fwup.conf",
      "LICENSE",
      "linux-4.14.defconfig",
      "mix.exs",
      "patches",
      "busybox_defconfig",
      "nerves_defconfig",
      "post-build.sh",
      "post-createfs.sh",
      "README.md",
      "VERSION"
    ]
  end

  # Copy the images referenced by docs, since ex_doc doesn't do this.
  defp copy_images(_) do
    File.cp_r("assets", "doc/assets")
  end
end
