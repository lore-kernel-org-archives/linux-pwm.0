From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/6] ARM:dts exynos5422 Update the thermal sensor for
 tmu_cpu0
Date: Wed, 08 Apr 2015 10:02:40 +0200
Message-ID: <20150408100240.7f597dae@amdc2363>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-4-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1427387955-5129-4-git-send-email-linux.amoon@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Anand,

> Move the registration of thermal sensors for tmu_cpu0 from
> exynos5420.dtsi to exynos5-cpu-thermal.dtsi, to avoid duplicate
> registration of the sensors.
> 
> Tested on OdroidXU3 board.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5-cpu-thermal.dtsi | 58
> ++++++++++++++++++++++++++++++
> arch/arm/boot/dts/exynos5420.dtsi          |  4 ---
> arch/arm/boot/dts/exynos5422-odroidxu3.dts |  1 + 3 files changed, 59
> insertions(+), 4 deletions(-) create mode 100644
> arch/arm/boot/dts/exynos5-cpu-thermal.dtsi
> 
> diff --git a/arch/arm/boot/dts/exynos5-cpu-thermal.dtsi
> b/arch/arm/boot/dts/exynos5-cpu-thermal.dtsi new file mode 100644
> index 0000000..8fede70
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5-cpu-thermal.dtsi
> @@ -0,0 +1,58 @@
> +/*
> + * Device tree sources for Exynos5 thermal zone
> + *
> + * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>

			^^^^^^^^^^^^^^^^ Could you update this
			line :-). I'm just reviewer here :-)

> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	thermal-zones {
> +		cpu0_thermal: cpu0-thermal {
> +			thermal-sensors = <&tmu_cpu0>;
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			trips {
> +				cpu_alert0: cpu-alert-0 {
> +					temperature = <48000>; /* ms
> */
> +					hysteresis = <3000>; /* ms */
							    ^^^^^^^^^
							We already have
							"millicelsius"
							instead od ms
> +					type = "active";
> +				};
> +				cpu_alert1: cpu-alert-1 {
> +					temperature = <53000>; /* ms
> */
> +					hysteresis = <3000>; /* ms */
> +					type = "active";
> +				};
> +				cpu_alert2: cpu-alert-2 {
> +					temperature = <59000>; /* ms
> */
> +					hysteresis = <3000>; /* ms */
> +					type = "active";
> +				};
> +				cpu_crit0: cpu-crit-0 {
> +					temperature = <75000>; /* ms
> */
> +					hysteresis = <0>; /* ms */
> +					type = "critical";

		Is there any special reasons why we need special values
		for cpu0_thermal sensor at XU3? Is something wrong with
		default values defined at exynos4-cpu-thermal.dtsi?

		If this is Odroid XU3 specific, then IMHO it should be
		added to exynos5422-odroidxu3.dts

> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +				     trip = <&cpu_alert0>;
> +				     cooling-device = <&fan0 0 1>;
> +				};
> +				map1 {
> +				     trip = <&cpu_alert1>;
> +				     cooling-device = <&fan0 1 2>;
> +				};
> +				map2 {
> +				     trip = <&cpu_alert2>;
> +				     cooling-device = <&fan0 2 3>;
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi index 6b49f3c..eb0f16c 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -827,10 +827,6 @@
>  	};
>  
>  	thermal-zones {
> -		cpu0_thermal: cpu0-thermal {
> -			thermal-sensors = <&tmu_cpu0>;
> -			#include "exynos5420-trip-points.dtsi"
			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [1]

> -		};
>  		cpu1_thermal: cpu1-thermal {
>  		       thermal-sensors = <&tmu_cpu1>;
>  		       #include "exynos5420-trip-points.dtsi"
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> b/arch/arm/boot/dts/exynos5422-odroidxu3.dts index eaec006..c8b3e3e
> 100644 --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -12,6 +12,7 @@
>  
>  /dts-v1/;
>  #include "exynos5800.dtsi"
> +#include "exynos5-cpu-thermal.dtsi"

I would prefer to stick to convention proposed at [1]. It keeps
the locality of the include with respective thermal zone.

>  
>  / {
>  	model = "Hardkernel Odroid XU3";

DTS changes should be added to Samsung tree by Samsung maintainer - Mr.
Kukjin Kim.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
