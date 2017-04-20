From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/5] arm64: dts: r8a7796-salvator-x: Add PWM device support
Date: Thu, 20 Apr 2017 19:51:54 +0200
Message-ID: <CAMuHMdV-gnHBjorb1MC5eq6b-nLLc8jYtbfJqigu9zwuUdZJxg@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1492608293-12435-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34422 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965940AbdDTRv4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2017 13:51:56 -0400
In-Reply-To: <1492608293-12435-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Ryo Kodama <ryo.kodama.vz@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>

On Wed, Apr 19, 2017 at 3:24 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
>
> This patch adds support of PWM{1,2} device for Salvator-X board on
> R8A7796 SoC.
>
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index 14d9e51..b4ff1b6 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts

> @@ -114,6 +126,15 @@
>                 function = "avb";
>         };
>
> +       pwm1_pins: pwm1 {
> +               groups = "pwm1_a", "pwm1_b";
> +               function = "pwm1";
> +       };
> +       pwm2_pins: pwm2 {
> +               groups = "pwm2_a", "pwm2_b";
> +               function = "pwm2";
> +       };

Same brain damage as the r8a7795 counterpart...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
