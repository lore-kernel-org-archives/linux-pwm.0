From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 00/13] regulator: pwm: various improvements
Date: Thu, 09 Jun 2016 20:04:20 +0200
Message-ID: <2819222.JTKrccvLNL@diego>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36532 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbcFISEj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 9 Jun 2016 14:04:39 -0400
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>

Hi Boris,

Am Mittwoch, 8. Juni 2016, 18:34:35 schrieb Boris Brezillon:
> This patch series series aims at adding two important features to the
> pwm-regulator driver.
> 
> The first one is the support for 'smooth handover' between the
> bootloader and the kernel. This is mainly solving problems we have when
> the PWM is controlling a critical regulator (like the one powering the
> DDR chip). Currently, when the PWM regulator acquire the PWM device it
> assumes it was off and it's safe to change the configuration before
> enabling it, which can generate glitches on the PWM signal which in turn
> generated glitches on the output voltage.
> To solve that we've introduced support for hardware readout to the
> PWM framework, so that the PWM regulator driver can adjust the PWM
> a probe time and avoid glitches.
> Atomic update is also helping in this regard.

[...]

> The second feature we add to the driver is the capability of using
> a sub duty_cycle range in continuous mode. By default the regulator
> is assuming that min_uV is achieved with a 0% dutycyle and max_uV
> with a 100% dutycycle, but this is not necessarily true.
> Moreover, in some cases (when the PWM device does not support
> polarity inversion), we might have min_uV at 100% and max_uV at 0%.
> Hence the addition of new properties to the existing DT bindings.
> The feature is added in patch 12 and 13.

I've tested this series on a rk3288-veyron chromebook and both the backlight-
pwm as well as the pwm-regulator still work as expected, so for everything 
except the STI parts:

Tested-by: Heiko Stuebner <heiko@sntech.de>
