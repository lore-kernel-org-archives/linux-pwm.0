From: Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH RESEND 0/2] gpio: mvebu: Add support for multiple PWM lines
Date: Mon,  6 Aug 2018 10:29:14 +0800
Message-ID: <1533522556-55055-1-git-send-email-aditya@kobol.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Richard Genoud <richard.genoud@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Gauthier Provost <gauthier@kobol.io>, Alban Browaeys <alban.browaeys@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Aditya Prayoga <aditya@kobol.io>
List-Id: linux-pwm@vger.kernel.org

Hi everyone,

Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
mvebu does not allow more than one PWM on the same bank.

Resend the patch to add more reviewer.

Aditya

---

Aditya Prayoga (2):
  gpio: mvebu: Add support for multiple PWM lines per GPIO chip
  gpio: mvebu: Allow to use non-default PWM counter

 drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 19 deletions(-)

-- 
2.7.4
