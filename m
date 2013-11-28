From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: mbimxsd53 Add backlight and LCD regulator.
Date: Thu, 28 Nov 2013 17:06:19 +0100
Message-ID: <20131128160618.GE23201@ulmo.nvidia.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
 <1385566771-366-2-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:54674 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab3K1QHG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Nov 2013 11:07:06 -0500
Content-Disposition: inline
In-Reply-To: <1385566771-366-2-git-send-email-denis@eukrea.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 04:39:30PM +0100, Denis Carikli wrote:
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi       |    7 +++
>  .../imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts  |   64 ++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts

This could probably use a more verbose commit description.

> diff --git a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts
[...]
> +#include "imx53-eukrea-mbimxsd53-baseboard.dts"
> +
> +/ {
> +	backlight {
> +		compatible = "pwm-backlight";
> +		power-supply = <&reg_lvds_backlight_3v3>;
> +		pwms = <&mc13xxx_pwm 0 16000>;
> +		brightness-levels = <0 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +	};
> +
> +	mc13xxx_pwm: pwm {
> +		compatible = "fsl,mc34708-pwm";
> +		mfd = <&pmic>;
> +		#pwm-cells = <2>;
> +	};
> +
> +	reg_lvds_backlight_3v3: lvds-backlight-en {
> +		  compatible = "regulator-fixed";
> +		  pinctrl-names = "default";
> +		  pinctrl-0 = <&pinctrl_reg_lvds_backlight>;
> +		  regulator-name = "lvds-3v3";
> +		  regulator-min-microvolt = <3300000>;
> +		  regulator-max-microvolt = <3300000>;
> +		  gpios = <&gpio4 4 0>;
> +		  enable-active-high;
> +	};
> +
> +	reg_lcd_3v3: lcd-en {
> +		  compatible = "regulator-fixed";
> +		  pinctrl-names = "default";
> +		  pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
> +		  regulator-name = "lcd-3v3";
> +		  regulator-min-microvolt = <3300000>;
> +		  regulator-max-microvolt = <3300000>;
> +		  gpios = <&gpio4 20 0>;
> +		  enable-active-high;
> +	  };

These both look like purely enable signals, in which case it might be
more appropriate to not use regulators, but rather pass them to the
backlight via the enable-gpios property. At least for the backlight
enable pin.

The LCD enable pin is a slightly different story because you can't
currently wire up panels via DT. However since we should be describing
hardware here that's something I think we'll have to live with for now
and not work around the lack of bindings by tweaking things using
existing bindings.

Also the indentation in the above mixes tabs and spaces.

Thierry

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl2n6AAoJEN0jrNd/PrOhTnsP/2biRdzi+dqMoarvljoMUxia
cIxysl6BYkhzJ1MPOtHxh1fQPf2P/jJ4gm6Xne+PiT9i7EqOYTZtJ3M5avUaDGMI
DgO4FYhXBwoD/FBwWobXuPLq/cAJh3XBDvs5XxBRzDi1dykio8WAEs/WPTHojj9A
tEyOhCDi1dGI50MOVu3QKgPUy2FBolLK6q+cj2+dasgSa/bWWTNXPh40s9H6+Koq
k77Oh41pKDOmWOapwMikjiq4klHQygbEe+y+SKTCSpYqqKwL2tavuikLBbDjrbrS
PXT7YRTR21/mfsspPi6sTZHzwn9SoUJ7OMOdSbvTQIHbmcdwn760fbPYfQlInaqT
t92fBvcjLLheXTBxZYFOmb3wH1DLsZMIjzPHuF9n07c4vfiSlclK8o3EBpJraZpJ
Man6TAj2NpvHB0VhVu9Et42XcKfBc2nko0Kk8HX26scvLABxhV20C4jnL+Qa8StF
co+I6PaLuqYQRikgh+++aW+bvZ7eWU0pxbcMcx17V3yrUk0qGHQSOqrlryNQyJgH
79p7VZpV3/gykn+3hICeOEgjuvZ4WewfqHFPoKVaOjzz2N7VHDtviYMzvn4SjNqc
9Zx2zzu3Vb22Nb0QAQaYPHGU559CMIuuao9u76lyJ5AvNxDJrNScQbvaq0In9u4A
sPPbpLjWmk3s5qJflnTo
=Kng3
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
