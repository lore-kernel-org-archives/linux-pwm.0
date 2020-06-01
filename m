From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 0/16] backlight updates
Date: Mon,  1 Jun 2020 08:51:54 +0200
Message-ID: <20200601065207.492614-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>
List-Id: linux-pwm@vger.kernel.org

v3:
 - Dropped video patch that was reviewd and thus applied
 - Updated kernel-doc so all fields now have a short intro
 - Improved readability in a lot of places, thanks to review
   feedback from Daniel - thanks!
 - Added better intro to backlight
 - Added acks

   Several other smaller changes documented in the
   patches.
   I left out patches to make functions static as
   there are dependencies to drm-misc-next for these.
   When this is landed I have a pile of follow-up patches waiting,
   mostly introducing backlight_is_blank() all over.

v2:
  - Dropped drm patches that was reviewed and thus applied (Thanks Tomi)
  - Updated backligth_is_blank() based on Daniel's feedback
  - Dropped EXPORT_SYMBOL that was no longer relevant
  - Reordered patches, so patches with no external
    dependencies comes first
  - Updated the description that follows.

This following series touches a lot of backlight things.

Starts with a small refactoring in backligth.c to remove some indents.
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

In this process I identified that the backlight_bl driver
was no longer in use - so drop it.

Everything builds, but so far no run-time testing.

	Sam

Sam Ravnborg (13):
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
      backlight: as3711_bl: introduce backlight_is_blank()
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
 drivers/video/backlight/backlight.c      | 174 +++++++++-----
 drivers/video/backlight/bd6107.c         |   4 +-
 drivers/video/backlight/corgi_lcd.c      |   5 +-
 drivers/video/backlight/cr_bllcd.c       |  22 +-
 drivers/video/backlight/da903x_bl.c      |   8 +-
 drivers/video/backlight/ep93xx_bl.c      |   3 +-
 drivers/video/backlight/generic_bl.c     | 110 ---------
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
 include/linux/backlight.h                | 374 +++++++++++++++++++++++++------
 30 files changed, 465 insertions(+), 346 deletions(-)
