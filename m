From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Mon, 1 Aug 2016 13:43:55 +0100
Message-ID: <20160801124355.GB13179@leverpostej>
References: <1470015728-36979-1-git-send-email-yuanjian12@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33671 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbcHAMqQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 1 Aug 2016 08:46:16 -0400
Content-Disposition: inline
In-Reply-To: <1470015728-36979-1-git-send-email-yuanjian12@hisilicon.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jian Yuan <yuanjian12@hisilicon.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 01, 2016 at 09:42:08AM +0800, Jian Yuan wrote:
> From: yuanjian <yuanjian12@hisilicon.com>
> 
> Add pwm driver for HiSilicon BVT SOCs
> 
> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
> ---
>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  18 ++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-hibvt.c                            | 272 +++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>  create mode 100644 drivers/pwm/pwm-hibvt.c
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> new file mode 100644
> index 0000000..4efd83e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> @@ -0,0 +1,18 @@
> +Hisilicon PWM controller
> +
> +Required properties:
> + - compatible: should be "hisilicon,hibvt-pwm" and one of the following:
> +			"hisilicon,hi3516cv300-pwm".

I take it "hisilicon,hibvt-pwm" is the fallback entry.

It would be good to note that explicitly.

> + - reg: physical base address and length of the controller's registers.
> + - clocks: phandle and clock specifier of the PWM reference clock.
> + - resets: offset address and offset bit for reset or unreset of the controller.
> + - pwm-nums: pwm number of the controller.

This should be 'num-pwms'.

I assume this is the number of PWMs exposed by this controller. Is this
not probeable, or dicoverable based on the compatible string?

How does this vary in practice?

> +
> +Example:
> +	pwm: pwm@12130000 {
> +		compatible = "hisilicon,hibvt-pwm";

This is missing "hisilicon,hi3516cv300-pwm" as per the requirements of
the binding.

> +		reg = <0x12130000 0x10000>;
> +		clocks = <&crg_ctrl HI3516CV300_PWM_CLK>;
> +		resets = <&crg_ctrl 0x38 0>;
> +		pwm-nums = <4>;
> +	};

Thanks,
Mark.
