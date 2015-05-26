From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] PWM: atmel: fix incorrect CDTY value after enabling
Date: Tue, 26 May 2015 11:01:33 +0200
Message-ID: <5564366D.9090707@atmel.com>
References: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Le 25/05/2015 15:19, Alexandre Belloni a =E9crit :
> CUPD is not flushed before enabling the channel so it will update CDTY/CP=
RD just
> after one period. So we always set CUPD, even when the channel is not ena=
bled.
> =

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

BTW, is a "stable tag" needed for this one?

> ---
>  drivers/pwm/pwm-atmel.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> =

> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index d3c22de9ee47..89f9ca41d9af 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -155,24 +155,25 @@ static void atmel_pwm_config_v1(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
>  	unsigned int val;
>  =

> -	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> -		/*
> -		 * If the PWM channel is enabled, using the update register,
> -		 * it needs to set bit 10 of CMR to 0
> -		 */
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
>  =

> -		val =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> -		val &=3D ~PWM_CMR_UPD_CDTY;
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> -	} else {
> -		/*
> -		 * If the PWM channel is disabled, write value to duty and
> -		 * period registers directly.
> -		 */
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
> -	}
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
> +
> +	val =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> +	val &=3D ~PWM_CMR_UPD_CDTY;
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> +
> +	/*
> +	 * If the PWM channel is enabled, only update CDTY by using the update
> +	 * register, it needs to set bit 10 of CMR to 0
> +	 */
> +	if (test_bit(PWMF_ENABLED, &pwm->flags))
> +		return;
> +	/*
> +	 * If the PWM channel is disabled, write value to duty and period
> +	 * registers directly.
> +	 */
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
>  }
>  =

>  static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> =



-- =

Nicolas Ferre
