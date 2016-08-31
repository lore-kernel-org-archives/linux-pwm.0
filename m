From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
Date: Wed, 31 Aug 2016 16:33:26 +0800
Message-ID: <CAGb2v66etp0AsYvs8n3MgBXehqV=kwkSnuq=Kt=aLtH4xvcDkA@mail.gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com> <20160831082520.25962-2-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831082520.25962-2-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 31, 2016 at 4:25 PM, Milo Kim <woogyom.kim@gmail.com> wrote:
> H3 PA5 pin is assigned for single PWM channel.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index fdf9fdb..05d0c4b 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -360,6 +360,13 @@
>                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>                         };
>
> +                       pwm0_pin_a: pwm0@0 {

This is the only possible configuration. You can drop the _a suffix
from the label, and @0 from the node name.

ChenYu

> +                               allwinner,pins = "PA5";
> +                               allwinner,function = "pwm0";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
>                         uart0_pins_a: uart0@0 {
>                                 allwinner,pins = "PA4", "PA5";
>                                 allwinner,function = "uart0";
> --
> 2.9.3
>
