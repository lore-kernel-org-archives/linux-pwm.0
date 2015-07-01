From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 0/12] Discover and probe dependencies
Date: Wed,  1 Jul 2015 11:40:55 +0200
Message-ID: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Pawel Moll <pawel.moll@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Le
List-Id: linux-pwm@vger.kernel.org

Hi,

this is version 2 of a series that probes devices in dependency order so
as to avoid deferred probes. While deferred probing is a powerful
solution that makes sure that you eventually get a working system at the
end of the boot, can make it very time consuming to find out why a
device didn't probe and can also introduce big delays in when a device
actually probes by sending it to the end of the deferred queue.

So far I have only tested on a Tegra124 Chromebook.

Thanks,

Tomeu

Changes in v2:
- Instead of delaying all probes until late_initcall, only delay matches
  of platform devices that have a firmware node attached.
- Allow bindings implementations register a function instead of using
  class callbacks, as not only subsystems implement firmware bindings.
- Move strends to string.h
- Document that consumers of backlight devices can use the 'backlight'
  property to hold a phandle to the backlight device.
- Allocate the list of dependencies and pass it to the function that
  fills it.

Tomeu Vizoso (12):
  device: property: delay device-driver matches
  device: property: find dependencies of a firmware node
  string: Introduce strends()
  gpio: register dependency parser for firmware nodes
  gpu: host1x: register dependency parser for firmware nodes
  backlight: Document consumers of backlight nodes
  backlight: register dependency parser for firmware nodes
  USB: EHCI: register dependency parser for firmware nodes
  regulator: register dependency parser for firmware nodes
  pwm: register dependency parser for firmware nodes
  ASoC: tegra: register dependency parser for firmware nodes
  driver-core: probe dependencies before probing

 .../bindings/video/backlight/backlight.txt         |  22 ++++
 drivers/base/dd.c                                  | 139 +++++++++++++++++++++
 drivers/base/property.c                            | 120 ++++++++++++++++++
 drivers/gpio/gpiolib.c                             |  54 ++++++++
 drivers/gpu/host1x/dev.c                           |  26 ++++
 drivers/pwm/core.c                                 |  28 +++++
 drivers/regulator/core.c                           |  27 ++++
 drivers/usb/host/ehci-tegra.c                      |  16 +++
 drivers/video/backlight/backlight.c                |  16 +++
 include/linux/fwnode.h                             |   5 +
 include/linux/property.h                           |  12 ++
 include/linux/string.h                             |  13 ++
 sound/soc/tegra/tegra_max98090.c                   |  42 ++++++-
 13 files changed, 519 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/backlight.txt

-- 
2.4.1

