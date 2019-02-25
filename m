From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 0/5] add support for the new SAM9X60's PWM controller
Date: Mon, 25 Feb 2019 16:44:30 +0000
Message-ID: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series adds support for PWM controller of the new SAM9X60. The differe=
nce
b/w this one and the provious AT91SAM9X5 is the counter size (32 bits compa=
red
with 16 bits on the previous version) thus, allowing to generate signals wi=
th
bigger periods and duty cycles. This series, modifies the driver to take in=
to
account per IP counter size by embedding this information into driver's dat=
a.

Changes in v3:
- collect Acked-by tags
- introduced patch 3/5 which changes the name of objects of type
  atmel_pwm_data
- changed a bit commit message for patches 1/5 and 2/5
- use mchp_sam9x60_pwm_data instead of atmel_pwm_data_v3 for SAM9X60
  compatible data

Changes in v2:
- add reviewed-by tag to DT inding patch
- move PWM_MAXV2_PRD from patch 2/4 in patch 3/4
- change commit description for patch 3/4

Claudiu Beznea (5):
  pwm: atmel: add struct atmel_pwm_data
  pwm: atmel: add support for controllers with 32 bit counters
  pwm: atmel: rename objects of type atmel_pwm_data
  pwm: atmel: add support for SAM9X60's PWM controller
  pwm: atmel: add PWM binding for SAM9X60

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 117 ++++++++++++++---=
----
 2 files changed, 79 insertions(+), 39 deletions(-)

--=20
2.7.4
