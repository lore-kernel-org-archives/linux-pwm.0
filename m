From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/5] Add rk3328 pwm support
Date: Thu, 29 Jun 2017 20:27:46 +0800
Message-ID: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

There are two features of rk3328 pwm module.
 - PWM APB and function clocks are different.
 - Add pwm atomic hardware update

David Wu (5):
  pwm: rockchip: Add APB and function both clocks support
  pwm: rockchip: Remove the judge from return value of pwm_config
  pwm: rockchip: Move the configuration of polarity from pwm_enable() to
    pwm_config()
  pwm: rockchip: Add atomic updated feature for rk3328
  Arm64: dts: rockchip: Add pwm nodes for rk3328

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   9 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 +++++
 drivers/pwm/pwm-rockchip.c                         | 184 ++++++++++++++++-----
 3 files changed, 197 insertions(+), 41 deletions(-)

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
