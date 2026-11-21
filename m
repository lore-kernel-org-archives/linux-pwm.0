Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795267929;
	b=cWhE/nalPSgRAYUx5UrTnZoibMrtSGtkwQkwAgAEj0yQTrJeW7/R60DGrax9qS7J3SNO
	 Aq/rRiHjA79AFyAyX1t9tgX9wHtiNEO3lUr/yUwxuCnc85AeAdqUasorXe7nPdbh2meUh
	 6UgIDytbktTzJ/KThvHpbqBvXNIwZ8tIdJKemzW5XSc7ym8qLlZnkV2tLNcfpBghlZZfv
	 VniUK7HiqjbQsp4CUWWI3xP61PvhGx3mBkw3YOmHQ7xCfFnxkX3dggwI7whRs0Dm2+zz+
	 +7E/jYqrcY/+GNr1ykZ9FmHHBcMxXO9LigtgCRdTnMbdY+lcYigGoDcud8J6+zSfoLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795267929;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=On77mFW6X0dla9fTTn/ye//ONpA/8ovfBsxR4/ar/t4=;
	b=SPG2VjnDQXgJtyfWLo8XeJwisz0iaKRBGFoXy1yRCnSNdFkJZbCCdK2FGOxhwY77HCgS
	 G9vQJv6GJczP13G++MWIhLgSix9jDxQjvh1+DEe2CRYZGOZ/zX7jLvenje/5gSrGe5p9h
	 sndqwUuYOHC9JNT+IW3VWZFJJGcIU3DHu1K9valamviiTR7pw3qPQtlDMlOXRMPOaFszU
	 wb+mjdgzx2KCdc6FnRnHTITlt4WfQ+/EWBnAWiKbKaVr0c5dT/yK+V68Ec0muMDGgBB51
	 Db6wWB+EZMf7MgxuEst/8Z46e4JQdOsyd8If4r9s7nymP/Xlg6xkKSFtoF30j4UCHkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=EUHc0Zw4;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1C606A32A;
	Sat, 21 Nov 2026 13:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A1C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=EUHc0Zw4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=On77mFW6X0dla9fTTn/ye//ONpA/8ovfBsxR4/ar/t4=; b=EUHc0Zw43qyAHoow9nLSYnMNku
	nIsHpuRMHhRcOWdAjWWdn5zXkKiz2s0/XLjWqj+imuH4EXunbC4W2JmK+ttiY9aP0ipgkDUjDbNbq
	bFyYyHz2CdA9attGCmkp1VT0Q1ciLO+vECPwgm7qt0l8deL1l+2bApg2LBRmKyObynHmLqkvW3HWH
	HGtytnGZmTVlHepQqdBW5+WBl0+mHBtJJL4E7qIMdBZZY3YsucAYjjW2VU7ZaoHYPT2NYwBU0baKQ
	ekhoO6DQY0OvtOH23V5DrK4AHqsrB32Eg8e0QYbSFYQl1EdeFgs/KoL4I+hR1O9J65lXH67qJU5/k
	PINYiehg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 ZhuXiangyu <1194781887@qq.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ZhuXiangyu <1194781887@qq.com>
Subject: Re: [PATCH 1/2] pwm: rockchip: add PWM v4 support
Date: Sat, 21 Nov 2026 14:32:04 +0100
Message-ID: <jocuz3u0Ta6QRkgSoouIaQ@sntech.de>
In-Reply-To: <tencent_27C5A1EA3CF33BA5221F7F01A066E92BCC07@qq.com>
References: <tencent_27C5A1EA3CF33BA5221F7F01A066E92BCC07@qq.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 21. November 2026, 07:59:35 Mitteleurop=C3=A4ische Normalzeit s=
chrieb ZhuXiangyu:
> Add basic support for the Rockchip PWM v4 controller found on the
> RK3506 and RK3576 SoCs. Compared to the earlier versions, v4 moves the
> enable bits into a separate register, uses hiword write masks for the
> control fields and latches a new configuration with a control-update
> bit.
>=20
> Only continuous output mode is supported for now.
>=20
> Tested on an RK3506 board with a 100 kHz output at 40% duty cycle,
> including enable/disable, verified on an oscilloscope.
>=20
> Tested-by: ZhuXiangyu <1194781887@qq.com>
> Signed-off-by: ZhuXiangyu <1194781887@qq.com>

please check mailing lists, before submitting duplicate work.
There is already a better (yet unfinished implementation pending,
that also incorporates the counter input).

All the process issues, Krzysztof pointed out in another thread still
apply too.


Heiko


> ---
>  drivers/pwm/pwm-rockchip.c | 146 +++++++++++++++++++++++++++++++++----
>  1 file changed, 130 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 050ca8aa..aa89f23d 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/limits.h>
>  #include <linux/math64.h>
> @@ -31,6 +32,27 @@
>  #define PWM_LOCK_EN		(1 << 6)
>  #define PWM_LP_DISABLE		(0 << 8)
> =20
> +/*
> + * Register layout for PWM v4
> + */
> +#define PWM_V4_HIWORD_UPDATE(v, l, h) \
> +	((((v) << (l)) & GENMASK((h), (l))) | (GENMASK((h), (l)) << 16))
> +
> +#define PWM_V4_ENABLE_MASK		GENMASK(1, 0)
> +#define PWM_V4_CLK_EN(v)		PWM_V4_HIWORD_UPDATE(v, 0, 0)
> +#define PWM_V4_EN(v)			PWM_V4_HIWORD_UPDATE(v, 1, 1)
> +#define PWM_V4_CTRL_UPDATE_EN(v)	PWM_V4_HIWORD_UPDATE(v, 2, 2)
> +
> +#define PWM_V4_MODE(v)			PWM_V4_HIWORD_UPDATE(v, 0, 1)
> +#define PWM_V4_CONTINUOUS		1
> +#define PWM_V4_POLARITY(v)		PWM_V4_HIWORD_UPDATE(v, 2, 3)
> +#define PWM_V4_DUTY_NEGATIVE		(0 << 0)
> +#define PWM_V4_DUTY_POSITIVE		BIT(0)
> +#define PWM_V4_INACTIVE_NEGATIVE	(0 << 1)
> +#define PWM_V4_INACTIVE_POSITIVE	BIT(1)
> +#define PWM_V4_CTRL_DUTY_POSITIVE	BIT(2)
> +#define PWM_V4_ALIGNED_INVALID(v)	PWM_V4_HIWORD_UPDATE(v, 5, 5)
> +
>  struct rockchip_pwm_chip {
>  	struct clk *clk;
>  	struct clk *pclk;
> @@ -43,6 +65,7 @@ struct rockchip_pwm_regs {
>  	unsigned long period;
>  	unsigned long cntr;
>  	unsigned long ctrl;
> +	unsigned long enable;
>  };
> =20
>  struct rockchip_pwm_data {
> @@ -88,13 +111,25 @@ static int rockchip_pwm_get_state(struct pwm_chip *c=
hip,
>  	tmp *=3D prescaled_ns;
>  	state->duty_cycle =3D  DIV_U64_ROUND_UP(tmp, clk_rate);
> =20
> -	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> -	state->enabled =3D (val & enable_conf) =3D=3D enable_conf;
> +	if (pc->data->regs.enable) {
> +		val =3D readl_relaxed(pc->base + pc->data->regs.enable);
> +		state->enabled =3D (val & enable_conf) =3D=3D enable_conf;
> =20
> -	if (pc->data->supports_polarity && !(val & PWM_DUTY_POSITIVE))
> -		state->polarity =3D PWM_POLARITY_INVERSED;
> -	else
> -		state->polarity =3D PWM_POLARITY_NORMAL;
> +		val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> +		if (pc->data->supports_polarity &&
> +		    !(val & PWM_V4_CTRL_DUTY_POSITIVE))
> +			state->polarity =3D PWM_POLARITY_INVERSED;
> +		else
> +			state->polarity =3D PWM_POLARITY_NORMAL;
> +	} else {
> +		val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> +		state->enabled =3D (val & enable_conf) =3D=3D enable_conf;
> +
> +		if (pc->data->supports_polarity && !(val & PWM_DUTY_POSITIVE))
> +			state->polarity =3D PWM_POLARITY_INVERSED;
> +		else
> +			state->polarity =3D PWM_POLARITY_NORMAL;
> +	}
> =20
>  	clk_disable(pc->clk);
>  	clk_disable(pc->pclk);
> @@ -102,6 +137,47 @@ static int rockchip_pwm_get_state(struct pwm_chip *c=
hip,
>  	return 0;
>  }
> =20
> +static void rockchip_pwm_config_v4(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   const struct pwm_state *state)
> +{
> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
> +	u64 prescaled_ns =3D (u64)pc->data->prescaler * NSEC_PER_SEC;
> +	u64 clk_rate, tmp;
> +	u32 period_ticks, duty_ticks;
> +
> +	clk_rate =3D clk_get_rate(pc->clk);
> +
> +	tmp =3D mul_u64_u64_div_u64(clk_rate, state->period, prescaled_ns);
> +	if (tmp > U32_MAX)
> +		tmp =3D U32_MAX;
> +	period_ticks =3D tmp;
> +
> +	tmp =3D mul_u64_u64_div_u64(clk_rate, state->duty_cycle, prescaled_ns);
> +	if (tmp > U32_MAX)
> +		tmp =3D U32_MAX;
> +	duty_ticks =3D tmp;
> +
> +	writel_relaxed(period_ticks, pc->base + pc->data->regs.period);
> +	writel_relaxed(duty_ticks, pc->base + pc->data->regs.duty);
> +
> +	if (pc->data->supports_polarity) {
> +		if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +			writel_relaxed(PWM_V4_POLARITY(PWM_V4_DUTY_NEGATIVE |
> +						       PWM_V4_INACTIVE_POSITIVE),
> +				       pc->base + pc->data->regs.ctrl);
> +		else
> +			writel_relaxed(PWM_V4_POLARITY(PWM_V4_DUTY_POSITIVE |
> +						       PWM_V4_INACTIVE_NEGATIVE),
> +				       pc->base + pc->data->regs.ctrl);
> +	}
> +
> +	writel_relaxed(PWM_V4_MODE(PWM_V4_CONTINUOUS) |
> +		       PWM_V4_ALIGNED_INVALID(false),
> +		       pc->base + pc->data->regs.ctrl);
> +	writel_relaxed(PWM_V4_CTRL_UPDATE_EN(true),
> +		       pc->base + pc->data->regs.enable);
> +}
> +
>  static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device=
 *pwm,
>  			       const struct pwm_state *state)
>  {
> @@ -175,14 +251,31 @@ static int rockchip_pwm_enable(struct pwm_chip *chi=
p,
>  			return ret;
>  	}
> =20
> -	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> -
> -	if (enable)
> -		val |=3D enable_conf;
> -	else
> -		val &=3D ~enable_conf;
> +	if (pc->data->regs.enable) {
> +		writel_relaxed(PWM_V4_EN(enable) | PWM_V4_CLK_EN(enable),
> +			       pc->base + pc->data->regs.enable);
> +
> +		if (!enable) {
> +			struct pwm_state curstate;
> +
> +			/*
> +			 * In continuous mode the disable takes effect at the end
> +			 * of the current period, so keep the clock running for
> +			 * one more period.
> +			 */
> +			pwm_get_state(pwm, &curstate);
> +			fsleep(DIV_ROUND_UP_ULL(curstate.period, NSEC_PER_USEC));
> +		}
> +	} else {
> +		val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> +
> +		if (enable)
> +			val |=3D enable_conf;
> +		else
> +			val &=3D ~enable_conf;
> =20
> -	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> +		writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> +	}
> =20
>  	if (!enable)
>  		clk_disable(pc->clk);
> @@ -217,7 +310,10 @@ static int rockchip_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  		enabled =3D false;
>  	}
> =20
> -	rockchip_pwm_config(chip, pwm, state);
> +	if (pc->data->regs.enable)
> +		rockchip_pwm_config_v4(chip, pwm, state);
> +	else
> +		rockchip_pwm_config(chip, pwm, state);
>  	if (state->enabled !=3D enabled) {
>  		ret =3D rockchip_pwm_enable(chip, pwm, state->enabled);
>  		if (ret)
> @@ -291,11 +387,26 @@ static const struct rockchip_pwm_data pwm_data_v3 =
=3D {
>  		       PWM_CONTINUOUS,
>  };
> =20
> +static const struct rockchip_pwm_data pwm_data_v4 =3D {
> +	.regs =3D {
> +		.duty =3D 0x14,
> +		.period =3D 0x10,
> +		.ctrl =3D 0xc,
> +		.enable =3D 0x4,
> +	},
> +	.prescaler =3D 1,
> +	.supports_polarity =3D true,
> +	.supports_lock =3D true,
> +	.enable_conf =3D PWM_V4_ENABLE_MASK,
> +};
> +
>  static const struct of_device_id rockchip_pwm_dt_ids[] =3D {
>  	{ .compatible =3D "rockchip,rk2928-pwm", .data =3D &pwm_data_v1 },
>  	{ .compatible =3D "rockchip,rk3288-pwm", .data =3D &pwm_data_v2 },
>  	{ .compatible =3D "rockchip,vop-pwm", .data =3D &pwm_data_vop },
>  	{ .compatible =3D "rockchip,rk3328-pwm", .data =3D &pwm_data_v3 },
> +	{ .compatible =3D "rockchip,rk3506-pwm", .data =3D &pwm_data_v4 },
> +	{ .compatible =3D "rockchip,rk3576-pwm", .data =3D &pwm_data_v4 },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
> @@ -327,7 +438,7 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)
> =20
>  	count =3D of_count_phandle_with_args(pdev->dev.of_node,
>  					   "clocks", "#clock-cells");
> -	if (count =3D=3D 2)
> +	if (count >=3D 2)
>  		pc->pclk =3D devm_clk_get(&pdev->dev, "pclk");
>  	else
>  		pc->pclk =3D pc->clk;
> @@ -351,7 +462,10 @@ static int rockchip_pwm_probe(struct platform_device=
 *pdev)
>  	chip->ops =3D &rockchip_pwm_ops;
> =20
>  	enable_conf =3D pc->data->enable_conf;
> -	ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> +	if (pc->data->regs.enable)
> +		ctrl =3D readl_relaxed(pc->base + pc->data->regs.enable);
> +	else
> +		ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>  	enabled =3D (ctrl & enable_conf) =3D=3D enable_conf;
> =20
>  	ret =3D pwmchip_add(chip);
>=20




