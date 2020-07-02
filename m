From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: exynos: Remove DMA controller bus node
 name to fix dtschema warnings
Date: Thu, 2 Jul 2020 22:34:14 +0200
Message-ID: <11b9adcf-251f-81ad-2559-9d96c0a3ad78@samsung.com>
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155216eucas1p2424c5998e09d73e3b758e4cd8ba27157@eucas1p2.samsung.com>
        <20200702155149.12854-5-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53948 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUeU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2020 16:34:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702203417euoutp0160e06596ce4ff62fbf647c874d4e4783~eCcR_PQMR0733307333euoutp01X
        for <linux-pwm@vger.kernel.org>; Thu,  2 Jul 2020 20:34:17 +0000 (GMT)
In-Reply-To: <20200702155149.12854-5-krzk@kernel.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>

On 02.07.2020 17:51, Krzysztof Kozlowski wrote:
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
>
>      amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Remove the bus, as suggested by Marek
> ---
>   arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
>   arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
>   .../boot/dts/exynos4210-universal_c210.dts    |   2 +-
>   arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
>   arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
>   arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
>   6 files changed, 174 insertions(+), 213 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 044e5da64a76..d3fb45a56527 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -418,33 +418,26 @@
>   			status = "disabled";
>   		};
>   
> -		amba {
> -			compatible = "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges;
> -
> -			pdma0: pdma@12680000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12680000 0x1000>;
> -				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cmu CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@12690000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12690000 0x1000>;
> -				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cmu CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma0: pdma@12680000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12680000 0x1000>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@12690000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12690000 0x1000>;
> +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>   		};
>   
>   		adc: adc@126c0000 {
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index d2779a790ce3..a1e54449f33f 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -669,45 +669,37 @@
>   			status = "disabled";
>   		};
>   
> -		amba: amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@12680000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12680000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@12690000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12690000 0x1000>;
> -				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma1: mdma@12850000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12850000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		pdma0: pdma@12680000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12680000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@12690000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12690000 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma1: mdma@12850000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12850000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>   		};
>   
>   		fimd: fimd@11c00000 {
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 02fde1a75ebd..e07aa3aa93bd 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -181,7 +181,7 @@
>   	};
>   };
>   
> -&amba {
> +&soc {


What about the alphabetical order of the labels here?


>   	mdma0: mdma@12840000 {
>   		compatible = "arm,pl330", "arm,primecell";
>   		reg = <0x12840000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index b6135af7ef39..e3dbe4166836 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -679,56 +679,48 @@
>   			samsung,pmureg-phandle = <&pmu_system_controller>;
>   		};
>   
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121A0000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121B0000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma0: mdma@10800000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x10800000 0x1000>;
> -				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> -
> -			mdma1: mdma@11c10000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x11C10000 0x1000>;
> -				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma@10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma@11c10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>   		};
>   
>   		gsc_0:  gsc@13e00000 {
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 2eab80bf5f3a..abe75b9e39f5 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -189,34 +189,26 @@
>   			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121a0000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121a0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
>   
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121b0000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121b0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>   		};
>   
>   		audi2s0: i2s@3830000 {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index b672080e7469..c76460b70532 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -433,76 +433,68 @@
>   			power-domains = <&mau_pd>;
>   		};
>   
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			adma: adma@3880000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x03880000 0x1000>;
> -				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock_audss EXYNOS_ADMA>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <6>;
> -				#dma-requests = <16>;
> -				power-domains = <&mau_pd>;
> -			};
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121A0000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121B0000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma0: mdma@10800000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x10800000 0x1000>;
> -				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		adma: adma@3880000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x03880000 0x1000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock_audss EXYNOS_ADMA>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <6>;
> +			#dma-requests = <16>;
> +			power-domains = <&mau_pd>;
> +		};
>   
> -			mdma1: mdma@11c10000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x11C10000 0x1000>;
> -				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -				/*
> -				 * MDMA1 can support both secure and non-secure
> -				 * AXI transactions. When this is enabled in
> -				 * the kernel for boards that run in secure
> -				 * mode, we are getting imprecise external
> -				 * aborts causing the kernel to oops.
> -				 */
> -				status = "disabled";
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma@10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma@11c10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +			/*
> +			 * MDMA1 can support both secure and non-secure
> +			 * AXI transactions. When this is enabled in
> +			 * the kernel for boards that run in secure
> +			 * mode, we are getting imprecise external
> +			 * aborts causing the kernel to oops.
> +			 */
> +			status = "disabled";
>   		};
>   
>   		i2s0: i2s@3830000 {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
