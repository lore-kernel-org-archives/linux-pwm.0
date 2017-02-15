From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 0/4] Add the Allwinner A31/A31s PWM driver
Date: Wed, 15 Feb 2017 23:06:03 +0300
Message-ID: <1487189167-32486-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBMXJSLCQKGQEI7B67SY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Main goal is to add support of the sun6i PWM variant.

This is the third version of the sun6i PWM patchset.
Difference between v2 and v3:
 - regmap API used for access to PWM registers.

Thanks to Maxime Ripard for pointing me to the regmap API.

Siarhei Volkau (4):
  pwm: sunxi: Code switched to regmap API instead of iomem.
  pwm: sunxi: Selectable prescaler table for support sun6i.
  pwm: sunxi: Add support the Allwinner A31 PWM.
  ARM: dts: sun6i: Add the PWM block to the A31/A31s.

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |   3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   8 +
 drivers/pwm/Kconfig                                |   2 +-
 drivers/pwm/pwm-sun4i.c                            | 359 ++++++++++++++++-----
 4 files changed, 294 insertions(+), 78 deletions(-)

--
2.4.11
