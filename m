From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/6] ARM: dts :exynos5422-odroidxu3 Add pwm-fan node to the
 Odroid-XU3 board.
Date: Wed, 08 Apr 2015 09:46:48 +0200
Message-ID: <20150408094648.337d3f0c@amdc2363>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-2-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1427387955-5129-2-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Anand,

> Add pwm-fan node to the OdroidXU3 board.
> 
> Tested on OdroidXU3 board.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> b/arch/arm/boot/dts/exynos5422-odroidxu3.dts index a519c86..eaec006
> 100644 --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -278,6 +278,15 @@
>  	rtc@101E0000 {
>  		status = "okay";
>  	};
> +
> +	fan0: pwm-fan {
> +		compatible = "pwm-fan";
> +		pwms = <&pwm 0 20972 0>;
> +		cooling-min-state = <0>;
> +		cooling-max-state = <3>;
> +		#cooling-cells = <2>;
> +		cooling-levels = <0 90 130 170 230>;
> +	};
>  };
>  
>  &hdmi {
> @@ -369,3 +378,10 @@
>  		shunt-resistor = <10000>;
>  	};
>  };
> +
> +&pwm {
> +	pinctrl-0 = <&pwm0_out>;
> +	pinctrl-names = "default";
> +	samsung,pwm-outputs = <0>;
> +	status = "okay";
> +};

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
