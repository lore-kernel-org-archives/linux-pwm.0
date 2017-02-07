From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: pwm: sun6i: add support the
 Allwinner A31 PWM.
Date: Wed, 08 Feb 2017 02:46:44 +0800
Message-ID: <20170207214708.l3Z87RZb@smtp1m.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBM5M5DCAKGQE2ADKXIA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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


As the driver is named pwm-sun4i, I think here you shold use "pwm: sun4i:".

2017=E5=B9=B42=E6=9C=888=E6=97=A5 01:50=E4=BA=8E lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=E5=86=99=
=E9=81=93=EF=BC=9A
>
> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
>
> This patch introduce the sun6i PWM driver itself:=20
> - sun6i register operations,=20
> - sun6i prescaler table,=20
> - DT bindings for A31 SoC,=20
> - documentation update.=20
>
> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
> ---=20
> .../devicetree/bindings/pwm/pwm-sun4i.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-=20
> drivers/pwm/pwm-sun4i.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 71 ++++++++++++++++++++++=20
> 2 files changed, 73 insertions(+), 1 deletion(-)=20
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-sun4i.txt=20
> index f1cbeef..b737934 100644=20
> --- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt=20
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt=20
> @@ -1,10 +1,11 @@=20
> -Allwinner sun4i and sun7i SoC PWM controller=20
> +Allwinner sun4i, sun6i and sun7i SoC PWM controller=20
>
> Required properties:=20
> =C2=A0=C2=A0 - compatible: should be one of:=20
> =C2=A0=C2=A0=C2=A0=C2=A0 - "allwinner,sun4i-a10-pwm"=20
> =C2=A0=C2=A0=C2=A0=C2=A0 - "allwinner,sun5i-a10s-pwm"=20
> =C2=A0=C2=A0=C2=A0=C2=A0 - "allwinner,sun5i-a13-pwm"=20
> +=C2=A0=C2=A0=C2=A0 - "allwinner,sun6i-a31-pwm"=20
> =C2=A0=C2=A0=C2=A0=C2=A0 - "allwinner,sun7i-a20-pwm"=20
> =C2=A0=C2=A0=C2=A0=C2=A0 - "allwinner,sun8i-h3-pwm"=20
> =C2=A0=C2=A0 - reg: physical base address and length of the controller's =
registers=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c=20
> index 39912fc..0c1c372 100644=20
> --- a/drivers/pwm/pwm-sun4i.c=20
> +++ b/drivers/pwm/pwm-sun4i.c=20
> @@ -47,6 +47,12 @@=20
>
> #define BIT_CH(bit, chan) ((bit) << ((chan) * PWMCH_OFFSET))=20
>
> +#define SUN6I_PWM_RDY_BIT PWM_RDY_BASE=20
> +#define SUN6I_PWM_CTL_OFFS 0x0=20
> +#define SUN6I_PWM_PRD_OFFS 0x4=20
> +#define SUN6I_PWM_CH_CTL(ch) (0x10 * (ch) + SUN6I_PWM_CTL_OFFS)=20
> +#define SUN6I_PWM_CH_PRD(ch) (0x10 * (ch) + SUN6I_PWM_PRD_OFFS)=20
> +=20
> struct sun4i_pwm_chip;=20
>
> static const u32 sun4i_prescaler_table[] =3D {=20
> @@ -68,6 +74,25 @@ static const u32 sun4i_prescaler_table[] =3D {=20
> 0, /* Actually 1 but tested separately */=20
> };=20
>
> +static const u32 sun6i_prescaler_table[] =3D {=20
> + 1,=20
> + 2,=20
> + 4,=20
> + 8,=20
> + 16,=20
> + 32,=20
> + 64,=20
> + 0,=20
> + 0,=20
> + 0,=20
> + 0,=20
> + 0,=20
> + 0,=20
> + 0,=20
> + 0,=20
> + 0,=20
> +};=20
> +=20
> struct sunxi_reg_ops {=20
> int (*ctl_rdy)(struct sun4i_pwm_chip *chip, int npwm);=20
> u32 (*ctl_read)(struct sun4i_pwm_chip *chip, int npwm);=20
> @@ -140,6 +165,33 @@ static void sun4i_reg_prd_write(struct sun4i_pwm_chi=
p *chip, int npwm, u32 val)=20
> sun4i_pwm_writel(chip, val, PWM_CH_PRD(npwm));=20
> }=20
>
> +static int sun6i_reg_ctl_rdy(struct sun4i_pwm_chip *chip, int npwm)=20
> +{=20
> + u32 val =3D sun4i_pwm_readl(chip, SUN6I_PWM_CH_CTL(npwm));=20
> +=20
> + return val & BIT(SUN6I_PWM_RDY_BIT);=20
> +}=20
> +=20
> +static u32 sun6i_reg_ctl_read(struct sun4i_pwm_chip *chip, int npwm)=20
> +{=20
> + return sun4i_pwm_readl(chip, SUN6I_PWM_CH_CTL(npwm));=20
> +}=20
> +=20
> +static void sun6i_reg_ctl_write(struct sun4i_pwm_chip *chip, int npwm, u=
32 val)=20
> +{=20
> + return sun4i_pwm_writel(chip, val, SUN6I_PWM_CH_CTL(npwm));=20
> +}=20
> +=20
> +static u32 sun6i_reg_prd_read(struct sun4i_pwm_chip *chip, int npwm)=20
> +{=20
> + return sun4i_pwm_readl(chip, SUN6I_PWM_CH_PRD(npwm));=20
> +}=20
> +=20
> +static void sun6i_reg_prd_write(struct sun4i_pwm_chip *chip, int npwm, u=
32 val)=20
> +{=20
> + return sun4i_pwm_writel(chip, val, SUN6I_PWM_CH_PRD(npwm));=20
> +}=20
> +=20
> static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm=
,=20
> =C2=A0=C2=A0=C2=A0 int duty_ns, int period_ns)=20
> {=20
> @@ -306,6 +358,14 @@ static const struct sunxi_reg_ops sun4i_reg_ops =3D =
{=20
> .prd_write =3D sun4i_reg_prd_write,=20
> };=20
>
> +static const struct sunxi_reg_ops sun6i_reg_ops =3D {=20
> + .ctl_rdy=C2=A0=C2=A0 =3D sun6i_reg_ctl_rdy,=20
> + .ctl_read=C2=A0 =3D sun6i_reg_ctl_read,=20
> + .ctl_write =3D sun6i_reg_ctl_write,=20
> + .prd_read=C2=A0 =3D sun6i_reg_prd_read,=20
> + .prd_write =3D sun6i_reg_prd_write,=20
> +};=20
> +=20
> static const struct pwm_ops sun4i_pwm_ops =3D {=20
> .config =3D sun4i_pwm_config,=20
> .set_polarity =3D sun4i_pwm_set_polarity,=20
> @@ -338,6 +398,14 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a1=
3 =3D {=20
> .prescaler_table =3D sun4i_prescaler_table,=20
> };=20
>
> +static const struct sun4i_pwm_data sun6i_pwm_data_a31 =3D {=20
> + .has_prescaler_bypass =3D false,=20
> + .has_rdy =3D true,=20
> + .npwm =3D 4,=20
> + .ops =3D &sun6i_reg_ops,=20
> + .prescaler_table =3D sun6i_prescaler_table,=20
> +};=20
> +=20
> static const struct sun4i_pwm_data sun4i_pwm_data_a20 =3D {=20
> .has_prescaler_bypass =3D true,=20
> .has_rdy =3D true,=20
> @@ -365,6 +433,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] =
=3D {=20
> .compatible =3D "allwinner,sun5i-a13-pwm",=20
> .data =3D &sun4i_pwm_data_a13,=20
> }, {=20
> + .compatible =3D "allwinner,sun6i-a31-pwm",=20
> + .data =3D &sun6i_pwm_data_a31,=20
> + }, {=20
> .compatible =3D "allwinner,sun7i-a20-pwm",=20
> .data =3D &sun4i_pwm_data_a20,=20
> }, {=20
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
