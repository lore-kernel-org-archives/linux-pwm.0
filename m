From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/4] pwm: pwm-jz4740: Implement set_polarity
Date: Sat, 17 Mar 2018 21:46:04 +0100
Message-ID: <1521319566.2835.0@smtp.crapouillou.net>
References: <20180106165843.3461-1-paul@crapouillou.net>
        <20180106165843.3461-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106165843.3461-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

Could this patchset get a bit of love?
I have other changes waiting for this patchset to get in, so it'd be=20
great
to see it in 4.17-rc1.

Thanks,
-Paul

Le sam. 6 janv. 2018 =E0 17:58, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> This permits clients of this driver to specify the polarity to use for
> their PWM channel.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 2e41ba213f39..6539c001fe32 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -130,10 +130,29 @@ static int jz4740_pwm_config(struct pwm_chip=20
> *chip, struct pwm_device *pwm,
>  	return 0;
>  }
>=20
> +static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
> +		struct pwm_device *pwm, enum pwm_polarity polarity)
> +{
> +	uint32_t ctrl =3D jz4740_timer_get_ctrl(pwm->pwm);
> +
> +	switch (polarity) {
> +	case PWM_POLARITY_NORMAL:
> +		ctrl &=3D ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
> +		break;
> +	case PWM_POLARITY_INVERSED:
> +		ctrl |=3D JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
> +		break;
> +	}
> +
> +	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
> +	return 0;
> +}
> +
>  static const struct pwm_ops jz4740_pwm_ops =3D {
>  	.request =3D jz4740_pwm_request,
>  	.free =3D jz4740_pwm_free,
>  	.config =3D jz4740_pwm_config,
> +	.set_polarity =3D jz4740_pwm_set_polarity,
>  	.enable =3D jz4740_pwm_enable,
>  	.disable =3D jz4740_pwm_disable,
>  	.owner =3D THIS_MODULE,
> --
> 2.11.0
>=20
=
