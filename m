From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 0/20] backlight: backlight updates
Date: Fri,  3 Jul 2020 20:45:26 +0200
Message-ID: <20200703184546.144664-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgGCSqA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:00 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>

Long overdue follow-up. v3 submission here:
https://lore.kernel.org/dri-devel/20200601065207.492614-1-sam@ravnborg.org/

v4:
  - Introduced backlight_get_brightness based on feedback from Emil.
  - Properly described the rationale behind more restrictive locking use
    I checked that locking was not used outside backlight core
    by renaming the lock fields.
    As it is not used seems OK to restrict use to the core.
  - Introducing backlight_get_brightness invalidated
    some patches and I did a bit finer split to ease review.
  - Added acks
  - A few small adjustments documented in the individual patches

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

Sam Ravnborg (20):
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
      backlight: introduce backlight_get_brightness()
      backlight: as3711_bl: simplify update_status
      backlight: cr_bllcd: introduce backlight_is_blank()
      backlight: gpio_backlight: simplify update_status()
      backlight: jornada720_bl: introduce backlight_is_blank()
      backlight: use backligt_get_brightness()
      backlight: drop backlight_put()
      backlight: make of_find_backlight static
      backlight: make of_find_backlight_by_node() static

 Documentation/gpu/backlight.rst          |  12 +
 Documentation/gpu/index.rst              |   1 +
 drivers/video/backlight/88pm860x_bl.c    |  13 +-
 drivers/video/backlight/Kconfig          |   8 -
 drivers/video/backlight/Makefile         |   1 -
 drivers/video/backlight/adp5520_bl.c     |  10 +-
 drivers/video/backlight/adp8860_bl.c     |  10 +-
 drivers/video/backlight/adp8870_bl.c     |  10 +-
 drivers/video/backlight/as3711_bl.c      |  11 +-
 drivers/video/backlight/backlight.c      | 234 ++++++++++--------
 drivers/video/backlight/bd6107.c         |   7 +-
 drivers/video/backlight/corgi_lcd.c      |   8 +-
 drivers/video/backlight/cr_bllcd.c       |  14 +-
 drivers/video/backlight/da903x_bl.c      |  13 +-
 drivers/video/backlight/ep93xx_bl.c      |   8 +-
 drivers/video/backlight/generic_bl.c     | 110 ---------
 drivers/video/backlight/gpio_backlight.c |  17 +-
 drivers/video/backlight/hp680_bl.c       |   6 +-
 drivers/video/backlight/jornada720_bl.c  |   2 +-
 drivers/video/backlight/kb3886_bl.c      |   6 +-
 drivers/video/backlight/led_bl.c         |   7 +-
 drivers/video/backlight/lm3533_bl.c      |   8 +-
 drivers/video/backlight/locomolcd.c      |   6 +-
 drivers/video/backlight/lv5207lp.c       |   7 +-
 drivers/video/backlight/max8925_bl.c     |  13 +-
 drivers/video/backlight/pwm_bl.c         |   7 +-
 drivers/video/backlight/qcom-wled.c      |   7 +-
 drivers/video/backlight/tps65217_bl.c    |  10 +-
 drivers/video/backlight/wm831x_bl.c      |  13 +-
 include/linux/backlight.h                | 409 ++++++++++++++++++++++++-------
 30 files changed, 503 insertions(+), 485 deletions(-)
