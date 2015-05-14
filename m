From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] pwm: Add device tree binding document for R-Car PWM Timer
Date: Thu, 14 May 2015 17:48:28 +0200
Message-ID: <CAMuHMdWzQYbn3f5zL2bhx1+RP4buLH8XGweyjWimydgwLyLNYw@mail.gmail.com>
References: <1431509238-7648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1431509238-7648-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1431509238-7648-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Wed, May 13, 2015 at 11:27 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add binding document for Renesas PWM Timer on R-Car SoCs.

Thanks for your patch!

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../devicetree/bindings/pwm/renesas,pwm-rcar.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
>
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> new file mode 100644
> index 0000000..38123f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> @@ -0,0 +1,21 @@
> +* Renesas R-Car PWM Timer Controller
> +
> +Required Properties:
> +- compatible: must contain "renesas,pwm-rcar"

Can you please add SoC-specific compatible values, too? That way we can handle
 SoC-specific differences if we ever encounter them.
If I'm not mistaken, this PWM IP core is present on both R-Car Gen1 and Gen2
SoCs?

> +- reg: base address and length of the registers block for the PWM
> +- #pwm-cells: should be 7. See pwm.txt in this directory for a description of
> +  the cells format.

Why 7? This is not the number of channels, cfr. pwm.txt you reference above:

    "pwm-specifier typically encodes the chip-relative PWM number and the PWM
     period in nanoseconds.

     Optionally, the pwm-specifier can encode a number of flags (defined in
     <dt-bindings/pwm/pwm.h>) in a third cell:
     - PWM_POLARITY_INVERTED: invert the PWM signal polarity"

So 2 or 3 makes more sense to me.

> +- clocks: clock phandle and specifier pair.
> +- pinctrl-0: phandle, referring to a default pin configuration node.
> +- pinctrl-names: Set to "default"
> +
> +Example: R8A7790 (R-Car H2) PWM Timer node
> +
> +       pwm: pwm@e6e30000 {
> +               compatible = "renesas,pwm-rcar";
> +               reg = <0 0xe6e30000 0 0x7000>;
> +               #pwm-cells = <7>;
> +               clocks = <&mstp5_clks R8A7790_CLK_PWM>;
> +               pinctrl-0 = <&pwm3_pins>;
> +               pinctrl-names = "default";
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
