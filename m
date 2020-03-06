From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
Date: Fri, 6 Mar 2020 14:33:02 +0530
Message-ID: <cc4daacd-c9fb-8057-dad3-7411476e4757@nvidia.com>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sandipan Patra <spatra@nvidia.com>, treding@nvidia.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, jonathanh@nvidia.com
Cc: bbasu@nvidia.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org



On Thursday 05 March 2020 04:57 PM, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
>
> Also the maxmimum frequency is higher than earlier SoCs.
>
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
>
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>   Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
>   drivers/pwm/pwm-tegra.c                                      | 6 ++++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index 0a69ead..74c41e3 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -9,6 +9,7 @@ Required properties:
>     - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
>     - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
>     - "nvidia,tegra186-pwm": for Tegra186
> +  - "nvidia,tegra194-pwm": for Tegra194
>   - reg: physical base address and length of the controller's registers
>   - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
>     the cells format.
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
