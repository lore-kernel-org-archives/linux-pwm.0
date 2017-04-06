From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 3/4] pwm: tegra: Add DT binding details to configure pin
 in suspends/resume
Date: Thu, 6 Apr 2017 09:57:09 +0100
Message-ID: <33445b27-ae0b-b28e-afca-e7b776b4b7c0@nvidia.com>
References: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
 <1491401626-31303-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15846 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933125AbdDFJB0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 05:01:26 -0400
In-Reply-To: <1491401626-31303-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


On 05/04/17 15:13, Laxman Dewangan wrote:
> In some of NVIDIA Tegra's platform, PWM controller is used to
> control the PWM controlled regulators. PWM signal is connected to
> the VID pin of the regulator where duty cycle of PWM signal decide
> the voltage level of the regulator output.
> 
> The tristate (high impedance of PWM pin form Tegra) also define
> one of the state of PWM regulator which needs to be configure in
> suspend state of system.
> 
> Add DT binding details to provide the pin configuration state
> from PWM and pinctrl DT node in suspend and active state of
> the system.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index b4e7377..145c323 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -19,6 +19,19 @@ Required properties:
>  - reset-names: Must include the following entries:
>    - pwm
>  
> +Optional properties:
> +============================
> +In some of the interface like PWM based regualator device, it is required
> +to configure the pins diffrently in different states, specially in suspend

s/diffrently/differently
s/specially/especially

> +state of the system. The configuration of pin is provided via the pinctrl
> +DT node as detailed in the pinctrl DT binding document
> +	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +
> +The PWM node will have following optional properties.
> +pinctrl-names:	Pin state names. Must be "suspend" and "resume".

Why not just use the pre-defined names here? There is a pre-defined name
for "default", "idle" and "sleep" and then you can use the following
APIs and avoid the lookup of the state ...

pinctrl_pm_select_default_state()
pinctrl_pm_select_idle_state()
pinctrl_pm_select_sleep_state()

Note for i2c [0][1], I used "default" as the active/on state (which I
know is not that descriptive) and then used 'idle' as the suspended
state. This way we don't need any custom names.

Cheers
Jon

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-tegra.c?id=718917b9875fcfa6450e7274d2727c4680c3591a
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/nvidia/tegra210.dtsi?id=66b2d6e9c93bc5bed55afda80c84bf0325c14ad4

-- 
nvpublic
