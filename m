From: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH RESEND 0/4] mediatek: pwm driver add MT2712/MT7622 support
Date: Wed, 21 Jun 2017 16:11:08 +0800
Message-ID: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, zhenbao.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

pwm driver add MT2712/MT7622 support, fix clock control issue.
dtsi file will be upload latter, after the clock define is ready.

Zhi Mao (4):
  pwm: kconfig: modify mediatek information
  pwm: mediatek: fix clk issue
  pwm: bindings: add MT2712/MT7622 information
  pwm: mediatek: add MT2712/MT7622 support

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
 drivers/pwm/Kconfig                                |    2 +-
 drivers/pwm/pwm-mediatek.c                         |  132 ++++++++++++++------
 3 files changed, 100 insertions(+), 40 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
