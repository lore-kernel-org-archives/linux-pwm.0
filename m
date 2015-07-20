From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Date: Mon, 20 Jul 2015 09:16:48 +0200
Message-ID: <20150720091648.625a3dbd@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40077 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753669AbbGTHQw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 03:16:52 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>

Hi Thierry,

I'd like to send a new version of this series fixing the problems
reported by Heiko, but I remember you were not happy with the naming
convention I have chosen for the atomic update function.
Could you have a quick look at this series (I'm not asking for a
detailed review) and let me know which things you'd like me to rename.

Best Regards,

Boris

On Wed,  1 Jul 2015 10:21:46 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello Thierry,
> 
> This series adds support for atomic PWM update, or ITO, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
> 
> This implementation is still experimental, and I may have missed some key
> aspect, so any feedback are welcome.
> 
> Also note that I haven't protected the state update with any locking.
> That's because the existing config does not protect against concurrent
> access to a requested PWM device (see the pwm_config implementation).
> I guess the PWM framework assume the user will implement the proper locking
> scheme if it has to concurrently access the device.
> 
> The 5 first patches prepare the addition of the pwm_state concept, which
> will be used to allow atomic updates.
> The following patches introduce the pwm_state struct, initial state
> retrieval and atomic update concepts.
> 
> Patches 12 and 13 are showing how one can implement the initial state
> retrieval and atomic update features in a PWM driver (in this specific
> case I implemented it in the rockchip driver).
> 
> The last 2 patches are making use of those changes to improve the
> pwm-regulator driver (initializing the regulator state based on the
> initial PWM state).
> 
> Best Regards,
> 
> Boris
> 
> Boris Brezillon (15):
>   pwm: add the pwm_is_enabled() helper
>   pwm: fix pwm_get_period and pwm_get_duty_cycle prototypes
>   pwm: add pwm_get_polarity helper function
>   pwm: make use of pwm_get_xxx helpers where appropriate
>   pwm: introduce default period and polarity concepts
>   pwm: define a new pwm_state struct
>   pwm: move the enabled/disabled info to pwm_state struct
>   backlight: pwm_bl: remove useless call to pwm_set_period
>   pwm: declare a default PWM state
>   pwm: add the PWM initial state retrieval infra
>   pwm: add the core infrastructure to allow atomic update
>   pwm: rockchip: add initial state retrieval
>   pwm: rockchip: add support for atomic update
>   regulator: pwm: implement ->enable(), ->disable() and ->is_enabled
>     methods
>   regulator: pwm: properly initialize the ->state field
> 
>  drivers/leds/leds-pwm.c              |   2 +-
>  drivers/pwm/core.c                   | 136 ++++++++++++++++++++++++++++++-----
>  drivers/pwm/pwm-atmel-tcb.c          |   2 +-
>  drivers/pwm/pwm-atmel.c              |   6 +-
>  drivers/pwm/pwm-bcm-kona.c           |   7 +-
>  drivers/pwm/pwm-ep93xx.c             |   4 +-
>  drivers/pwm/pwm-imx.c                |   5 +-
>  drivers/pwm/pwm-mxs.c                |   4 +-
>  drivers/pwm/pwm-pxa.c                |   2 +-
>  drivers/pwm/pwm-renesas-tpu.c        |   2 +-
>  drivers/pwm/pwm-rockchip.c           | 122 ++++++++++++++++++++++++-------
>  drivers/pwm/pwm-sun4i.c              |   3 +-
>  drivers/pwm/pwm-tegra.c              |   6 +-
>  drivers/pwm/pwm-tiecap.c             |  10 +--
>  drivers/pwm/pwm-tiehrpwm.c           |   6 +-
>  drivers/pwm/sysfs.c                  |  13 ++--
>  drivers/regulator/pwm-regulator.c    |  60 ++++++++++++++--
>  drivers/video/backlight/lm3630a_bl.c |   4 +-
>  drivers/video/backlight/pwm_bl.c     |   6 +-
>  drivers/video/fbdev/ssd1307fb.c      |   2 +-
>  include/linux/pwm.h                  |  82 ++++++++++++++++++---
>  21 files changed, 380 insertions(+), 104 deletions(-)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
