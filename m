From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/5] arm64: dts: r8a7796: Add PWM device nodes
Date: Thu, 20 Apr 2017 19:40:01 +0200
Message-ID: <CAMuHMdWO3X5LJ8RozuGwueJcVYNjSV1gDpHXW+aMrfc8wYt9Lw@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1492608293-12435-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36210 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944667AbdDTRkD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2017 13:40:03 -0400
In-Reply-To: <1492608293-12435-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>

Hi Uli,

On Wed, Apr 19, 2017 at 3:24 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds PWM{0,1,2,3,4,5,6} device nodes for R8A7796 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 63 ++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index 798fe0f..578b318 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -455,6 +455,69 @@
>                         status = "disabled";
>                 };
>
> +               pwm0: pwm@e6e30000 {
> +                       compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";

Please also send a patch to document "renesas,pwm-r8a7796" in the
renesas,pwm-rcar DT bindings.

> +                       reg = <0 0xe6e30000 0 0x10>;

A length of 8 would be sufficient.  Not a big issue due, as ioremap()
granularity
is PAGE_SIZE anyway.

> +                       #pwm-cells = <2>;
> +                       clocks = <&cpg CPG_MOD 523>;
> +                       power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;

Missing "resets = <&cpg 523>;"

> +                       status = "disabled";
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
