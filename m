From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
Date: Mon, 23 Mar 2020 11:36:07 +0000
Message-ID: <1e40daf7-e5f8-7b79-cabe-8aceef6dda58@nvidia.com>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4416 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgCWLgN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 07:36:13 -0400
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sandipan Patra <spatra@nvidia.com>, treding@nvidia.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Cc: bbasu@nvidia.com, ldewangan@nvidia.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


On 05/03/2020 11:27, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
> 
> Also the maxmimum frequency is higher than earlier SoCs.
> 
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
>  drivers/pwm/pwm-tegra.c                                      | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index 0a69ead..74c41e3 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -9,6 +9,7 @@ Required properties:
>    - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
>    - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
>    - "nvidia,tegra186-pwm": for Tegra186
> +  - "nvidia,tegra194-pwm": for Tegra194
>  - reg: physical base address and length of the controller's registers
>  - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
>    the cells format.
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index aa12fb3..d26ed8f 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -282,9 +282,15 @@ static const struct tegra_pwm_soc tegra186_pwm_soc = {
>  	.max_frequency = 102000000UL,
>  };
>  
> +static const struct tegra_pwm_soc tegra194_pwm_soc = {
> +	.num_channels = 1,
> +	.max_frequency = 408000000UL,
> +};
> +
>  static const struct of_device_id tegra_pwm_of_match[] = {
>  	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
>  	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
> +	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
> 


Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
