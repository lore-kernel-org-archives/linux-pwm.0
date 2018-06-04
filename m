From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: stm32-timers: fix pwm-stm32 linker issue with
 COMPILE_TEST
Date: Mon, 4 Jun 2018 07:13:02 +0100
Message-ID: <20180604061302.GD25455@dell>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, rdunlap@infradead.org, sfr@canb.auug.org.au, gerald.baeza@st.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 18 May 2018, Fabrice Gasnier wrote:

> This is seen when COMPILE_TEST=y and MFD_STM32_TIMERS=n.
> drivers/pwm/pwm-stm32.o: In function 'stm32_pwm_raw_capture':
> pwm-stm32.c:... undefined reference to 'stm32_timers_dma_burst_read'
> Fixes: 0c6609805b63 ("mfd: stm32-timers: Add support for DMAs")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  include/linux/mfd/stm32-timers.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
