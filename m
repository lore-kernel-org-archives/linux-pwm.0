From: Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH v2 0/1] gpio: mvebu: Add support for multiple PWM lines
Date: Wed, 12 Sep 2018 12:51:54 +0800
Message-ID: <1536727915-113932-1-git-send-email-aditya@kobol.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Richard Genoud <richard.genoud@gmail.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Gauthier Provost <gauthier@kobol.io>, Dennis Gilmore <dennis@ausil.us>, Aditya Prayoga <aditya@kobol.io>
List-Id: linux-pwm@vger.kernel.org


Hi everyone,

Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
The PWM pins on both connector are connected to GPIO on bank 1. Current
gpio-mvebu does not allow more than one PWM on the same bank.

Aditya

---

Changes v1->v2:
  * Merge/squash "[Patch 2/2] gpio: mvebu: Allow to use non-default PWM counter"
  * Allow only two PWMs as suggested by Andrew Lunn and Richard Genoud

---

Aditya Prayoga (1):
  gpio: mvebu: Add support for multiple PWM lines per GPIO chip

 drivers/gpio/gpio-mvebu.c | 73 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 13 deletions(-)

-- 
2.7.4
