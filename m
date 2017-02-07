From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ARM: pwm: sun4i: unification of
 register operations for support sun6i.
Date: Wed, 08 Feb 2017 02:45:59 +0800
Message-ID: <20170207214653.kmZWJV6L@smtp1m.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBJNM5DCAKGQEA7FXFKI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

I think the ARM: cap is not needed for the 3 PWM driver patch.

2017=E5=B9=B42=E6=9C=888=E6=97=A5 01:50=E4=BA=8E lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=E5=86=99=
=E9=81=93=EF=BC=9A
>
> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
>
> This patch not introduce new features, just prepare code for=20
> adding sun6i PWM driver in next commits.=20
>
> A31 SoC have a different map of PWM registers than others ASoCs,=20
> but register bits purposes are very similar.=20
>
> This patch introduce set of register access routines, which=20
> are common for existing in driver ASoCs:=20
> - ctl_rdy=C2=A0=C2=A0 - checks the ready bit of specified PWM channel,=20
> - ctl_read=C2=A0 - reads value from control register of specified PWM cha=
nnel,=20
> - ctl_write - writes significant bits to control register of specified PW=
M channel,=20
> - prd_read=C2=A0 - reads value from period register of specified PWM chan=
nel,=20
> - prd_write - writes value to period register of specified PWM channel.=
=20
> Driver code redesigned to use the new routines.=20
>
> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
> ---=20
> drivers/pwm/pwm-sun4i.c | 113 +++++++++++++++++++++++++++++++++++++------=
-----=20
> 1 file changed, 87 insertions(+), 26 deletions(-)=20
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c=20
> index b0803f6..04ad3b4 100644=20
> --- a/drivers/pwm/pwm-sun4i.c=20
> +++ b/drivers/pwm/pwm-sun4i.c=20
> @@ -34,6 +34,7 @@=20
> #define PWM_MODE BIT(7)=20
> #define PWM_PULSE BIT(8)=20
> #define PWM_BYPASS BIT(9)=20
> +#define PWM_CHCTL_MASK GENMASK(9, 0)=20
>
> #define PWM_RDY_BASE 28=20
> #define PWM_RDY_OFFSET 1=20
> @@ -46,6 +47,8 @@=20
>
> #define BIT_CH(bit, chan) ((bit) << ((chan) * PWMCH_OFFSET))=20
>
> +struct sun4i_pwm_chip;=20
> +=20
> static const u32 prescaler_table[] =3D {=20
> 120,=20
> 180,=20
> @@ -65,10 +68,19 @@ static const u32 prescaler_table[] =3D {=20
> 0, /* Actually 1 but tested separately */=20
> };=20
>
> +struct sunxi_reg_ops {=20
> + int (*ctl_rdy)(struct sun4i_pwm_chip *chip, int npwm);=20
> + u32 (*ctl_read)(struct sun4i_pwm_chip *chip, int npwm);=20
> + void (*ctl_write)(struct sun4i_pwm_chip *chip, int npwm, u32 val);=20
> + u32 (*prd_read)(struct sun4i_pwm_chip *chip, int npwm);=20
> + void (*prd_write)(struct sun4i_pwm_chip *chip, int npwm, u32 val);=20
> +};=20
> +=20
> struct sun4i_pwm_data {=20
> bool has_prescaler_bypass;=20
> bool has_rdy;=20
> unsigned int npwm;=20
> + const struct sunxi_reg_ops *ops;=20
> };=20
>
> struct sun4i_pwm_chip {=20
> @@ -96,10 +108,42 @@ static inline void sun4i_pwm_writel(struct sun4i_pwm=
_chip *chip,=20
> writel(val, chip->base + offset);=20
> }=20
>
> +static int sun4i_reg_ctl_rdy(struct sun4i_pwm_chip *chip, int npwm)=20
> +{=20
> + return PWM_RDY(npwm) & sun4i_pwm_readl(chip, PWM_CTRL_REG);=20
> +}=20
> +=20
> +static u32 sun4i_reg_ctl_read(struct sun4i_pwm_chip *chip, int npwm)=20
> +{=20
> + u32 val =3D sun4i_pwm_readl(chip, PWM_CTRL_REG);=20
> +=20
> + return val >> (PWMCH_OFFSET * (npwm));=20
> +}=20
> +=20
> +static void sun4i_reg_ctl_write(struct sun4i_pwm_chip *chip, int npwm, u=
32 val)=20
> +{=20
> + u32 rd =3D sun4i_pwm_readl(chip, PWM_CTRL_REG);=20
> +=20
> + rd &=3D ~(PWM_CHCTL_MASK << (PWMCH_OFFSET * npwm));=20
> + val &=3D (PWM_CHCTL_MASK << (PWMCH_OFFSET * npwm));=20
> + sun4i_pwm_writel(chip, rd | val, PWM_CTRL_REG);=20
> +}=20
> +=20
> +static u32 sun4i_reg_prd_read(struct sun4i_pwm_chip *chip, int npwm)=20
> +{=20
> + return sun4i_pwm_readl(chip, PWM_CH_PRD(npwm));=20
> +}=20
> +=20
> +static void sun4i_reg_prd_write(struct sun4i_pwm_chip *chip, int npwm, u=
32 val)=20
> +{=20
> + sun4i_pwm_writel(chip, val, PWM_CH_PRD(npwm));=20
> +}=20
> +=20
> static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm=
,=20
> =C2=A0=C2=A0=C2=A0 int duty_ns, int period_ns)=20
> {=20
> struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);=20
> + const struct sunxi_reg_ops *reg_ops =3D sun4i_pwm->data->ops;=20
> u32 prd, dty, val, clk_gate;=20
> u64 clk_rate, div =3D 0;=20
> unsigned int prescaler =3D 0;=20
> @@ -152,32 +196,31 @@ static int sun4i_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,=20
> }=20
>
> spin_lock(&sun4i_pwm->ctrl_lock);=20
> - val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);=20
>
> - if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {=20
> + if (sun4i_pwm->data->has_rdy &&=20
> + =C2=A0=C2=A0=C2=A0 reg_ops->ctl_rdy(sun4i_pwm, pwm->hwpwm)) {=20
> spin_unlock(&sun4i_pwm->ctrl_lock);=20
> clk_disable_unprepare(sun4i_pwm->clk);=20
> return -EBUSY;=20
> }=20
>
> - clk_gate =3D val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);=20
> + val =3D reg_ops->ctl_read(sun4i_pwm, pwm->hwpwm);=20
> + clk_gate =3D val & PWM_CLK_GATING;=20
> if (clk_gate) {=20
> - val &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);=20
> - sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);=20
> + val &=3D ~PWM_CLK_GATING;=20
> + reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);=20
> }=20
>
> - val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);=20
> val &=3D ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);=20
> val |=3D BIT_CH(prescaler, pwm->hwpwm);=20
> - sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);=20
> + reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);=20
>
> - val =3D (dty & PWM_DTY_MASK) | PWM_PRD(prd);=20
> - sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));=20
> + reg_ops->prd_write(sun4i_pwm, pwm->hwpwm,=20
> + =C2=A0=C2=A0 (dty & PWM_DTY_MASK) | PWM_PRD(prd));=20
>
> if (clk_gate) {=20
> - val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);=20
> val |=3D clk_gate;=20
> - sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);=20
> + reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);=20
> }=20
>
> spin_unlock(&sun4i_pwm->ctrl_lock);=20
> @@ -190,6 +233,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *ch=
ip, struct pwm_device *pwm,=20
> =C2=A0 enum pwm_polarity polarity)=20
> {=20
> struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);=20
> + const struct sunxi_reg_ops *reg_ops =3D sun4i_pwm->data->ops;=20
> u32 val;=20
> int ret;=20
>
> @@ -200,14 +244,14 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *=
chip, struct pwm_device *pwm,=20
> }=20
>
> spin_lock(&sun4i_pwm->ctrl_lock);=20
> - val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);=20
> + val =3D reg_ops->ctl_read(sun4i_pwm, pwm->hwpwm);=20
>
> if (polarity !=3D PWM_POLARITY_NORMAL)=20
> - val &=3D ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);=20
> + val &=3D ~PWM_ACT_STATE;=20
> else=20
> - val |=3D BIT_CH(PWM_ACT_STATE, pwm->hwpwm);=20
> + val |=3D PWM_ACT_STATE;=20
>
> - sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);=20
> + reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);=20
>
> spin_unlock(&sun4i_pwm->ctrl_lock);=20
> clk_disable_unprepare(sun4i_pwm->clk);=20
> @@ -218,6 +262,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *ch=
ip, struct pwm_device *pwm,=20
> static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm=
)=20
> {=20
> struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);=20
> + const struct sunxi_reg_ops *reg_ops =3D sun4i_pwm->data->ops;=20
> u32 val;=20
> int ret;=20
>
> @@ -228,10 +273,9 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, s=
truct pwm_device *pwm)=20
> }=20
>
> spin_lock(&sun4i_pwm->ctrl_lock);=20
> - val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);=20
> - val |=3D BIT_CH(PWM_EN, pwm->hwpwm);=20
> - val |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);=20
> - sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);=20
> + val =3D reg_ops->ctl_rdy(sun4i_pwm, pwm->hwpwm);=20
> + val |=3D PWM_EN | PWM_CLK_GATING;=20
> + reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);=20
> spin_unlock(&sun4i_pwm->ctrl_lock);=20
>
> return 0;=20
> @@ -240,18 +284,26 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, =
struct pwm_device *pwm)=20
> static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *p=
wm)=20
> {=20
> struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);=20
> + const struct sunxi_reg_ops *reg_ops =3D sun4i_pwm->data->ops;=20
> u32 val;=20
>
> spin_lock(&sun4i_pwm->ctrl_lock);=20
> - val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);=20
> - val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);=20
> - val &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);=20
> - sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);=20
> + val =3D reg_ops->ctl_rdy(sun4i_pwm, pwm->hwpwm);=20
> + val &=3D ~(PWM_EN | PWM_CLK_GATING);=20
> + reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);=20
> spin_unlock(&sun4i_pwm->ctrl_lock);=20
>
> clk_disable_unprepare(sun4i_pwm->clk);=20
> }=20
>
> +static const struct sunxi_reg_ops sun4i_reg_ops =3D {=20
> + .ctl_rdy=C2=A0=C2=A0 =3D sun4i_reg_ctl_rdy,=20
> + .ctl_read=C2=A0 =3D sun4i_reg_ctl_read,=20
> + .ctl_write =3D sun4i_reg_ctl_write,=20
> + .prd_read=C2=A0 =3D sun4i_reg_prd_read,=20
> + .prd_write =3D sun4i_reg_prd_write,=20
> +};=20
> +=20
> static const struct pwm_ops sun4i_pwm_ops =3D {=20
> .config =3D sun4i_pwm_config,=20
> .set_polarity =3D sun4i_pwm_set_polarity,=20
> @@ -264,30 +316,35 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a=
10 =3D {=20
> .has_prescaler_bypass =3D false,=20
> .has_rdy =3D false,=20
> .npwm =3D 2,=20
> + .ops =3D &sun4i_reg_ops,=20
> };=20
>
> static const struct sun4i_pwm_data sun4i_pwm_data_a10s =3D {=20
> .has_prescaler_bypass =3D true,=20
> .has_rdy =3D true,=20
> .npwm =3D 2,=20
> + .ops =3D &sun4i_reg_ops,=20
> };=20
>
> static const struct sun4i_pwm_data sun4i_pwm_data_a13 =3D {=20
> .has_prescaler_bypass =3D true,=20
> .has_rdy =3D true,=20
> .npwm =3D 1,=20
> + .ops =3D &sun4i_reg_ops,=20
> };=20
>
> static const struct sun4i_pwm_data sun4i_pwm_data_a20 =3D {=20
> .has_prescaler_bypass =3D true,=20
> .has_rdy =3D true,=20
> .npwm =3D 2,=20
> + .ops =3D &sun4i_reg_ops,=20
> };=20
>
> static const struct sun4i_pwm_data sun4i_pwm_data_h3 =3D {=20
> .has_prescaler_bypass =3D true,=20
> .has_rdy =3D true,=20
> .npwm =3D 1,=20
> + .ops =3D &sun4i_reg_ops,=20
> };=20
>
> static const struct of_device_id sun4i_pwm_dt_ids[] =3D {=20
> @@ -319,6 +376,7 @@ static int sun4i_pwm_probe(struct platform_device *pd=
ev)=20
> u32 val;=20
> int i, ret;=20
> const struct of_device_id *match;=20
> + const struct sunxi_reg_ops *reg_ops;=20
>
> match =3D of_match_device(sun4i_pwm_dt_ids, &pdev->dev);=20
>
> @@ -360,11 +418,14 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)=20
> goto clk_error;=20
> }=20
>
> - val =3D sun4i_pwm_readl(pwm, PWM_CTRL_REG);=20
> - for (i =3D 0; i < pwm->chip.npwm; i++)=20
> - if (!(val & BIT_CH(PWM_ACT_STATE, i)))=20
> + reg_ops =3D pwm->data->ops;=20
> +=20
> + for (i =3D 0; i < pwm->chip.npwm; i++) {=20
> + val =3D reg_ops->ctl_read(pwm, i);=20
> + if (!(val & PWM_ACT_STATE))=20
> pwm_set_polarity(&pwm->chip.pwms[i],=20
> PWM_POLARITY_INVERSED);=20
> + }=20
> clk_disable_unprepare(pwm->clk);=20
>
> return 0;=20
> --=20
> 2.4.11=20
>
> --=20
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.=20
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org=20
> For more options, visit https://groups.google.com/d/optout.=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
