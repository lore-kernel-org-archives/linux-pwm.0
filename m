From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC
 driver
Date: Mon, 24 Nov 2014 11:13:27 +0100
Message-ID: <20141124101325.GB25912@ulmo.nvidia.com>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
 <1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49013 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaKXKNd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 05:13:33 -0500
Content-Disposition: inline
In-Reply-To: <1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: naidu.tellapati@gmail.com
Cc: abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2014 at 07:23:29AM +0530, naidu.tellapati@gmail.com wrote:
> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>=20
> The Pistachio SOC from Imagination Technologies includes a Pulse Width
> Modulation DAC which produces 1 to 4 digital bit-outputs which represent
> digital waveforms. These PWM outputs are primarily in charge of controlli=
ng
> backlight LED devices.
>=20
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
> ---
>  drivers/pwm/Kconfig   |   12 ++
>  drivers/pwm/Makefile  |    1 +
>  drivers/pwm/pwm-img.c |  270 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 283 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/pwm/pwm-img.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index ef2dd2e..6b4581a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -110,6 +110,18 @@ config PWM_FSL_FTM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-fsl-ftm.
> =20
> +config PWM_IMG

This sounds really generic to me. Basically this says that every PWM IP
developed by Imagination Technologies will be compatible with this one.
It's typical to name modules after <vendor>-<soc> to avoid this type of
ambiguity.

Is there any reason why this can't be called PWM_IMG_PISTACHIO?

> +	tristate "Imagination Technologies PWM driver"
> +	depends on MFD_SYSCON
> +	depends on HAS_IOMEM

I think you'll need at least COMMON_CLK here as well.

> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
[...]
> +/* PWM registers */
> +#define CR_PWM_CTRL_CFG				0x0000
> +#define CR_PWM_CTRL_CFG_NO_SUB_DIV		0
> +#define CR_PWM_CTRL_CFG_SUB_DIV0		1
> +#define CR_PWM_CTRL_CFG_SUB_DIV1		2
> +#define CR_PWM_CTRL_CFG_SUB_DIV0_DIV1		3
> +#define CR_PWM_CTRL_CFG_DIV_SHIFT(ch)		((ch) * 2 + 4)
> +#define CR_PWM_CTRL_CFG_DIV_MASK		0x3
> +
> +#define CR_PWM_CH_CFG(ch)			(0x4 + (ch) * 4)
> +#define CR_PWM_CH_CFG_TMBASE_SHIFT		0
> +#define CR_PWM_CH_CFG_DUTY_SHIFT		16

What's with the CR_ prefix here? What does it stand for? Can't you just
drop it?

> +#define CR_PERIP_PWM_PDM_CONTROL		0x0140
> +#define CR_PERIP_PWM_PDM_CONTROL_CH_MASK	0x1
> +#define CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(ch)	((ch) * 4)
> +
> +#define IMG_NUM_PWM				4

I don't think you need this. See below for more details.

> +static inline void img_pwm_writel(struct img_pwm_chip *chip,
> +				  unsigned int reg, unsigned long val)
> +{
> +	writel(val, chip->base + reg);
> +}
> +
> +static inline unsigned int img_pwm_readl(struct img_pwm_chip *chip,
> +					 unsigned int reg)
> +{
> +	return readl(chip->base + reg);
> +}

readl() and writel() deal with u32 data, please use consistent types.

> +static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  int duty_ns, int period_ns)
> +{
> +	unsigned int div;
> +	unsigned int duty_steps;
> +	unsigned int tmbase_steps;
> +	unsigned long val;
> +	unsigned long mul;
> +	unsigned long output_clk_hz;
> +	unsigned long input_clk_hz;

Many of these can be folded into single lines. And again, val is used to
store register contents and should be u32.

> +	struct img_pwm_chip *pwm_chip;
> +
> +	pwm_chip =3D to_img_pwm_chip(chip);
> +
> +	input_clk_hz =3D clk_get_rate(pwm_chip->pwm_clk);
> +	output_clk_hz =3D DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
> +
> +	mul =3D DIV_ROUND_UP(input_clk_hz, output_clk_hz);
> +	if (mul > MAX_TMBASE_STEPS * 512) {
> +		dev_err(chip->dev,
> +			"failed to configure timebase steps/divider value.\n");
> +		return -EINVAL;
> +	}

I think it'd be more readable if this was the final else in the block of
if/else if below.

> +
> +	if (mul <=3D MAX_TMBASE_STEPS) {
> +		div =3D CR_PWM_CTRL_CFG_NO_SUB_DIV;
> +		tmbase_steps =3D DIV_ROUND_UP(mul, 1);
> +	} else if (mul <=3D MAX_TMBASE_STEPS * 8) {
> +		div =3D CR_PWM_CTRL_CFG_SUB_DIV0;
> +		tmbase_steps =3D DIV_ROUND_UP(mul, 8);
> +	} else if (mul <=3D MAX_TMBASE_STEPS * 64) {
> +		div =3D CR_PWM_CTRL_CFG_SUB_DIV1;
> +		tmbase_steps =3D DIV_ROUND_UP(mul, 64);
> +	} else if (mul <=3D MAX_TMBASE_STEPS * 512) {
> +		div =3D CR_PWM_CTRL_CFG_SUB_DIV0_DIV1;
> +		tmbase_steps =3D DIV_ROUND_UP(mul, 512);
> +	}
> +
> +	duty_steps =3D DIV_ROUND_UP(tmbase_steps * duty_ns, period_ns);
> +
> +	val =3D img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +	val &=3D ~(CR_PWM_CTRL_CFG_DIV_MASK <<
> +					CR_PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
> +	val |=3D (div & CR_PWM_CTRL_CFG_DIV_MASK) <<
> +					CR_PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm);

If you leave out the CR_ prefix these will actually fit on a single
line.

> +	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +
> +	val =3D (duty_steps << CR_PWM_CH_CFG_DUTY_SHIFT) |
> +				(tmbase_steps << CR_PWM_CH_CFG_TMBASE_SHIFT);

I prefer subsequent lines to be aligned with the first, like so:

	val =3D (duty_steps ...) |
	      (tmbase_steps ...);

Also I'd leave out the _steps suffix, it doesn't really add information.

> +static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	unsigned int val;

Should be u32 as well. There are other occurrences like this in the
remainder of the driver, but I haven't commented on all of them
explicitly. Please fix them all up to be consistent.

> +	struct img_pwm_chip *pwm_chip;
> +
> +	pwm_chip =3D to_img_pwm_chip(chip);

The above can be a single line.

> +
> +	val =3D img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +	val |=3D BIT(pwm->hwpwm);
> +	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +
> +	regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
> +			   CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
> +			   CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);

This smells like pinmux and should probably be a separate driver.

> +static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +{
> +	unsigned int val;
> +	struct img_pwm_chip *pwm_chip;
> +
> +	pwm_chip =3D to_img_pwm_chip(chip);
> +
> +	val =3D img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +	val &=3D ~BIT(pwm->hwpwm);
> +	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +
> +	regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
> +			   CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
> +			   CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 1);
> +}

Same comments as for img_pwm_enable().

> +static int img_pwm_probe(struct platform_device *pdev)
> +{
[...]
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.ops =3D &img_pwm_ops;
> +	pwm->chip.base =3D -1;
> +	pwm->chip.npwm =3D IMG_NUM_PWM;

You can directly substitute 4 here since it's the only place you need
it.

> +static int img_pwm_remove(struct platform_device *pdev)
> +{
> +	unsigned int i;
> +	unsigned int val;
> +
> +	struct img_pwm_chip *pwm_chip =3D platform_get_drvdata(pdev);

This should go at the very top of the variable declarations.

> +
> +	for (i =3D 0; i < IMG_NUM_PWM; i++) {

This would better be pwm_chip->chip.npwm.

Thierry

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUcwTFAAoJEN0jrNd/PrOhF5AP/i/bz8UVByQT3hOP/VIfjwr+
rBAwogrKZ/XSKUUW6waKqb5l5N6yxeMl2b+Lx+SVbPoB/VqEJmbh5kf+Y8G85NeB
iXxlkpNO8eOtHnzETCMWoYfjF8fS8xOO2Dnvhdw21SAiQJw/r/MmQW2fa6iSoNTr
tLBdmVAfh4RkSDL1QDMRlpn+oluO0Zdkksd6C0h/j8oxcMLIQUQWTVIsB51rgYmt
NDzOK3m58SSwRwbOE1vmscMx2XYg/x4N8gsdKd7BCAZehDA65mJSswfWWZ2UMPXN
uBoG4vVgwkKYPH0PB5S+Z1rIpfDzooBB3xX6QTuNNAVjTTwLOYzdFDDq0GEFisuV
3gnAlKvHArA1ZC1uIl0PXcdgbG0sGMwPWUc2py38Ybw/JAL8hrTSTqBGBoDKXRjF
jwa0J2VKsDdsSH4OK/j8GQfFj/Jd3SXnCafF7ez10g4ZBcqVKuMFFUct0pjbXRCj
kSvB5GLSl11MShY23X8XVLldM58NgbdZA9YAWiTDX10GuSFK28BNZPBBykNZKg+q
hKri9tC2uvNI/h7UnuQYUDHniZ0RlsEl3OG3LAXvq2avpMi8L260IFWfL0W8al+D
8MsxQrWyX/LMHPtNJf6PoWMtUJu3qa4z6zX9Qk2C9T+xcW8ELD9X1x0A9vbRnPK5
qFrmFBBwt5GCzgpebsJz
=MFNo
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
