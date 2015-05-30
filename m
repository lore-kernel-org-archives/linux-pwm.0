From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH v8 4/5] pwm: kona: Add debug info to config function
Date: Sat, 30 May 2015 09:42:38 -0700
Message-ID: <CAD7vxx+vaghG+Vc+wKYbGV69cj=XF9Wj+r18BNj=_gW9oyGGag@mail.gmail.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
	<1432670900-27687-5-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36675 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbbE3Qmj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 30 May 2015 12:42:39 -0400
In-Reply-To: <1432670900-27687-5-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM <linux-pwm@vger.kernel.org>

On Tue, May 26, 2015 at 1:08 PM, Jonathan Richardson
<jonathar@broadcom.com> wrote:
> Adds debugging info to config function where duty cycle and period
> are calculated and verified.
>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c |   25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index c87621f..0ddf19b 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -138,18 +138,39 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                 dc = div64_u64(val, div);
>
>                 /* If duty_ns or period_ns are not achievable then return */
> -               if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)

The original code was based on the SPEAr PWM driver which has a non-zero
PWMDCR_MIN_DUTY such that the second condition here can evaluate to true.

This isn't the case for the Kona PWM where DUTY_CYCLE_HIGH_MIN is zero.

> +               if (pc < PERIOD_COUNT_MIN) {
> +                       dev_warn(chip->dev,
> +                               "%s: pwm[%d]: period=%d is not achievable, pc=%lu, prescale=%lu\n",
> +                               __func__, chan, period_ns, pc, prescale);
>                         return -EINVAL;
> +               }

Why not just print the minimum allowable period with the provided clock?

I don't think pc and prescale will be particularly helpful to users.

Also, do we really need to print __func__ here?

> +
> +               if (dc < DUTY_CYCLE_HIGH_MIN) {
> +                       if (0 != duty_ns) {
> +                               dev_warn(chip->dev,
> +                                       "%s: pwm[%d]: duty cycle=%d is not achievable, dc=%lu, prescale=%lu\n",
> +                                       __func__, chan, duty_ns, dc, prescale);
> +                       }
> +                       return -EINVAL;
> +               }

The above block is unreachable code.

>
>                 /* If pc and dc are in bounds, the calculation is done */
>                 if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
>                         break;
>
>                 /* Otherwise, increase prescale and recalculate pc and dc */
> -               if (++prescale > PRESCALE_MAX)
> +               if (++prescale > PRESCALE_MAX) {
> +                       dev_warn(chip->dev,
> +                               "%s: pwm[%d]: Prescale (=%lu) within max (=%d) for period=%d and duty cycle=%d is not achievable\n",
> +                               __func__, chan, prescale, PRESCALE_MAX,
> +                               period_ns, duty_ns);
>                         return -EINVAL;
> +               }
>         }

The user got here because they specified a period larger than the maximum
supported so why not tell them largest value that can be supported instead
of confusing them with prescale and PRESCALE_MAX?

>
> +       dev_dbg(chip->dev, "pwm[%d]: period=%lu, duty_high=%lu, prescale=%lu\n",
> +               chan, pc, dc, prescale);
> +

This could be more clear.  It prints pc but calls it period.

>         /*
>          * Don't apply settings if disabled. The period and duty cycle are
>          * always calculated above to ensure the new values are
> --
> 1.7.9.5
>
