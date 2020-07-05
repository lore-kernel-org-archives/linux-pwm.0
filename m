From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 5/8] ARM: dts: exynos: Remove DMA controller bus node
 name to fix dtschema warnings
Date: Sun, 5 Jul 2020 20:13:11 +0200
Message-ID: <20200705181311.GA3611@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <CGME20200702155216eucas1p2424c5998e09d73e3b758e4cd8ba27157@eucas1p2.samsung.com>
 <20200702155149.12854-5-krzk@kernel.org>
 <11b9adcf-251f-81ad-2559-9d96c0a3ad78@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11b9adcf-251f-81ad-2559-9d96c0a3ad78@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jul 02, 2020 at 10:34:14PM +0200, Marek Szyprowski wrote:
> On 02.07.2020 17:51, Krzysztof Kozlowski wrote:
> > There is no need to keep DMA controller nodes under AMBA bus node.
> > Remove the "amba" node to fix dtschema warnings like:
> >
> >      amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Remove the bus, as suggested by Marek
> > ---
> >   arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
> >   arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
> >   .../boot/dts/exynos4210-universal_c210.dts    |   2 +-
> >   arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
> >   arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
> >   arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
> >   6 files changed, 174 insertions(+), 213 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> > index 044e5da64a76..d3fb45a56527 100644
> > --- a/arch/arm/boot/dts/exynos3250.dtsi
> > +++ b/arch/arm/boot/dts/exynos3250.dtsi
> > @@ -418,33 +418,26 @@
> >   			status = "disabled";
> >   		};
> >   
> > -		amba {
> > -			compatible = "simple-bus";
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			ranges;
> > -
> > -			pdma0: pdma@12680000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12680000 0x1000>;
> > -				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&cmu CLK_PDMA0>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > -
> > -			pdma1: pdma@12690000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12690000 0x1000>;
> > -				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&cmu CLK_PDMA1>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > +		pdma0: pdma@12680000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12680000 0x1000>;
> > +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_PDMA0>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> > +		};
> > +
> > +		pdma1: pdma@12690000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12690000 0x1000>;
> > +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_PDMA1>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> >   		};
> >   
> >   		adc: adc@126c0000 {
> > diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> > index d2779a790ce3..a1e54449f33f 100644
> > --- a/arch/arm/boot/dts/exynos4.dtsi
> > +++ b/arch/arm/boot/dts/exynos4.dtsi
> > @@ -669,45 +669,37 @@
> >   			status = "disabled";
> >   		};
> >   
> > -		amba: amba {
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			compatible = "simple-bus";
> > -			interrupt-parent = <&gic>;
> > -			ranges;
> > -
> > -			pdma0: pdma@12680000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12680000 0x1000>;
> > -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clock CLK_PDMA0>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > -
> > -			pdma1: pdma@12690000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12690000 0x1000>;
> > -				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clock CLK_PDMA1>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > -
> > -			mdma1: mdma@12850000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12850000 0x1000>;
> > -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clock CLK_MDMA>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <1>;
> > -			};
> > +		pdma0: pdma@12680000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12680000 0x1000>;
> > +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clock CLK_PDMA0>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> > +		};
> > +
> > +		pdma1: pdma@12690000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12690000 0x1000>;
> > +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clock CLK_PDMA1>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> > +		};
> > +
> > +		mdma1: mdma@12850000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12850000 0x1000>;
> > +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clock CLK_MDMA>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <1>;
> >   		};
> >   
> >   		fimd: fimd@11c00000 {
> > diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > index 02fde1a75ebd..e07aa3aa93bd 100644
> > --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > @@ -181,7 +181,7 @@
> >   	};
> >   };
> >   
> > -&amba {
> > +&soc {
> 
> 
> What about the alphabetical order of the labels here?

Yes, I'll keep them ordered. Thanks.

Best regards,
Krzysztof
