From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH 7/7] pwm: st: Supply Device Tree binding documentation for
 ST's PWM IP
Date: Wed, 18 Jun 2014 17:08:31 +0200
Message-ID: <CAG374jBJpmgv+X_ZT-Q6kj89p8BvVLb3sUsBHmD7GHF=jLQ=Ew@mail.gmail.com>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
	<1403103172-19856-7-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:51809 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbaFRPIc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jun 2014 11:08:32 -0400
Received: by mail-qa0-f50.google.com with SMTP id m5so822902qaj.9
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2014 08:08:31 -0700 (PDT)
In-Reply-To: <1403103172-19856-7-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, "kernel@stlinux.com" <kernel@stlinux.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, ajitpal.singh@st.com, thierry.reding@gmail.com, Maxime Coquelin <maxime.coquelin@st.com>

Hi Lee,
minor remark below..

On 18 June 2014 16:52, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-st.txt | 41 ++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-st.txt
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> new file mode 100644
> index 0000000..ea88c5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> @@ -0,0 +1,41 @@
> +STMicroelectronics PWM driver bindings
> +--------------------------------------

> +Example:
> +
> +pwm1: pwm@fe510000 {
> +       compatible = "st,pwm";
> +       reg = <0xfe510000 0x68>;
> +       #pwm-cells = <2>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm1_chan0_default
> +                    &pinctrl_pwm1_chan1_default
> +                    &pinctrl_pwm1_chan2_default
> +                    &pinctrl_pwm1_chan3_default>;
> +       clocks = <&CLK_SYSIN>;
clock name in lower case

> +       clock-names = "pwm";
> +       st,pwm-num-chan = <4>;
> +};
> --
> 1.8.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
