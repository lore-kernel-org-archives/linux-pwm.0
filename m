From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: add dsi node
Date: Fri, 19 Apr 2019 15:36:48 +0800
Message-ID: <1555659408.7529.0.camel@mtksdaap41>
References: <20190416085446.84071-1-jitao.shi@mediatek.com>
 <20190416085446.84071-2-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190416085446.84071-2-jitao.shi@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Phi
List-Id: linux-pwm@vger.kernel.org

Hi, Jitao:

On Tue, 2019-04-16 at 16:54 +0800, Jitao Shi wrote:
> Add dsi and mipitx nodes to the mt8183
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index b36e37fcdfe3..80929a0e5a6f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -353,6 +353,16 @@
>  			status = "disabled";
>  		};
>  
> +		mipi_tx0: mipi-dphy@11e50000 {
> +			compatible = "mediatek,mt8183-mipi-tx";
> +			reg = <0 0x11e50000 0 0x1000>;
> +			clocks = <&apmixedsys CLK_APMIXED_MIPID0_26M>;
> +			clock-names = "ref_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +			clock-output-names = "mipi_tx0_pll";
> +		};
> +
>  		mfgcfg: syscon@13000000 {
>  			compatible = "mediatek,mt8183-mfgcfg", "syscon";
>  			reg = <0 0x13000000 0 0x1000>;
> @@ -365,6 +375,21 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		dsi0: dsi@14014000 {
> +			compatible = "mediatek,mt8173-dsi",
> +				"mediatek,mt8183-dsi";

I think you could directly remove "mediatek,mt8173-dsi".

Regards,
CK

> +			reg = <0 0x14014000 0 0x1000>;
> +			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			mediatek,syscon-dsi = <&mmsys 0x140>;
> +			clocks = <&mmsys CLK_MM_DSI0_MM>,
> +				<&mmsys CLK_MM_DSI0_IF>,
> +				<&mipi_tx0>;
> +			clock-names = "engine", "digital", "hs";
> +			phys = <&mipi_tx0>;
> +			phy-names = "dphy";
> +		};
> +
>  		smi_common: smi@14019000 {
>  			compatible = "mediatek,mt8183-smi-common", "syscon";
>  			reg = <0 0x14019000 0 0x1000>;
