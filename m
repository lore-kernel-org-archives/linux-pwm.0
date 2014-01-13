From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] pwm: imx: support polarity inversion
Date: Mon, 13 Jan 2014 12:13:58 +0100
Message-ID: <11504930.fjG2AZiQ4e@wuerfel>
References: <1389608988-10981-1-git-send-email-LW@KARO-electronics.de> <1389608988-10981-3-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59045 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaAMLQl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jan 2014 06:16:41 -0500
In-Reply-To: <1389608988-10981-3-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Monday 13 January 2014 11:29:48 Lothar Wa=DFmann wrote:

> diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.d=
tsi
> index 01c0499..e3647a8 100644
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -273,7 +273,7 @@
>  			};
> =20
>  			pwm1: pwm@53fb4000 {
> -				#pwm-cells =3D <2>;
> +				#pwm-cells =3D <3>;
>  				compatible =3D "fsl,imx50-pwm", "fsl,imx27-pwm";
>  				reg =3D <0x53fb4000 0x4000>;
>  				clocks =3D <&clks IMX5_CLK_PWM1_IPG_GATE>,
=2E..
> @@ -271,6 +293,13 @@ static int imx_pwm_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(imx->mmio_base);
> =20
>  	data =3D of_id->data;
> +	if (data->output_polarity) {
> +		dev_info(&pdev->dev, "PWM supports inversion\n");
> +		imx_pwm_ops.set_polarity =3D imx_pwm_set_polarity;
> +		imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +		imx->chip.of_pwm_n_cells =3D 3;
> +	}
> +
>  	imx->config =3D data->config;
>  	imx->set_enable =3D data->set_enable;

This looks like you are breaking compatibility with the binding,
which requires #pwm-cells to be <2>. You can extend the binding
to allow both <2> and <3>, but then you have to not only document
that change in the binding, but also ensure that the pwm driver
is able to use either variant.

	Arnd
