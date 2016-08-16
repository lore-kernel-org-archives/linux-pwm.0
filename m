From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] pwm: samsung: fix to use lowest div for large enough
 modulation bits
Date: Tue, 16 Aug 2016 18:25:25 +0200
Message-ID: <20160816162525.GA9249@kozik-lap>
References: <1470133006-4272-1-git-send-email-sw0312.kim@samsung.com>
 <20160816142201.12672-1-sw0312.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816142201.12672-1-sw0312.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, k.kozlowski@samsung.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, tomasz.figa@gmail.com, jy0922.shim@samsung.com, krzk@kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 16, 2016 at 11:22:01PM +0900, Seung-Woo Kim wrote:
> From pwm_samsung_calc_tin(), there is routine to find the lowest
> divider possible to generate lower frequency than requested one.
> But it is always possible to generate requested frequency with
> large enough modulation bits except s3c24xx, so this patch fixes
> to use lowest div for the case. This patch removes following UBSAN
> warning:
> 
>    UBSAN: Undefined behaviour in drivers/pwm/pwm-samsung.c:197:13
>    shift exponent 32 is too large for 32-bit type 'long unsigned int'
>    [...]
>    [<c0670248>] (ubsan_epilogue) from [<c06707b4>] (__ubsan_handle_shift_out_of_bounds+0xd8/0x120)
>    [<c06707b4>] (__ubsan_handle_shift_out_of_bounds) from [<c0694b28>] (pwm_samsung_config+0x508/0x6a4)
>    [<c0694b28>] (pwm_samsung_config) from [<c069286c>] (pwm_apply_state+0x174/0x40c)
>    [<c069286c>] (pwm_apply_state) from [<c0b2e070>] (pwm_fan_probe+0xc8/0x488)
>    [<c0b2e070>] (pwm_fan_probe) from [<c07ba8b0>] (platform_drv_probe+0x70/0x150)
>    [...]
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
> Changes from v1
>  * Remove too complex condition, instead, just checking simple variant->bits as Krzysztof's suggestion
>  * Add comment from Tomasz
> 
> The UBSAN warning from ARM is reported with the patch in following link:
> https://patchwork.kernel.org/patch/9189575/
> ---
>  drivers/pwm/pwm-samsung.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
