From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 2/6] ARM: dts exynos5420 update the cooling cells for core
 cpu0
Date: Wed, 08 Apr 2015 09:47:37 +0200
Message-ID: <20150408094737.3fddcee4@amdc2363>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-3-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1427387955-5129-3-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Anand,

> update the cooling level for cpu0 to avoid following message.
> 
> root@odroidxu3:~# dmesg | grep ther
> [    0.241511] /thermal-zones/cpu-thermal/cooling-maps/map0:
> 			 could not get #cooling-cells for /cpus/cpu@0
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi index c0e98cf..6b49f3c 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -61,6 +61,10 @@
>  			reg = <0x0>;
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
> +
> +			cooling-min-level = <10>;
> +			cooling-max-level = <7>;
> +			#cooling-cells = <2>; /* min followed by max
> */ };
>  
>  		cpu1: cpu@1 {

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
