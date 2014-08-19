From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v3 2/4] pwm: rockchip: Allow polarity invert on rk3288
Date: Wed, 20 Aug 2014 06:15:13 +0800
Message-ID: <53F3CC71.8090005@rock-chips.com>
References: <1408464476-28316-1-git-send-email-dianders@chromium.org> <1408464476-28316-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:35116 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbaHSWPR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Aug 2014 18:15:17 -0400
In-Reply-To: <1408464476-28316-3-git-send-email-dianders@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Sonny Rao <sonnyrao@chromium.org>, olof@lixom.net, Eddie Cai <eddie.cai@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Doug,

I reviewed it, the change is need.

Reviewed-on: https://github.com/rkchrome/kernel.git
Reviewed-by: Caesar Wang <caesar.wang@rock-chips.com>

=D4=DA 2014=C4=EA08=D4=C220=C8=D5 00:07, Doug Anderson =D0=B4=B5=C0:
> The rk3288 has the ability to invert the polarity of the PWM.  Let's
> enable that ability.
>
> To do this we increase the number of pwm_cells to 3 to allow using th=
e
> PWM_POLARITY_INVERTED flag.  Since the PWM driver on rk3288 is very
> new, I thought this was OK.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v3:
> - Don't store a private copy of polarity.
> - Use true instead of 1.
> - Cleanup init order with "has_invert".
>
> Changes in v2: None
>
>   .../devicetree/bindings/pwm/pwm-rockchip.txt       |  4 +-
>   drivers/pwm/pwm-rockchip.c                         | 48 +++++++++++=
+++++++----
>   2 files changed, 43 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b=
/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> index d47d15a..b8be3d0 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> @@ -7,8 +7,8 @@ Required properties:
>      "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
>    - reg: physical base address and length of the controller's regist=
ers
>    - clocks: phandle and clock specifier of the PWM reference clock
> - - #pwm-cells: should be 2. See pwm.txt in this directory for a
> -   description of the cell format.
> + - #pwm-cells: must be 2 (rk2928) or 3 (rk3288). See pwm.txt in this=
 directory
> +   for a description of the cell format.
>  =20
>   Example:
>  =20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index bdd8644..646aed2 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -24,7 +24,9 @@
>   #define PWM_ENABLE		(1 << 0)
>   #define PWM_CONTINUOUS		(1 << 1)
>   #define PWM_DUTY_POSITIVE	(1 << 3)
> +#define PWM_DUTY_NEGATIVE	(0 << 3)
>   #define PWM_INACTIVE_NEGATIVE	(0 << 4)
> +#define PWM_INACTIVE_POSITIVE	(1 << 4)
>   #define PWM_OUTPUT_LEFT		(0 << 5)
>   #define PWM_LP_DISABLE		(0 << 8)
>  =20
> @@ -45,8 +47,10 @@ struct rockchip_pwm_regs {
>   struct rockchip_pwm_data {
>   	struct rockchip_pwm_regs regs;
>   	unsigned int prescaler;
> +	bool has_invert;
>  =20
> -	void (*set_enable)(struct pwm_chip *chip, bool enable);
> +	void (*set_enable)(struct pwm_chip *chip,
> +			   struct pwm_device *pwm, bool enable);
>   };
>  =20
>   static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct=
 pwm_chip *c)
> @@ -54,7 +58,8 @@ static inline struct rockchip_pwm_chip *to_rockchip=
_pwm_chip(struct pwm_chip *c)
>   	return container_of(c, struct rockchip_pwm_chip, chip);
>   }
>  =20
> -static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip, bool e=
nable)
> +static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
> +				       struct pwm_device *pwm, bool enable)
>   {
>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>   	u32 enable_conf =3D PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
> @@ -70,14 +75,19 @@ static void rockchip_pwm_set_enable_v1(struct pwm=
_chip *chip, bool enable)
>   	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>   }
>  =20
> -static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip, bool e=
nable)
> +static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
> +				       struct pwm_device *pwm, bool enable)
>   {
>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>   	u32 enable_conf =3D PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE =
|
> -			  PWM_CONTINUOUS | PWM_DUTY_POSITIVE |
> -			  PWM_INACTIVE_NEGATIVE;
> +			  PWM_CONTINUOUS;
>   	u32 val;
>  =20
> +	if (pwm->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		enable_conf |=3D PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> +	else
> +		enable_conf |=3D PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
> +
>   	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>  =20
>   	if (enable)
> @@ -124,6 +134,23 @@ static int rockchip_pwm_config(struct pwm_chip *=
chip, struct pwm_device *pwm,
>   	return 0;
>   }
>  =20
> +int rockchip_pwm_set_polarity(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +			      enum pwm_polarity polarity)
> +{
> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
> +
> +	if (!pc->data->has_invert)
> +		return -ENOSYS;
> +
> +	/*
> +	 * No action needed here because pwm->polarity will be set by the c=
ore
> +	 * and the core will only change polarity when the PWM is not enabl=
ed.
> +	 * We'll handle things in set_enable().
> +	 */
> +
> +	return 0;
> +}
> +
>   static int rockchip_pwm_enable(struct pwm_chip *chip, struct pwm_de=
vice *pwm)
>   {
>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
> @@ -133,7 +160,7 @@ static int rockchip_pwm_enable(struct pwm_chip *c=
hip, struct pwm_device *pwm)
>   	if (ret)
>   		return ret;
>  =20
> -	pc->data->set_enable(chip, true);
> +	pc->data->set_enable(chip, pwm, true);
>  =20
>   	return 0;
>   }
> @@ -142,13 +169,14 @@ static void rockchip_pwm_disable(struct pwm_chi=
p *chip, struct pwm_device *pwm)
>   {
>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>  =20
> -	pc->data->set_enable(chip, false);
> +	pc->data->set_enable(chip, pwm, false);
>  =20
>   	clk_disable(pc->clk);
>   }
>  =20
>   static const struct pwm_ops rockchip_pwm_ops =3D {
>   	.config =3D rockchip_pwm_config,
> +	.set_polarity =3D rockchip_pwm_set_polarity,
>   	.enable =3D rockchip_pwm_enable,
>   	.disable =3D rockchip_pwm_disable,
>   	.owner =3D THIS_MODULE,
> @@ -173,6 +201,7 @@ static const struct rockchip_pwm_data pwm_data_v2=
 =3D {
>   		.ctrl =3D 0x0c,
>   	},
>   	.prescaler =3D 1,
> +	.has_invert =3D true,
>   	.set_enable =3D rockchip_pwm_set_enable_v2,
>   };
>  =20
> @@ -184,6 +213,7 @@ static const struct rockchip_pwm_data pwm_data_vo=
p =3D {
>   		.ctrl =3D 0x00,
>   	},
>   	.prescaler =3D 1,
> +	.has_invert =3D true,
>   	.set_enable =3D rockchip_pwm_set_enable_v2,
>   };
>  =20
> @@ -230,6 +260,10 @@ static int rockchip_pwm_probe(struct platform_de=
vice *pdev)
>   	pc->chip.ops =3D &rockchip_pwm_ops;
>   	pc->chip.base =3D -1;
>   	pc->chip.npwm =3D 1;
> +	if (pc->data->has_invert) {
> +		pc->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +		pc->chip.of_pwm_n_cells =3D 3;
> +	}
>  =20
>   	ret =3D pwmchip_add(&pc->chip);
>   	if (ret < 0) {

--=20
Best regards,
Caesar


