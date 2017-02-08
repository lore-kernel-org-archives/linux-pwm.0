From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: pwm: sun6i: add support the
 Allwinner A31 PWM.
Date: Wed, 8 Feb 2017 08:53:27 +0100
Message-ID: <20170208075327.vv4p4svukxh7frvn@lukather>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-4-git-send-email-lis8215@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="seq76nlc3mleerbw"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBVVR5PCAKGQE23HU3NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1486489846-662-4-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--seq76nlc3mleerbw
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Feb 07, 2017 at 08:50:45PM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch introduce the sun6i PWM driver itself:
>  - sun6i register operations,
>  - sun6i prescaler table,
>  - DT bindings for A31 SoC,
>  - documentation update.
> 
> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  3 +-
>  drivers/pwm/pwm-sun4i.c                            | 71 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> index f1cbeef..b737934 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> @@ -1,10 +1,11 @@
> -Allwinner sun4i and sun7i SoC PWM controller
> +Allwinner sun4i, sun6i and sun7i SoC PWM controller
>  
>  Required properties:
>    - compatible: should be one of:
>      - "allwinner,sun4i-a10-pwm"
>      - "allwinner,sun5i-a10s-pwm"
>      - "allwinner,sun5i-a13-pwm"
> +    - "allwinner,sun6i-a31-pwm"
>      - "allwinner,sun7i-a20-pwm"
>      - "allwinner,sun8i-h3-pwm"
>    - reg: physical base address and length of the controller's registers
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 39912fc..0c1c372 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -47,6 +47,12 @@
>  
>  #define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
>  
> +#define SUN6I_PWM_RDY_BIT	PWM_RDY_BASE
> +#define SUN6I_PWM_CTL_OFFS	0x0
> +#define SUN6I_PWM_PRD_OFFS	0x4
> +#define SUN6I_PWM_CH_CTL(ch)	(0x10 * (ch) + SUN6I_PWM_CTL_OFFS)
> +#define SUN6I_PWM_CH_PRD(ch)	(0x10 * (ch) + SUN6I_PWM_PRD_OFFS)
> +
>  struct sun4i_pwm_chip;
>  
>  static const u32 sun4i_prescaler_table[] = {
> @@ -68,6 +74,25 @@ static const u32 sun4i_prescaler_table[] = {
>  	0, /* Actually 1 but tested separately */
>  };
>  
> +static const u32 sun6i_prescaler_table[] = {
> +	1,
> +	2,
> +	4,
> +	8,
> +	16,
> +	32,
> +	64,
> +	0,
> +	0,
> +	0,
> +	0,
> +	0,
> +	0,
> +	0,
> +	0,
> +	0,
> +};
> +
>  struct sunxi_reg_ops {
>  	int (*ctl_rdy)(struct sun4i_pwm_chip *chip, int npwm);
>  	u32 (*ctl_read)(struct sun4i_pwm_chip *chip, int npwm);
> @@ -140,6 +165,33 @@ static void sun4i_reg_prd_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
>  	sun4i_pwm_writel(chip, val, PWM_CH_PRD(npwm));
>  }
>  
> +static int sun6i_reg_ctl_rdy(struct sun4i_pwm_chip *chip, int npwm)
> +{
> +	u32 val = sun4i_pwm_readl(chip, SUN6I_PWM_CH_CTL(npwm));
> +
> +	return val & BIT(SUN6I_PWM_RDY_BIT);
> +}
> +
> +static u32 sun6i_reg_ctl_read(struct sun4i_pwm_chip *chip, int npwm)
> +{
> +	return sun4i_pwm_readl(chip, SUN6I_PWM_CH_CTL(npwm));
> +}
> +
> +static void sun6i_reg_ctl_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
> +{
> +	return sun4i_pwm_writel(chip, val, SUN6I_PWM_CH_CTL(npwm));
> +}
> +
> +static u32 sun6i_reg_prd_read(struct sun4i_pwm_chip *chip, int npwm)
> +{
> +	return sun4i_pwm_readl(chip, SUN6I_PWM_CH_PRD(npwm));
> +}
> +
> +static void sun6i_reg_prd_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
> +{
> +	return sun4i_pwm_writel(chip, val, SUN6I_PWM_CH_PRD(npwm));
> +}
> +
>  static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    int duty_ns, int period_ns)
>  {
> @@ -306,6 +358,14 @@ static const struct sunxi_reg_ops sun4i_reg_ops = {
>  	.prd_write = sun4i_reg_prd_write,
>  };
>  
> +static const struct sunxi_reg_ops sun6i_reg_ops = {
> +	.ctl_rdy   = sun6i_reg_ctl_rdy,
> +	.ctl_read  = sun6i_reg_ctl_read,
> +	.ctl_write = sun6i_reg_ctl_write,
> +	.prd_read  = sun6i_reg_prd_read,
> +	.prd_write = sun6i_reg_prd_write,
> +};
> +

... And use regmap's reg_field to deal with the different offsets in
that case ?

Looks quite good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--seq76nlc3mleerbw--
