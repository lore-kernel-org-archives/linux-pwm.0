From: Alexandru Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/3] PWM backlight interpolation adjustments
Date: Mon, 20 Jul 2020 21:25:19 -0700
Message-ID: <20200721042522.2403410-1-amstan@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Alexandru Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

I was trying to adjust the brightness for a new chromebook:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2291209
Like a lot of panels, the low end needs to be cropped,
and now that we have the interpolation stuff I wanted to make use of it
and bake in even the curve.

I found the behavior a little unintuitive and non-linear. See patch 1
for a suggested fix for this.

Unfortunatelly a few veyron dts files were relying on this
(perhaps weird) behavior. Those devices also want a minimum brightness.
The issue is that they also want the 0% point for turning off the
display.
https://github.com/torvalds/linux/commit/6233269bce47bd450196a671ab28eb1ec5eb88d9#diff-e401ae20091bbfb311a062c464f4f47fL23

So the idea here is to change those dts files to only say <3 255> (patch
3), and add in a virtual 0% point at the bottom of the scale (patch 2).

We have to do this conditionally because it seems some devices like to
have the scale inverted:
  % git grep "brightness-levels\s*=\s*<\s*[1-9]"|cat
  arch/arm/boot/dts/tegra124-apalis-eval.dts:             brightness-levels = <255 231 223 207 191 159 127 0>;


Alexandru Stan (3):
  backlight: pwm_bl: Fix interpolation
  backlight: pwm_bl: Artificially add 0% during interpolation
  ARM: dts: rockchip: Remove 0 point in backlight

 arch/arm/boot/dts/rk3288-veyron-jaq.dts    |  2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts |  2 +-
 arch/arm/boot/dts/rk3288-veyron-tiger.dts  |  2 +-
 drivers/video/backlight/pwm_bl.c           | 78 +++++++++++-----------
 4 files changed, 42 insertions(+), 42 deletions(-)

-- 
2.27.0
