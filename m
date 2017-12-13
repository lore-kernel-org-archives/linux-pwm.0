From: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/4] pwm support for allwinner sun8i R40/V40/T3 SOCs.
Date: Wed, 13 Dec 2017 22:38:40 +0800
Message-ID: <20171213143840.GA17754@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

This patchset add pwm support for allwinner sun8i R40/V40/T3 SOCs.

all has been teat on T3 board.

Some features
	8 PWM channels outputs(4 PWM pairs) 
	Supports capturing input 
	Supports three kinds of output waveforms: continuous waveform, pulse
	waveform and complementarity pair 
	Programmable deadzone generator and controllable dead-time 
	0% to 100% adjustable duty cycle 
	Up to 24/100MHz output frequency 
	Minimum resolution is 1/65536 
	Supports interrupt for PWM output and capturing input


DOC:
https://github.com/tinalinux/docs/blob/r40-v1.y/Allwinner_R40_User_Manual_V1.0.pdf
https://github.com/tinalinux/docs/blob/r40-v1.y/R40_Datasheet_V1.0.pdf

Regards;-)
Hao Zhang

hao_zhang (4):
  dt-bindings: pwm: binding allwinner R40, V40, T3
  ARM: PWM: add allwinner sun8i R40/V40/T3 pwm support.
  ARM: dts: add pwm node for r40.
  ARM: pinctrl: sunxi-pinctrl: fix pin funtion can not be match
    correctly.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  18 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  13 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   6 +-
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i-r40.c                        | 449 +++++++++++++++++++++
 7 files changed, 501 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i-r40.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
