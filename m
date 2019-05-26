From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 10/14] pwm: meson: simplify the calculation of the
 pre-divider and count
Date: Sun, 26 May 2019 21:41:20 +0200
Message-ID: <20190526194120.uzuq6ncz5l2z4hfm@pengutronix.de>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-11-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190525181133.4875-11-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Sat, May 25, 2019 at 08:11:29PM +0200, Martin Blumenstingl wrote:
> Replace the loop to calculate the pre-divider and count with two
> separate div64_u64() calculations. This makes the code easier to read
> and improves the precision.
> =

> Two example cases:
> 1) 32.768kHz LPO clock for the SDIO wifi chip on Khadas VIM
>    clock input: 500MHz (FCLK_DIV4)
>    period: 30518ns
>    duty cycle: 15259ns
> old algorithm: pre_div=3D0, cnt=3D15259
> new algorithm: pre_div=3D0, cnt=3D15259
> (no difference in calculated values)
> =

> 2) PWM LED on Khadas VIM
>    clock input: 24MHz (XTAL)
>    period: 7812500ns
>    duty cycle: 7812500ns
> old algorithm: pre_div=3D2, cnt=3D62004
> new algorithm: pre_div=3D2, cnt=3D62500
> Using a scope (24MHz sampling rate) shows the actual difference:
> - old: 7753000ns, off by -59500ns (0.7616%)
> - new: 7815000ns, off by +2500ns (0.032%)
> =

> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> =

> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 27915d6475e3..9afa1e5aaebf 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -12,6 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -145,7 +146,6 @@ static int meson_pwm_calc(struct meson_pwm *meson, st=
ruct pwm_device *pwm,
>  	struct meson_pwm_channel *channel =3D pwm_get_chip_data(pwm);
>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>  	unsigned long fin_freq =3D -1;
> -	u64 fin_ps;
>  =

>  	duty =3D state->duty_cycle;
>  	period =3D state->period;
> @@ -164,24 +164,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, =
struct pwm_device *pwm,
>  	}
>  =

>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
> -	fin_ps =3D (u64)NSEC_PER_SEC * 1000;
> -	do_div(fin_ps, fin_freq);
> -
> -	/* Calc pre_div with the period */
> -	for (pre_div =3D 0; pre_div <=3D MISC_CLK_DIV_MASK; pre_div++) {
> -		cnt =3D DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
> -					    fin_ps * (pre_div + 1));
> -		dev_dbg(meson->chip.dev, "fin_ps=3D%llu pre_div=3D%u cnt=3D%u\n",
> -			fin_ps, pre_div, cnt);
> -		if (cnt <=3D 0xffff)
> -			break;
> -	}
>  =

> +	pre_div =3D div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>  	if (pre_div > MISC_CLK_DIV_MASK) {
>  		dev_err(meson->chip.dev, "unable to get period pre_div\n");
>  		return -EINVAL;
>  	}
>  =

> +	cnt =3D div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
> +	if (cnt > 0xffff) {
> +		dev_err(meson->chip.dev, "unable to get period cnt\n");
> +		return -EINVAL;
> +	}
> +

There is a slight modification in the calculation of pre_div that isn't
catched by the examples above.

Before this patch we had:

	pick smallest pre_div such that
		round_closest(period * 1000 / (round_down(1e12 / fin_freq) * (pre_div + 1=
)) <=3D 0xffff

New approach is:

	pre_div =3D round_down(fin_freq * period / (1e9 * 0xffff))

An advantage of the new approach is better as it rounds only once and is
easier.

Consider fin_freq =3D 99990001 and period =3D 655355, then the old algorithm
picks pre_div =3D 1 while the new picks pre_div =3D 0.

I didn't continue here to check which are the resulting waveforms, I
assume they are different though.

As there is currently no definition what is a "better" approximation for
a given requested pair (duty_cycle, period) I cannot say if these
changes are good or not.

And that's a pity, so I still think there should be a documented
definition that lays down how a lowlevel driver should round. Without
that a consumer that cares about fine differences can not rely an the
abstraction provided by the PWM framework because each low-level driver
might behave differently.

@Thierry: So can you please continue the discussion about this topic.
The longer this is delayed the more patches are created and submitted
that eventually might be wrong which is a waste of developer and
reviewer time.

Assuming the people who care about meson don't object after reading this
I wouldn't want to stop this patch going in though. So:

	Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
