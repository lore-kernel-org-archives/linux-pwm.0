From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V1 2/2] pwm: pwm-qti-lpg: Add PWM driver for QTI LPG
 module
Date: Wed, 7 Jun 2017 16:19:42 -0500
Message-ID: <20170607211942.o3lddk7waowobpgt@rob-hp-laptop>
References: <20170531061541.10808-1-fenglinw@codeaurora.org>
 <20170531061541.10808-3-fenglinw@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170531061541.10808-3-fenglinw@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: fenglinw@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, subbaram@quicinc.com, aghayal@qti.qualcomm.com, wruan@quicinc.com, kgunda@qti.qualcomm.com
List-Id: linux-pwm@vger.kernel.org

On Wed, May 31, 2017 at 02:14:38PM +0800, fenglinw@codeaurora.org wrote:
> From: Fenglin Wu <fenglinw@codeaurora.org>
> 
> Add pwm_chip to support QTI LPG module and export LPG channels as
> PWM devices for consumer drivers' usage.
> 
> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> ---
>  .../devicetree/bindings/pwm/pwm-qti-lpg.txt        |  39 ++

Please put binding in a separate patch.

>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-qti-lpg.c                          | 578 +++++++++++++++++++++
>  4 files changed, 628 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt
>  create mode 100644 drivers/pwm/pwm-qti-lpg.c
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt b/Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt
> new file mode 100644
> index 0000000..df81f5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt
> @@ -0,0 +1,39 @@
> +Qualcomm Technologies, Inc. LPG driver specific bindings
> +
> +This binding document describes the properties of LPG (Light Pulse Generator)
> +device module in Qualcomm Technologies, Inc. PMIC chips.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Must be "qcom,pwm-lpg".

Needs SoC specific compatible strings.

> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Register base and length for LPG modules. The length
> +		      varies based on the number of channels available in
> +		      the PMIC chips.
> +
> +- reg-names:
> +	Usage: required
> +	Value type: <string>
> +	Definition: The name of the register defined in the reg property.
> +		      It must be "lpg-base".

-names is pointless when there is only 1.

> +
> +- #pwm-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: The number of cells in "pwms" property specified in
> +		      PWM user nodes. It should be 2. The first cell is
> +		      the PWM channel ID indexed from 0, and the second
> +		      cell is the PWM default period in nanoseconds.
> +
> +Example:
> +
> +	pmi8998_lpg: lpg@b100 {
> +		compatible = "qcom,pwm-lpg";
> +		reg = <0xb100 0x600>;
> +		reg-names = "lpg-base";
> +		#pwm-cells = <2>;
> +	};
