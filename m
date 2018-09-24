Return-Path: <robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
Message-ID: <5baa1af9.1c69fb81.73ad9.3bd5@mx.google.com>
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: msm-vibrator: new bindings for MSM
 vibrator driver
References: <20180919150912.8948-1-masneyb@onstation.org>
 <20180919150912.8948-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919150912.8948-2-masneyb@onstation.org>
Date: Mon, 24 Sep 2018 15:01:11 -0700
List-ID: <linux-pwm.vger.kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk

On Wed, Sep 19, 2018 at 11:09:10AM -0400, Brian Masney wrote:
> This patch adds the device tree bindings for the pwm-msm-vibrator.c
> driver that supports the vibrator found on various Qualcomm MSM SOCs.

Bindings are for h/w, not some driver.

> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../bindings/pwm/pwm-msm-vibrator.txt         | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt b/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
> new file mode 100644
> index 000000000000..4638a25345f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
> @@ -0,0 +1,38 @@
> +* PWM driver for the vibrator found on various MSM SOCs.

driver?

> +
> +Required properties:
> +
> +  - compatible: Should be one of
> +		"qcom,msm8226-pwm-vibrator"
> +		"qcom,msm8974-pwm-vibrator"

The block only works for a vibrator?

> +  - reg: the base address and length of the IO memory for the registers.
> +  - #pwm-cells: set to 3.
> +  - pinctrl-names: set to default.
> +  - pinctrl-0: phandles pointing to pin configuration nodes. See
> +               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +  - clock-names: set to pwm
> +  - clocks: phandle of the clock used by the PWM module. See
> +            Documentation/devicetree/bindings/clock/clock-bindings.txt
> +  - enable-gpios: GPIO that enables the vibrator.

Shouldn't this go in the vibrator node as it is connected to the 
vibrator.

> +
> +Optional properties:
> +
> +  - vcc-supply: phandle to the regulator that provides power to the sensor.
> +
> +Example from a LG Nexus 5 (hammerhead) phone:
> +
> +msm_pwm_vibrator_enable: msm_pwm_vibrator@fd8c3450 {

pwm@...

> +	reg = <0xfd8c3450 0x400>;
> +	compatible = "qcom,msm8974-pwm-vibrator";
> +	#pwm-cells = <3>;
> +
> +	vcc-supply = <&pm8941_l19>;
> +
> +	clocks = <&mmcc CAMSS_GP1_CLK>;
> +	clock-names = "pwm";
> +
> +	enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&vibrator_pin>;
> +};
> -- 
> 2.17.1
> 
