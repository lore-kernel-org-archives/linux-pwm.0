From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 2/6] pwm: let pwm_get_state() return the last
 implemented state
Date: Fri, 30 Aug 2019 19:48:35 +0200
Message-ID: <5802279.ETANMDGNFP@phil>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
 <20190824153707.13746-3-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190824153707.13746-3-uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Patrick Havelange <patrick.havelange-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Am Samstag, 24. August 2019, 17:37:03 CEST schrieb Uwe Kleine-K=F6nig:
> When pwm_apply_state() is called the lowlevel driver usually has to
> apply some rounding because the hardware doesn't support nanosecond
> resolution. So let pwm_get_state() return the actually implemented state
> instead of the last applied one if possible.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>

With this applied, the display brightness on my rk3399-gru-scarlet gets
inverted. Now it's very bright on level 1 and very dim on the max level.

According to the debugfs, the inverted state changes:

OLD STATE:
----------
root@localhost:~# cat /debug/pwm
platform/ff420030.pwm, 1 PWM device
 pwm-0   (ppvar-bigcpu-pwm    ): requested enabled period: 3334 ns duty: 33=
1 ns polarity: normal

platform/ff420020.pwm, 1 PWM device
 pwm-0   (ppvar-litcpu-pwm    ): requested enabled period: 3334 ns duty: 41=
4 ns polarity: normal

platform/ff420010.pwm, 1 PWM device
 pwm-0   (backlight           ): requested enabled period: 999996 ns duty: =
941148 ns polarity: normal

platform/ff420000.pwm, 1 PWM device
 pwm-0   (ppvar-gpu-pwm       ): requested enabled period: 3334 ns duty: 33=
34 ns polarity: normal

NEW STATE:
----------
root@localhost:~# cat /debug/pwm =

platform/ff420030.pwm, 1 PWM device
 pwm-0   (ppvar-bigcpu-pwm    ): requested enabled period: 3334 ns duty: 33=
1 ns polarity: normal

platform/ff420020.pwm, 1 PWM device
 pwm-0   (ppvar-litcpu-pwm    ): requested enabled period: 3334 ns duty: 41=
4 ns polarity: normal

platform/ff420010.pwm, 1 PWM device
 pwm-0   (backlight           ): requested enabled period: 999996 ns duty: =
941148 ns polarity: inverse

platform/ff420000.pwm, 1 PWM device
 pwm-0   (ppvar-gpu-pwm       ): requested enabled period: 3334 ns duty: 33=
34 ns polarity: normal


And the reason is below.

> ---
>  drivers/pwm/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 72347ca4a647..92333b89bf02 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -473,7 +473,14 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
>  		if (err)
>  			return err;
>  =

> -		pwm->state =3D *state;
> +		/*
> +		 * .apply might have to round some values in *state, if possible
> +		 * read the actually implemented value back.
> +		 */
> +		if (chip->ops->get_state)
> +			chip->ops->get_state(chip, pwm, &pwm->state);
> +		else
> +			pwm->state =3D *state;

This should probably become
>-		pwm->state =3D *state;
> +
> +		/*
> +		 * .apply might have to round some values in *state, if possible
> +		 * read the actually implemented value back.
> +		 */
> +		if (chip->ops->get_state)
> +			chip->ops->get_state(chip, pwm, &pwm->state);

so always initialize the state to the provided one and then let the driver
override values?

The inversion case stems from the Rockchip pwm driver (wrongly?) only
setting the polarity field when actually inverted, so here the polarity fie=
ld
probably never actually got set at all.

But while we should probably fix the rockchip driver to set polarity all the
time, this is still being true for possible future state-fields, which also
wouldn't get initialzed from all drivers, which might need an adaption
first?


Heiko


>  	} else {
>  		/*
>  		 * FIXME: restore the initial state in case of error.
> =
