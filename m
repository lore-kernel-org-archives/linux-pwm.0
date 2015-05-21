From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/2] pwm: Add device tree binding document for R-Car
 PWM Timer
Date: Thu, 21 May 2015 10:31:30 +0200
Message-ID: <CAMuHMdXgB9MTUfZxUXuES8JF42G9Ld2VTeOe2J9MjuZCeONOeg@mail.gmail.com>
References: <1432176653-4452-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1432176653-4452-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432176653-4452-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Thu, May 21, 2015 at 4:50 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add binding document for Renesas PWM Timer on R-Car SoCs.

Thanks for your patch!

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
with one minor nit below.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt

> +Example: R8A7790 (R-Car H2) PWM Timer node
> +
> +       pwm0: pwm@e6e30000 {
> +               compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
> +               reg = <0 0xe6e30000 0 0x10>;

Length 8 is sufficient, as there are only 2 32-bit registers.

> +               #pwm-cells = <2>;
> +               clocks = <&mstp5_clks R8A7790_CLK_PWM>;
> +               pinctrl-0 = <&pwm0_pins>;
> +               pinctrl-names = "default";
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
