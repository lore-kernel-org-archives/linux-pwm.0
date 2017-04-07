From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 0/4] pwm: tegra: Pin configuration in suspend/resume and cleanups
Date: Fri, 7 Apr 2017 15:03:58 +0530
Message-ID: <1491557642-15940-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Changes from V2:
- Type fixes, rephrases commit message and use pinctrl_pm_state* return
  value.

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
