From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 4/8] arm64: dts: r8a7796: salvator-x: Add panel
 backlight support
Date: Tue, 5 Sep 2017 17:08:55 +0200
Message-ID: <CAMuHMdVvE=L2cv6bhAqqaENMm1+ZYbrGKr4SFwodv1mawyv2Sw@mail.gmail.com>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1493303863-23719-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1493303863-23719-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pwm@vger.kernel.org

Hi Ulrich,

On Thu, Apr 27, 2017 at 4:37 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> The panel backlight is controlled through a GPIO and a PWM channel.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index 14d9e51..abda84c 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -133,6 +133,11 @@
>                 function = "i2c2";
>         };
>
> +       pwm1_pins: pwm {
> +               groups = "pwm1_a";
> +               function = "pwm1";
> +       };
> +
>         sdhi0_pins: sd0 {
>                 groups = "sdhi0_data4", "sdhi0_ctrl";
>                 function = "sdhi0";
> @@ -183,6 +188,16 @@
>                 interrupt-parent = <&gpio2>;
>                 interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>         };
> +
> +       backlight: backlight {
> +               compatible = "pwm-backlight";
> +               pwms = <&pwm1 0 50000>;
> +
> +               brightness-levels = <256 128 64 16 8 4 0>;
> +               default-brightness-level = <6>;
> +
> +               enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
> +       };
>  };

This prints the following warning:

pwm-backlight backlight: backlight supply power not found, using dummy regulator

According to Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt,
the "power-supply" property is required.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
