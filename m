Return-Path: <mikedunn@newsguy.com>
From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH RESEND v5 0/2] PWM: PXA: add device tree support to PWM driver
Date: Sat, 21 Sep 2013 12:19:32 -0700
Message-Id: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Mike Dunn <mikedunn@newsguy.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

Dang! Sorry, please disregard previous patch set.
RESENDing because previous set did not include the file
Documentation/devicetree/bindings/pwm/pxa-pwm.txt

This is now a patch set because the changes to pxa27x.dtsi have been moved to a
separate patch.  This was done so that it can go through the arm-soc tree.

Changle log:
v5:
- changes to pxa27x.dtsi moved to a separate patch
- minor changes in phrasing made to bindings documentation
- cast removed from void *
- dummy functions for !CONFIG_OF removed; called only if (IS_ENABLED(CONFIG_OF)
- if-else block in pxa_pwm_get_id_dt() replaced with ternary operator

v4:
- add second "compatible" string to pxa27x.dtsi
- change phrasing in binding doc pxa-pwm.txt to "one or more of"

v3:
- remove support for the polarity flag
- remove per-chip pwm index cell; define custom of_xlate()
   (now #pwm-cells = <1>)
- "compatible" strings for all devices added to OF match table
- various stylistic changes recommended by reviewers

v2:
- of_match_table contains only the "pxa250-pwm" compatible string; require one
  device instance per pwm
- add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
- add support for polarity flag in DT and implement set_polarity() method
  (the treo 680 inverts the signal between pwm out and backlight)
- return -EINVAL instead of -ENODEV if platform data or DT node not found
- output dev_info string if platform data missing
- expanded CC list of patch


Mike Dunn (2):
  PWM: PXA: add device tree support to PWM driver
  PXA: add PWM nodes to pxa27x.dtsi

 Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
 arch/arm/boot/dts/pxa27x.dtsi                     | 24 +++++++++++
 drivers/pwm/pwm-pxa.c                             | 52 ++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt

-- 
1.8.1.5
