From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/2] pwm: stm32: initialize raw local variables
Date: Fri, 18 May 2018 09:56:18 -0700
Message-ID: <53e327ba-10c0-618c-edf4-1e1b528527c7@infradead.org>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>, lee.jones@linaro.org, thierry.reding@gmail.com
Cc: sfr@canb.auug.org.au, gerald.baeza@st.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 05/18/2018 08:24 AM, Fabrice Gasnier wrote:
> This removes build warning when COMPILE_TEST=y and MFD_STM32_TIMERS=n
> in drivers/pwm/pwm-stm32.c. In function 'stm32_pwm_capture' 'raw_prd' and
> 'raw_dty' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 60bfc07..09383c6 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -170,7 +170,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long long prd, div, dty;
>  	unsigned long rate;
>  	unsigned int psc = 0, icpsc, scale;
> -	u32 raw_prd, raw_dty;
> +	u32 raw_prd = 0, raw_dty = 0;
>  	int ret = 0;
>  
>  	mutex_lock(&priv->lock);
> 


-- 
~Randy
