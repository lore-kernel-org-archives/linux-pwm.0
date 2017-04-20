From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/5] arm64: dts: r8a7795-salvator-x: Enable PWM
Date: Thu, 20 Apr 2017 19:51:25 +0200
Message-ID: <CAMuHMdXOZD6HrWEuinOKGBjnR--VfY3VJF4k1uOSE06UKEVj3g@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1492608293-12435-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34079 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033577AbdDTRv1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2017 13:51:27 -0400
In-Reply-To: <1492608293-12435-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Uli,

On Wed, Apr 19, 2017 at 3:24 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch enables PWM{1,2} for Salvator-X board on R8A7795 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index bf4674e..842b0dd 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -282,6 +282,18 @@
>         };
>  };
>
> +&pwm1 {
> +       pinctrl-0 = <&pwm1_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +};
> +
> +&pwm2 {
> +       pinctrl-0 = <&pwm2_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +};
> +
>  &du {
>         pinctrl-0 = <&du_pins>;
>         pinctrl-names = "default";
> @@ -324,6 +336,16 @@
>         pinctrl-0 = <&scif_clk_pins>;
>         pinctrl-names = "default";
>
> +       pwm1_pins: pwm1 {
> +               groups = "pwm1_a", "pwm1_b";

Enabling both the A and B alternative pins?

> +               function = "pwm1";
> +       };
> +
> +       pwm2_pins: pwm2 {
> +               groups = "pwm2_a", "pwm2_b";

Enabling both the A and B alternative pins?

> +               function = "pwm2";
> +       };
> +

Oh, I wrote that before:
http://www.spinics.net/lists/linux-renesas-soc/msg00026.html

And we already have a correct v3 from you in patchwork:
https://patchwork.kernel.org/patch/8711801/

And Laurent enabled backlight independently:
https://lists.freedesktop.org/archives/dri-devel/2016-November/124385.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
