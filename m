From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3 3/4] pwm: tegra: Add DT binding details to configure
 pin in suspends/resume
Date: Thu, 6 Apr 2017 16:26:16 +0100
Message-ID: <f43c83a9-8ae0-73b0-d41d-97d3bc6c253e@nvidia.com>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
 <1491488461-24621-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7499 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934532AbdDFP03 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 11:26:29 -0400
In-Reply-To: <1491488461-24621-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


On 06/04/17 15:21, Laxman Dewangan wrote:
> In some of NVIDIA Tegra's platform, PWM controller is used to
> control the PWM controlled regulators. PWM signal is connected to
> the VID pin of the regulator where duty cycle of PWM signal decide
> the voltage level of the regulator output.
> 
> The tristate (high impedance of PWM pin form Tegra) also define

s/form/from/
s/define/defines/

> one of the state of PWM regulator which needs to be configure in
> suspend state of system.

It maybe clearer to say that when the system enters suspend the
regulator requires the pwm output to be tristated.

> Add DT binding details to provide the pin configuration state
> from PWM and pinctrl DT node in suspend and active state of
> the system.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from v1:
> - Use standard pinctrl names for sleep and active state.
> 
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index b4e7377..4128cdc 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -19,6 +19,19 @@ Required properties:
>  - reset-names: Must include the following entries:
>    - pwm
>  
> +Optional properties:
> +============================
> +In some of the interface like PWM based regulator device, it is required
> +to configure the pins differently in different states, especially in suspend
> +state of the system. The configuration of pin is provided via the pinctrl
> +DT node as detailed in the pinctrl DT binding document
> +	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +
> +The PWM node will have following optional properties.
> +pinctrl-names:	Pin state names. Must be "default" and "sleep".
> +pinctrl-0:	Node handle for the default/active state of pi configurations.

s/pi/pin/
s/Node handle/phandle/

> +pinctrl-1:	Node handle for the sleep state of pin configurations.
> +
>  Example:
>  
>  	pwm: pwm@7000a000 {
> @@ -29,3 +42,33 @@ Example:
>  		resets = <&tegra_car 17>;
>  		reset-names = "pwm";
>  	};
> +
> +
> +Example with the pin configuration for suspend and resume:
> +=========================================================
> +Pin PE7 is used as PWM interface.

Nit-pick. On what devices? Sounds like this is verbatim. Maybe state
what device this is an example for.

Jon

-- 
nvpublic
