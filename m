From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] arm64: dts: salvator-common: add 12V regulator to backlight
Date: Tue, 19 Sep 2017 11:36:28 +0300
Message-ID: <2639263.eFe0tZszFa@avalon>
References: <1505750174-29888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:35625 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdISIgY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Sep 2017 04:36:24 -0400
In-Reply-To: <1505750174-29888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, linux-pwm@vger.kernel.org, magnus.damm@gmail.com, horms@verge.net.au

Hi Ulrich,

Thank you for the patch.

On Monday, 18 September 2017 18:56:14 EEST Ulrich Hecht wrote:
> This fixes the warning "pwm-backlight backlight: backlight supply power
> not found, using dummy regulator".
> 
> Fixes: b33be33670217533 ("arm64: dts: salvator-x: Add panel backlight
> support")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> b/arch/arm64/boot/dts/renesas/salvator-common.dtsi index e3d8310..fa2a1f7
> 100644
> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> @@ -63,6 +63,7 @@
>  		brightness-levels = <256 128 64 16 8 4 0>;
>  		default-brightness-level = <6>;
> 
> +		power-supply = <&reg_12v>;
>  		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
>  	};
> 
> @@ -107,6 +108,15 @@
>  		regulator-always-on;
>  	};
> 
> +	reg_12v: regulator2 {

Nitpicking, should be call this reg_12p0v to match the naming scheme of the 
other fixed regulators ?

Apart from that, and regardless of whether you want to change the name or not,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	rsnd_ak4613: sound {
>  		compatible = "simple-audio-card";


-- 
Regards,

Laurent Pinchart
