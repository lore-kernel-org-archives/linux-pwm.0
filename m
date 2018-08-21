From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH 0/2] pwm: imx: Configure output to GPIO in disabled state
Date: Tue, 21 Aug 2018 16:38:51 +0200
Message-ID: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@karo-electronics.de>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
List-Id: linux-pwm@vger.kernel.org

This is an attempt to deal with i.MX SoC PWM HW limitation.
When a pad is configured as a PWM output the output level is always 0V
if the PWM block is disabled. This can cause problems when inverted PWM
signal is needed to drive the connected circuit. With inverted output
duty cycle = 0% corresponds to high output level and duty cycle = 100%
corresponds to low output level. This means that whenever the PWM block is
disabled the connected circuit is fed with 100% duty cycle.

This issue has been discussed in various threads about inverted PWM support
implementation. Finally this commit 326ed314fefe ("pwm: imx: Add polarity
inversion support to i.MX's PWMv2") from Lukasz was merged.

Later on Fabio came up with the same problem as I described.
His commit 1f6eefeb7cd4 ("pwm: imx: Let PWM be active during suspend")
solves the problem only in suspend state and not whenever PWM is disabled.

In the discussion Fabio also suggested a pinctrl solution though it was
still only for suspend [1].

I would like to bring attention to that pinctrl solution once again.
The code is basically a copy of the I2C recovery function [2].

The binding is totally optional and current users are not affected.
The idea is to use the "default" pinctrl state to set the pin to a safe
state. That is a GPIO function with pull-up. Then when a PWM signal is
needed on the output, select the "pwm" state.

Using the GPIO function as a default state assures that the pad is in
a safe state all the time from power-up and is switched to PWM only when
it is really needed.

It is also important to first change the muxing and then disable the PWM.
Otherwise you will get unwanted level changes on the output. And vice
versa when PWM output needs to be enabled. Enable PWM first, then change
the muxing.

I would like to know your opinion on this, thanks.

Michal

[1] https://patchwork.ozlabs.org/patch/839834/#1819865
[2] https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-imx.c#L989


Michal Vokáč (2):
  dt-bindings: pwm: imx: Allow switching PWM output between PWM and GPIO
  pmw: imx: Configure output to GPIO in disabled state

 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 ++++++++++++++++++
 drivers/pwm/pwm-imx.c                             | 56 +++++++++++++++++++++++
 2 files changed, 100 insertions(+)

-- 
2.1.4
