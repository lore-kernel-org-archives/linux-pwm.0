From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 0/4] pwm: tegra: Pin configuration in suspend/resume and cleanups
Date: Thu, 6 Apr 2017 19:50:57 +0530
Message-ID: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This patch series have following fixes:
- Add more precession in PWM period register value calculation
  for lower pwm frequency.
- Add support to configure PWM pins in different state in the
  suspend/resume.

Changes from v1:
- Use standard pinctrl names for sleep and active state.
- Use API pinctrl_pm_select_*()

Laxman Dewangan (4):
  pwm: tegra: Use DIV_ROUND_CLOSEST_ULL() instead of local
    implementation
  pwm: tegra: Increase precision in pwm rate calculation
  pwm: tegra: Add DT binding details to configure pin in suspends/resume
  pwm: tegra: Add support to configure pin state in suspends/resume

 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 43 ++++++++++++
 drivers/pwm/pwm-tegra.c                            | 77 ++++++++++++++++++++--
 2 files changed, 116 insertions(+), 4 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
