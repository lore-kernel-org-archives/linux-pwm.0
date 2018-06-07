From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
Date: Thu, 7 Jun 2018 06:06:52 +0100
Message-ID: <20180607050652.GC21163@dell>
References: <20180525210843.1821071-1-arnd@arndb.de>
 <20180606081827.GD11810@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606081827.GD11810@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 06 Jun 2018, Thierry Reding wrote:

> On Fri, May 25, 2018 at 11:08:30PM +0200, Arnd Bergmann wrote:
> > Without dmaengine support, we get a harmless warning about an
> > unused function:
> > 
> > drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]
> > 
> > Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> > and is slightly nicer to read.
> > 
> > Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/pwm/pwm-stm32.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Applied, thanks.
> 
> Lee, I applied this on top of your immutable MFD/PWM branch because it
> depends on the capture support that you applied. I wasn't sure what your
> PR timing was going to be, so I thought I'd do it this way since I'm
> pulling in some last minute fixes for v4.18.

I don't see a problem with that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
