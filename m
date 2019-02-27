From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/7] add LCD support for SAM9X60
Date: Wed, 27 Feb 2019 16:24:11 +0000
Message-ID: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

These patches adds support for SAM9X60's LCD controller.

First patches add option to specify if controller clock source is fixed.
Second patch avoid a variable initialization in atmel_hlcdc_crtc_mode_set_n=
ofb().
The 3rd one adds specific bindings for SAM9X60 LCD controller.
The 4th and 5th add compatibles in the driver.
The 6th patch enables sys_clk in probe since SAM9X60 needs this.
Specific support was added also in suspend/resume hooks.
The work in the 6th patch was done based on support added in 1st patch.
The 7th patch adds SAM9X60's LCD configuration and enabled it.=20

I kept a big series including PWM, MFD, LCD changes due to shared DT
bindings. If you prefer, I'm available to send them separately. Please let
me know.

Thank you,
Claudiu Beznea

Claudiu Beznea (5):
  drm: atmel-hlcdc: add config option for clock selection
  drm: atmel-hlcdc: avoid initializing cfg with zero
  dt-bindings: mfd: add bindings for SAM9X60 HLCD controller
  mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD controller
  pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM

Sandeep Sheriker Mallikarjun (2):
  drm: atmel-hlcdc: enable sys_clk during initalization.
  drm: atmel-hlcdc: add sam9x60 LCD controller

 .../devicetree/bindings/mfd/atmel-hlcdc.txt        |   1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  17 ++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 120 +++++++++++++++++=
+++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +
 drivers/mfd/atmel-hlcdc.c                          |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      |   3 +
 6 files changed, 134 insertions(+), 10 deletions(-)

--=20
2.7.4
