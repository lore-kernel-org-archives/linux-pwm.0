From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH 1/7] ARM: stih407: Add DT nodes for for PWM
Date: Wed, 18 Jun 2014 17:07:35 +0200
Message-ID: <CAG374jCGhjACBr1a86_W6wQYWq8_CofwSFxZO+4j=3aHQC2nmg@mail.gmail.com>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, "kernel@stlinux.com" <kernel@stlinux.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, ajitpal.singh@st.com, thierry.reding@gmail.com, Maxime Coquelin <maxime.coquelin@st.com>
List-Id: linux-pwm@vger.kernel.org

Hi Lee,
minor remark below..

On 18 June 2014 16:52, Lee Jones <lee.jones@linaro.org> wrote:
> Supply top level nodes for the STiH407 based development boards.
> The Pinctrl configuration has already been applied, so the only
> missing piece of the DT puzzle is for a board's DTB to enable
> the nodes.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
> index 4f9024f..6b43ba2 100644
> --- a/arch/arm/boot/dts/stih407.dtsi
> +++ b/arch/arm/boot/dts/stih407.dtsi
> @@ -259,5 +259,32 @@
>
>                         status = "disabled";
>                 };
> +
> +               /* COMMS PWM Module */
> +               pwm0: pwm@9810000 {
> +                       compatible      = "st,sti-pwm";
> +                       status          = "disabled";
> +                       #pwm-cells      = <2>;
> +                       reg             = <0x9810000 0x68>;
> +                       pinctrl-names   = "default";
> +                        pinctrl-0      = <&pinctrl_pwm0_chan0_default>;
del space

> +                       clock-names     = "pwm";
> +                       clocks          = <&clk_sysin>;
> +               };
> +
> +               /* SBC PWM Module */
> +               pwm1: pwm@9510000 {
> +                       compatible      = "st,sti-pwm";
> +                       status          = "disabled";
> +                       #pwm-cells      = <2>;
> +                       reg             = <0x9510000 0x68>;
> +                       pinctrl-names   = "default";
> +                       pinctrl-0       = <&pinctrl_pwm1_chan0_default
> +                                       &pinctrl_pwm1_chan1_default
> +                                       &pinctrl_pwm1_chan2_default
> +                                       &pinctrl_pwm1_chan3_default>;
> +                       clock-names     = "pwm";
> +                       clocks          = <&clk_sysin>;
> +               };
>         };
>  };
> --
> 1.8.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
