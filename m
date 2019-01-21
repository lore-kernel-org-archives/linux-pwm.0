From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/4] add support for the new SAM9X60's PWM controller
Date: Mon, 21 Jan 2019 12:30:45 +0000
Message-ID: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
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

Claudiu Beznea (4):
  pwm: atmel: add struct atmel_pwm_data
  pwm: atmel: add support for controllers with 32 bit counters
  pwm: atmel: add support for SAM9X60's PWM controller
  pwm: atmel: add PWM binding for SAM9X60

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 119 ++++++++++++++---=
----
 2 files changed, 81 insertions(+), 39 deletions(-)

--=20
2.7.4
