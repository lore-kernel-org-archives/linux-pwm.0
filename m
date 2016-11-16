From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Thu, 17 Nov 2016 01:55:49 +0200
Message-ID: <664f5d9b-ebf4-d511-8e59-2f57c00ea901@mleia.com>
References: <1479289833-232200-1-git-send-email-yuanjian12@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479289833-232200-1-git-send-email-yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kevin.lixu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, jalen.hsu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On 11/16/2016 11:50 AM, Jian Yuan wrote:
> From: yuanjian <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>
> Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like Hi3519V100, Hi3516CV300, etc.
> The PWM controller is primarily in charge of controlling P-Iris lens.
>
> Reviewed-by: Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> Signed-off-by: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> ---
> Change Log:
> v5:
> remove the generic compatible string "hisilicon, hibvt-pwm".
> v4:
> Add #pwm-cells in the bindings document.
> v3:
> fixed issues pointed by thierry.
> Add PWM compatible string for Hi3519V100.
> Implement .apply() function which support atomic, instead of .enable()/.disable()/.config().
> v2:
> The number of PWMs is change to be probeable based on the compatible string.
>
>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  22 ++
>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-hibvt.c                            | 269 +++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>  create mode 100644 drivers/pwm/pwm-hibvt.c
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> new file mode 100644
> index 0000000..fe63950
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> @@ -0,0 +1,22 @@
> +Hisilicon PWM controller
> +
> +Required properties:
> +-compatible: should contain one SoC specific compatible string
> + The SoC specific strings supported including:
> +	"hisilicon,hi3516cv300-pwm"
> +	"hisilicon,hi3519v100-pwm"
> +- reg: physical base address and length of the controller's registers.
> +- clocks: phandle and clock specifier of the PWM reference clock.
> +- resets: phandle and reset specifier for the PWM controller reset.
> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of

Since the controller has separate polarity control register, and
the driver handles polarity settings, please test/change #pwm-cells
set to 3. It is better to do it right now before someone wants
to change number of cells in future and support polarity specified
in DTB.

> +  the cells format.
> +
> +Example:
> +	pwm: pwm@12130000 {
> +

Remove empty line above.

> +		compatible = "hisilicon,hi3516cv300-pwm";
> +		reg = <0x12130000 0x10000>;
> +		clocks = <&crg_ctrl HI3516CV300_PWM_CLK>;
> +		resets = <&crg_ctrl 0x38 0>;
> +		#pwm-cells = <2>;

After tesing #pwm-cells = <3> don't forget to updated this line.

> +	};

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
