From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v7 1/2] pwm: Add device tree binding document for R-Car
 PWM Timer
Date: Mon, 5 Oct 2015 10:38:59 -0500
Message-ID: <CAL_JsqJqwk6W5psXY9BZXwm4GwhG1Dr44Xq-7tf-MmSAtqpnzA@mail.gmail.com>
References: <1443602873-4316-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1443602873-4316-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1443602873-4316-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linux PWM List <linux-pwm@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Sep 30, 2015 at 3:47 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add binding document for Renesas PWM Timer on R-Car SoCs.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
>
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> new file mode 100644
> index 0000000..ea0a27b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> @@ -0,0 +1,27 @@
> +* Renesas R-Car PWM Timer Controller
> +
> +Required Properties:
> +- compatible: should be one of the following.
> + - "renesas,pwm-rcar": for generic R-Car compatible PWM Timer

Should be this one and one of the following? That is what the example shows.

> + - "renesas,pwm-r8a7778": for R-Car M1A
> + - "renesas,pwm-r8a7779": for R-Car H1
> + - "renesas,pwm-r8a7790": for R-Car H2
> + - "renesas,pwm-r8a7791": for R-Car M2-W
> + - "renesas,pwm-r8a7794": for R-Car E2
> +- reg: base address and length of the registers block for the PWM.
> +- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
> +  the cells format.
> +- clocks: clock phandle and specifier pair.
> +- pinctrl-0: phandle, referring to a default pin configuration node.
> +- pinctrl-names: Set to "default".
> +
> +Example: R8A7790 (R-Car H2) PWM Timer node
> +
> +       pwm0: pwm@e6e30000 {
> +               compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
> +               reg = <0 0xe6e30000 0 0x8>;
> +               #pwm-cells = <2>;
> +               clocks = <&mstp5_clks R8A7790_CLK_PWM>;
> +               pinctrl-0 = <&pwm0_pins>;
> +               pinctrl-names = "default";
> +       };
> --
> 1.9.1
>
