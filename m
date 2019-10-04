From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/6] pwm: mxs: implement ->apply
Date: Fri, 4 Oct 2019 16:18:34 +0200
Message-ID: <20191004141834.4blhpjzvkh3hvlqf@pengutronix.de>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
 <20191004133207.6663-2-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191004133207.6663-2-linux@rasmusvillemoes.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Fri, Oct 04, 2019 at 03:32:02PM +0200, Rasmus Villemoes wrote:
> In preparation for supporting setting the polarity, switch the driver
> to support the ->apply method.
> =

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/pwm/pwm-mxs.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> =

> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index b14376b47ac8..10efd3de0bb3 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -26,6 +26,7 @@
>  #define  PERIOD_PERIOD_MAX	0x10000
>  #define  PERIOD_ACTIVE_HIGH	(3 << 16)
>  #define  PERIOD_INACTIVE_LOW	(2 << 18)
> +#define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LO=
W)
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
>  =

> @@ -41,6 +42,74 @@ struct mxs_pwm_chip {
>  =

>  #define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, =
chip)
>  =

> +static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct mxs_pwm_chip *mxs =3D to_mxs_pwm_chip(chip);
> +	int ret, div =3D 0;
> +	unsigned int period_cycles, duty_cycles;
> +	unsigned long rate;
> +	unsigned long long c;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -ENOTSUPP;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the
> +	 * clock before calling clk_get_rate() and writing to the
> +	 * registers. Otherwise, just keep it enabled.
> +	 */
> +	if (!pwm_is_enabled(pwm)) {
> +		ret =3D clk_prepare_enable(mxs->clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!state->enabled && pwm_is_enabled(pwm))
> +		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);

@Thierry: I wonder if it would be beneficial to stop the calculation of
register contents if !state->enabled here. The only drawback (I'm aware)
is that pwm_get_state won't return the previously set .period and
.duty_cycle. (I also wonder if we should return (e.g.) .duty =3D 0,
.period =3D 1 in pwm_get_state() if the PWM is off.)

For the patch (which is orthogonal regarding the above question):

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
