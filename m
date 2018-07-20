From: Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH 0/2] gpio: mvebu: Add support for multiple PWM lines
Date: Sat, 21 Jul 2018 03:23:41 +0800
Message-ID: <1532114623-81911-1-git-send-email-aditya@kobol.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Gauthier Provost <gauthier@kobol.io>, Alban Browaeys <alban.browaeys@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Aditya Prayoga <aditya@kobol.io>
List-Id: linux-pwm@vger.kernel.org

Hi everyone,

Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
mvebu does not allow more than one PWM on the same bank.

Aditya

---

Aditya Prayoga (2):
  gpio: mvebu: Add support for multiple PWM lines per GPIO chip
  gpio: mvebu: Allow to use non-default PWM counter

 drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 19 deletions(-)

-- 
2.7.4
