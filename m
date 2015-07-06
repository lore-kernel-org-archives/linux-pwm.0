From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v4 3/3] arm64: dts: mt8173: add MT8173 display PWM driver
 support dtsi
Date: Mon, 6 Jul 2015 21:38:59 +0800
Message-ID: <CAGS+omC_n3hVJ6P2R-9GMpJSBABeEDXk2drOu2oJvJfk6qC0dA@mail.gmail.com>
References: <1436189368-1826-1-git-send-email-yh.huang@mediatek.com> <1436189368-1826-4-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436189368-1826-4-git-send-email-yh.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jul 6, 2015 at 9:29 PM, YH Huang <yh.huang@mediatek.com> wrote:
> Add display PWM node in mt8173.dtsi.
>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 0696f8f..e4ffd9d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -393,6 +393,28 @@
>                         #size-cells = <0>;
>                         status = "disabled";
>                 };
> +
> +               pwm0: pwm@1401e000 {
> +                       compatible = "mediatek,mt8173-disp-pwm",
> +                                    "mediatek,mt6595-disp-pwm";
> +                       reg = <0 0x1401e000 0 0x1000>;
> +                       #pwm-cells = <2>;
> +                       clocks = <&mmsys MM_DISP_PWM026M>,
> +                                <&mmsys MM_DISP_PWM0MM>;

CLK_MM_DISP_PWM026M

> +                       clock-names = "main", "mm";
> +                       status = "disabled";
> +               };
> +
> +               pwm1: pwm@1401f000 {
> +                       compatible = "mediatek,mt8173-disp-pwm",
> +                                    "mediatek,mt6595-disp-pwm";
> +                       reg = <0 0x1401f000 0 0x1000>;
> +                       #pwm-cells = <2>;
> +                       clocks = <&mmsys MM_DISP_PWM126M>,
> +                                <&mmsys MM_DISP_PWM1MM>;
> +                       clock-names = "main", "mm";
> +                       status = "disabled";
> +               };
>         };
>  };
>
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
