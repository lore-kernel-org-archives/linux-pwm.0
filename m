From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 14/18] drivers/clocksource: timer-fsl-ftm: use common
 header for FlexTimer #defines
Date: Thu, 25 Apr 2019 23:41:34 +0200
Message-ID: <95ce444a-2f10-ec89-cb13-578349511f6b@linaro.org>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>, gregkh@linuxfoundation.org
Cc: jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com
List-Id: linux-pwm@vger.kernel.org

On 02/04/2019 08:30, William Breathitt Gray wrote:
> From: Patrick Havelange <patrick.havelange@essensium.com>
> 
> Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
> this file.
> Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.
> 
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Please, do pick my Acked-by from V2.

> ---
>  drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
> index 846d18daf893..e1c34b2f53a5 100644
> --- a/drivers/clocksource/timer-fsl-ftm.c
> +++ b/drivers/clocksource/timer-fsl-ftm.c
> @@ -19,20 +19,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/slab.h>
> +#include <linux/fsl/ftm.h>
>  
> -#define FTM_SC		0x00
> -#define FTM_SC_CLK_SHIFT	3
> -#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_PS_MASK	0x7
> -#define FTM_SC_TOIE	BIT(6)
> -#define FTM_SC_TOF	BIT(7)
> -
> -#define FTM_CNT		0x04
> -#define FTM_MOD		0x08
> -#define FTM_CNTIN	0x4C
> -
> -#define FTM_PS_MAX	7
> +#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
>  
>  struct ftm_clock_device {
>  	void __iomem *clksrc_base;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
