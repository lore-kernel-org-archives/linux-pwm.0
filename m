From: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 0/4] pwm support for allwinner sun8i R40/V40/T3 SOCs.
Date: Thu, 11 Jan 2018 19:31:00 +0800
Message-ID: <20180111113100.GA21386@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

This patchset add pwm support for allwinner sun8i R40/V40/T3 SOCs.

Beause of my mistake, previous patch set from v4.
this patch set i resend it from v1 and fix some error.

PATCH LOG:
[v4,1/4] dt-bindings: pwm: binding allwinner sun8i R40/V40/T3.
https://patchwork.kernel.org/patch/10110177/
[v4,2/4] ARM: PWM: add allwinner sun8i R40/V40/T3 pwm support.
https://patchwork.kernel.org/patch/10110185/
[v4,3/4] ARM: dts: add pwm node for r40.
https://patchwork.kernel.org/patch/10110191/

Fixed:
    1.change readl/writel to regmap.
    2.undo the previous polarity, do clk_disable_unprepare()
      and unlock spinlock while error return.

Regards,
Hao Zhang

hao_zhang (4):
  dt-bindings: pwm: binding allwinner sun8i R40/V40/T3.
  ARM: PWM: add allwinner sun8i R40/V40/T3 pwm support.
  ARM: dts: add pwm pins for r40.
  ARM: dts: add pwm node for r40.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  18 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  13 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i-r40.c                        | 394 +++++++++++++++++++++
 6 files changed, 442 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i-r40.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
