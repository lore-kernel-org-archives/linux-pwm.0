From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv3 3/3] pwm: imx: support output polarity inversion
Date: Wed, 2 Apr 2014 07:45:49 +0200
Message-ID: <20140402054549.GW17250@pengutronix.de>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-4-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395996540-10999-4-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

Hi Lothar,

On Fri, Mar 28, 2014 at 09:49:00AM +0100, Lothar Wa=DFmann wrote:
>  static struct pwm_ops imx_pwm_ops =3D {
>  	.enable =3D imx_pwm_enable,
>  	.disable =3D imx_pwm_disable,
> @@ -210,6 +228,7 @@ struct imx_pwm_data {
>  	int (*config)(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns);
>  	void (*set_enable)(struct pwm_chip *chip, bool enable);
> +	unsigned output_polarity:1;
>  };
> =20
>  static struct imx_pwm_data imx_pwm_data_v1 =3D {
> @@ -220,6 +239,7 @@ static struct imx_pwm_data imx_pwm_data_v1 =3D {
>  static struct imx_pwm_data imx_pwm_data_v2 =3D {
>  	.config =3D imx_pwm_config_v2,
>  	.set_enable =3D imx_pwm_set_enable_v2,
> +	.output_polarity =3D 1,
>  };
> =20
>  static const struct of_device_id imx_pwm_dt_ids[] =3D {
> @@ -272,6 +292,11 @@ static int imx_pwm_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(imx->mmio_base);
> =20
>  	data =3D of_id->data;
> +	if (data->output_polarity) {
> +		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
> +		imx_pwm_ops.set_polarity =3D imx_pwm_set_polarity;
> +	}

You shouldn't modify imx_pwm_ops in the probe function, it's not good
style and prevents us from making the ops const.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
