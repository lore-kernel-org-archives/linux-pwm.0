From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Tue, 21 Jun 2016 16:42:04 +0200
Message-ID: <CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33959 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcFUOm2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jun 2016 10:42:28 -0400
In-Reply-To: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Brian,

On Fri, May 27, 2016 at 6:45 PM, Brian Norris <briannorris@chromium.org> wrote:
> It seems like in the process of refactoring pwm_config() to utilize the
> newly-introduced pwm_apply_state() API, some args/bounds checking was
> dropped.
>
> In particular, I noted that we are now allowing invalid period
> selections. e.g.:
>
>   # echo 1 > /sys/class/pwm/pwmchip0/export
>   # cat /sys/class/pwm/pwmchip0/pwm1/period
>   100
>   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>   [... driver may or may not reject the value, or trigger some logic bug ...]
>
> It's better to see:
>
>   # echo 1 > /sys/class/pwm/pwmchip0/export
>   # cat /sys/class/pwm/pwmchip0/pwm1/period
>   100
>   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>   -bash: echo: write error: Invalid argument
>
> This patch reintroduces some bounds checks in both pwm_config() (for its
> signed parameters; we don't want to convert negative values into large
> unsigned values) and in pwm_apply_state() (which fix the above described
> behavior, as well as other potential API misuses).
>
> Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
>  * changed subject, as this covers more scope now
>  * add Fixes tag, as this is a v4.7-rc regression
>  * add more bounds/args checks in pwm_apply_state() and pwm_config()
>
>  drivers/pwm/core.c  | 3 ++-
>  include/linux/pwm.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index dba3843c53b8..ed337a8c34ab 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -457,7 +457,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  {
>         int err;
>
> -       if (!pwm)
> +       if (!pwm || !state || !state->period ||
> +           state->duty_cycle > state->period)
>                 return -EINVAL;

This check breaks the LCD backlight on r8a7740/armadillo.
Apparently both period and duty_cycle are zero during the first invocation.
Later, these are initialized from DT, cfr.

        pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;

in arch/arm/boot/dts/r8a7740-armadillo800eva.dts.

With added debug printing, the difference between failure and success is:

 renesas-tpu-pwm e6600000.pwm: TPU PWM -1 registered
 tpu_pwm_request:223
 pwm_apply_state:460: pwm backlight/2: period 0, duty_cycle 0
+Ignoring failure
+pwm_apply_state:479: polarity 0 -> 1
+tpu_pwm_set_polarity:343
+pwm_apply_state:502: period 0 -> 0
+pwm_apply_state:503: duty_cycle 0 -> 0
+pwm_apply_state:516: enabled 0 -> 0
 pwm_config:238: pwm backlight/2: duty_ns 33333, period_ns 33333
 pwm_apply_state:460: pwm backlight/2: period 33333, duty_cycle 33333
-pwm_apply_state:479: polarity 0 -> 0
+pwm_apply_state:479: polarity 1 -> 1
 pwm_apply_state:502: period 0 -> 33333
 pwm_apply_state:503: duty_cycle 0 -> 33333
 tpu_pwm_config:267
 pwm_apply_state:516: enabled 0 -> 0
 pwm_apply_state:460: pwm backlight/2: period 33333, duty_cycle 33333
-pwm_apply_state:479: polarity 0 -> 0
+pwm_apply_state:479: polarity 1 -> 1
 pwm_apply_state:502: period 33333 -> 33333
 pwm_apply_state:503: duty_cycle 33333 -> 33333
 pwm_apply_state:516: enabled 0 -> 1
 tpu_pwm_enable:354

Sorry for not noticing last week, before it hit mainline.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
