From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: add MediaTek display PWM
 bindings
Date: Mon, 29 Jun 2015 23:24:43 +0800
Message-ID: <1435591483.21804.2.camel@mtksdaap41>
References: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com>
	 <1435590211-38854-2-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435590211-38854-2-git-send-email-yh.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, yh.huang@mediatek.com
List-Id: linux-pwm@vger.kernel.org

I am sorry for forgetting to remove Change-Id in [PATCH v3 1/2] and
[PATCH v3 1/2].

Regards,
YH Huang

On Mon, 2015-06-29 at 23:03 +0800, YH Huang wrote:
> Document the device-tree binding of MediatTek display PWM.
> The clock "main" and "mm" are used to generate PWM signals.
> The PWM has one channel to control the backlight brightness for display.
> It supports MT8173 and MT6595.
> 
> Change-Id: I194ca88b4e4cd01a28b8701e07e86ea6941e5292
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> new file mode 100644
> index 0000000..355b755
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> @@ -0,0 +1,24 @@
> +MediaTek display PWM controller
> +
> +Required properties:
> + - compatible: should be "mediatek,<name>-disp-pwm"
> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
> +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
> + - reg: physical base address and length of the controller's registers
> + - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
> +   the cell format
> + - clocks: phandle and clock specifier of the PWM reference clock
> + - clock-names: must contain the following
> +   - "main": clock used to generate PWM signals
> +   - "mm": sync signals from the modules of mmsys
> +
> +Example:
> +	pwm0: pwm@1401e000 {
> +		compatible = "mediatek,mt8173-disp-pwm",
> +			     "mediatek,mt6595-disp-pwm";
> +		reg = <0 0x1401e000 0 0x1000>;
> +		#pwm-cells = <2>;
> +		clocks = <&mmsys MM_DISP_PWM026M>,
> +			 <&mmsys MM_DISP_PWM0MM>;
> +		clock-names = "main", "mm";
> +	};
