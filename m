From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 0/16] backlight updates
Date: Sun, 17 May 2020 21:01:23 +0200
Message-ID: <20200517190139.740249-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Russell King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

v2:
  - Dropped drm patches that was reviewed and thus applied (Thanks Tomi)
  - Updated backlight_is_blank() based on Daniel's feedback
  - Dropped EXPORT_SYMBOL that was no longer relevant
  - Reordered patches, so patches with no external
    dependencies comes first
  - Updated the description that follows.

This following series touches a lot of backlight things.

It starts by migrating the last user of of_find_backlight_by_node()
over to devm_of_find_backlight().
*Tomi*/*Peter* review feedback would be great - as this allows a smooth
removal of the export of of_find_backlight_by_node().

Then a small refactoring in backligth.c to remove some indents.
This increases the readability and no functional changes.

Then a new helper backlight_is_blank() is added.
This helper will simplify the implementation of update_status()
in almost all backlight drivers.

Then while surfing the code I missed some documentation.
So I got a bit carried away and updated the documentation
for the backlight core and added it to kernel-doc.
The documentation express my current understanding.
Everything from spelling errors to outright wrong content
shall be anticipated - so please review!
We are all best helped if the documentation is correct
and up-to-date and it is readable.

In this process I identified that the backlight_bl was no
longer is use - so drop it.

All the functions that is no longer used by any drivers
are then marked static to avoid adding new users.
There are dependencies to the omap patch in drivers/video/fbdev/
so these patches needs to wait until that one is applied.

The last patch is for now just an RFC patch that shows
the potential simplifications by introducing the
use of the backlight_is_blank() helper.

I have local patches to introduce backlight_is_blank()
in the remaining backlight drivers.
But they will await that this patch set matures a bit.

Everything builds, but so far no run-time testing.

	Sam

Sam Ravnborg (16):
      video: amba-clcd: use devm_of_find_backlight
      backlight: refactor fb_notifier_callback()
      backlight: add backlight_is_blank()
      backlight: improve backlight_ops documentation
      backlight: improve backlight_properties documentation
      backlight: improve backlight_device documentation
      backlight: document inline functions in backlight.h
      backlight: document enums in backlight.h
      backlight: remove the unused backlight_bl driver
      backlight: drop extern from prototypes
      backlight: add overview and update existing doc
      backlight: wire up kernel-doc documentation
      backlight: make of_find_backlight static
      backlight: drop backlight_put()
      backlight: make of_find_backlight_by_node() static
      backlight: use backlight_is_blank() in all backlight drivers

 Documentation/gpu/backlight.rst          |  12 +
 Documentation/gpu/index.rst              |   1 +
 drivers/video/backlight/88pm860x_bl.c    |   8 +-
 drivers/video/backlight/Kconfig          |   8 -
 drivers/video/backlight/Makefile         |   1 -
 drivers/video/backlight/adp5520_bl.c     |   5 +-
 drivers/video/backlight/adp8860_bl.c     |   5 +-
 drivers/video/backlight/adp8870_bl.c     |   5 +-
 drivers/video/backlight/as3711_bl.c      |   8 +-
 drivers/video/backlight/backlight.c      | 235 +++++++++--------
 drivers/video/backlight/bd6107.c         |   4 +-
 drivers/video/backlight/corgi_lcd.c      |   5 +-
 drivers/video/backlight/cr_bllcd.c       |  22 +-
 drivers/video/backlight/da903x_bl.c      |   8 +-
 drivers/video/backlight/ep93xx_bl.c      |   3 +-
 drivers/video/backlight/generic_bl.c     | 110 --------
 drivers/video/backlight/gpio_backlight.c |   4 +-
 drivers/video/backlight/hp680_bl.c       |   4 +-
 drivers/video/backlight/jornada720_bl.c  |   2 +-
 drivers/video/backlight/kb3886_bl.c      |   4 +-
 drivers/video/backlight/led_bl.c         |   4 +-
 drivers/video/backlight/lm3533_bl.c      |   4 +-
 drivers/video/backlight/locomolcd.c      |   4 +-
 drivers/video/backlight/lv5207lp.c       |   4 +-
 drivers/video/backlight/max8925_bl.c     |   8 +-
 drivers/video/backlight/pwm_bl.c         |   4 +-
 drivers/video/backlight/qcom-wled.c      |   4 +-
 drivers/video/backlight/tps65217_bl.c    |   4 +-
 drivers/video/backlight/wm831x_bl.c      |   8 +-
 drivers/video/fbdev/amba-clcd.c          |  19 +-
 include/linux/backlight.h                | 417 ++++++++++++++++++++++++-------
 31 files changed, 522 insertions(+), 412 deletions(-)
