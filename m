From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 3/3] ARM64: dts: meson-axg: add PWM DT info for
 Meson-Axg SoC
Date: Mon, 04 Dec 2017 10:17:39 +0100
Message-ID: <1512379059.2574.17.camel@baylibre.com>
References: <20171204060018.8856-1-yixun.lan@amlogic.com>
         <20171204060018.8856-4-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39099 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbdLDJRm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Dec 2017 04:17:42 -0500
Received: by mail-wr0-f196.google.com with SMTP id a41so14527111wra.6
        for <linux-pwm@vger.kernel.org>; Mon, 04 Dec 2017 01:17:41 -0800 (PST)
In-Reply-To: <20171204060018.8856-4-yixun.lan@amlogic.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, 2017-12-04 at 14:00 +0800, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> Add PWM DT info for the Amlogic's Meson-Axg SoC.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 120
> +++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 92f65eec3e18..f7f228701df1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -177,6 +177,24 @@
> 

[...]

> 
> @@ -435,6 +537,24 @@
>  				clock-names = "clk_i2c";
>  			};
>  
> +			pwm_AO_ab: pwm@7000 {
> +				compatible = "amlogic,meson-axg-ao-pwm";
> +				reg = <0x0 0x07000 0x0 0x20>;
> +				#pwm-cells = <3>;
> +				clocks = <&xtal>, <&xtal>;
> +				clock-names = "clkin0", "clkin1";

like gxbb, "amlogic,meson-axg-ao-pwm" does not have such clock bindings,
Later on, if we want to "correctly" get the clock from DT, it will have to gothrough a new compatible, I guess. 

> +				status = "disabled";
> +			};
> +
> +			pwm_AO_cd: pwm@2000 {
> +				compatible = "amlogic,axg-ao-pwm";
> +				reg = <0x0 0x02000  0x0 0x20>;
> +				#pwm-cells = <3>;
> +				clocks = <&xtal>, <&xtal>;
> +				clock-names = "clkin0", "clkin1";
> +				status = "disabled";
> +			};
> +
>  			uart_AO: serial@3000 {
>  				compatible = "amlogic,meson-gx-uart",
> "amlogic,meson-ao-uart";
>  				reg = <0x0 0x3000 0x0 0x18>;
