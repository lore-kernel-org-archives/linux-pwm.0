From: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] pwm support for allwinner sun8i SOCs.
Date: Sun, 25 Feb 2018 21:49:46 +0800
Message-ID: <20180225134946.GA14015@arx-s1>
Reply-To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDKITZOARQMBBBH6ZLKAKGQEWVI3FFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

PWM support for allwinner sun8i SOCs.

This patchset adds pwm support for allwinner sun8i SOCs.


v2 Changes:
1. change sun8i-r40 symbol to sun8i.
2. change pwm0_pin, pwm0-pin to pwm_ch0_pin, pwm-ch0-pin.
3. remove clk_disable_unprepare(), check !match and IS_ERR(pwm->regmap).




hao_zhang (4):
  dt-bindings: pwm: binding allwinner sun8i.
  ARM: dtsi: add pwm node for sun8i.
  ARM: dts: add pwm status for r40.
  ARM: PWM: add allwinner sun8i pwm support.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  18 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  13 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i.c                            | 401 +++++++++++++++++++++
 6 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i.c

-- 
2.7.4
