Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/1] Documentation/pwm: Update supported SoC name for pwm-samsung
Date: Sun, 10 Nov 2013 13:35:10 +0100
Message-ID: <8047745.cL4vAyf7NP@flatron>
In-Reply-To: <1383107981-6638-1-git-send-email-sachin.kamat@linaro.org>
References: <1383107981-6638-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com

Hi Sachin,

On Wednesday 30 of October 2013 10:09:41 Sachin Kamat wrote:
> Updated supported SoC name for pwm-samsung.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.txt        |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt index
> d61fccd..5538de9 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> @@ -15,7 +15,7 @@ Required properties:
>      samsung,s5pc100-pwm - for 32-bit timers present on S5PC100,
> S5PV210, Exynos4210 rev0 SoCs
>      samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
> -                          Exynos4x12 and Exynos5250 SoCs
> +                          Exynos4x12, Exynos5250 and Exynos5420 SoCs
>  - reg: base address and size of register area
>  - interrupts: list of timer interrupts (one interrupt per timer,
> starting at timer 0)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
