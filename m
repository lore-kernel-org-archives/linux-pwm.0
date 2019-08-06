Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35394 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFJVu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 05:21:50 -0400
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Aug 2019 11:21:38 +0200
Message-ID: <CAMuHMdWSKAeiF4e9ZtyJq0Tejre35Ajok5Uf-ToDO4n+A6j6BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH RFC 4/7] dt-bindings: pwm: rcar: Add specific gpios
 property to output duty zero
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Shimoda-san,

On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The R-Car SoCs PWM Timer cannot output duty zero. So, this patch
> adds a specific gpio property to output it.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> @@ -26,6 +26,9 @@ Required Properties:
>  - pinctrl-0: phandle, referring to a default pin configuration node.
>  - pinctrl-names: Set to "default".
>
> +Optional properties:
> +- renesas,duty-zero-gpios: Specify GPIO for outputting duty zero.
> +
>  Example: R8A7743 (RZ/G1M) PWM Timer node
>
>         pwm0: pwm@e6e30000 {

I'm not so fond of adding a property to specify this explicitly: the PFC
driver already knows the mapping from the PWM output pin to the GPIO
number. However, I agree it is not easy to obtain this in a generic way.

For a PWM block with a single pin, it's easy: the pin you want to switch
between GPIO and pin function is the single pin in the single pin
control group specified in the board DT.

For blocks with multiple pins (e.g. SPI, UART), it is more complex, and
depends on the granularity of the pin control groups.
E.g. for UART, Renesas SoCs typically use 3 pin control groups ("data"
for RXD/TXD, "ctrl" for RTS/CTS, and "clk" for clock), and the pin
control driver (at least for sh-pfc) does not know which pin corresponds
to which GPIO inside each group.  Perhaps this information should be
added, with an API to retrieve it?

Anyone who has a good suggestion?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
