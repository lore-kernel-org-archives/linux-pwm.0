From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 0/4] pwm: add support for ChromeOS EC PWM
Date: Thu,  2 Jun 2016 18:21:40 -0700
Message-ID: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo <enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Nematbakhsh <shawnn-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

This is version 2 of my series to support the new ChromeOS EC PWM API, so we
can control, e.g., a PWM backlight when its PWM is attached to the EC. It uses
Boris's latest "atomic" hooks for the PWM API (i.e., the ->apply() callback),
which were recently merged.

It seems nice to have the cros_ec_cmd_xfer_status() helper, which we have
locally in the ChromeOS kernel, and which has been part of another larger patch
series:

https://lkml.org/lkml/2016/4/12/342

So I've picked it into this series as well. Tomeu has acknowledged his USB PD
series is on hold for now, so this should be OK.

As this touches MFD (sort of), drivers/platform/chrome/, and drivers/pwm/, I'm
still not sure who it should all go through: Lee, Thierry, or Olof?

Please review.

Regards,
Brian

Change log (also documented in each patch):

v2:
 * drop the "google,max-pwms" property
 * separate the cros_ec vs. PWM abstractions a little more clearly in the driver
 * remove dynamic kzalloc()'s and rely on on-stack memory instead
 * auto-probe the number of PWMs supported

Brian Norris (3):
  mfd: cros_ec: add EC_PWM function definitions
  doc: dt: pwm: add binding for ChromeOS EC PWM
  pwm: add ChromeOS EC PWM driver

Tomeu Vizoso (1):
  mfd: cros_ec: Add cros_ec_cmd_xfer_status helper

 .../devicetree/bindings/pwm/google,cros-ec-pwm.txt |  23 ++
 drivers/platform/chrome/cros_ec_proto.c            |  15 ++
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-cros-ec.c                          | 237 +++++++++++++++++++++
 include/linux/mfd/cros_ec.h                        |  18 ++
 include/linux/mfd/cros_ec_commands.h               |  31 +++
 7 files changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
 create mode 100644 drivers/pwm/pwm-cros-ec.c

-- 
2.8.0.rc3.226.g39d4020

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
