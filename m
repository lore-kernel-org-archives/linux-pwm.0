From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: stm32: enforce dependency on CONFIG_MFD_STM32_TIMERS
Date: Thu, 7 Jun 2018 06:08:00 +0100
Message-ID: <20180607050800.GD21163@dell>
References: <20180525160523.29124-1-arnd@arndb.de>
 <20180606081314.GC11810@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606081314.GC11810@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Gaignard <benjamin.gaignard@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 06 Jun 2018, Thierry Reding wrote:

> On Fri, May 25, 2018 at 06:04:54PM +0200, Arnd Bergmann wrote:
> > When compile-testing the pwm driver without also enabling the
> > stm32_timers MFD, we run into a link error:
> > 
> > drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.6':
> > pwm-stm32.c:(.text+0xcb0): undefined reference to `stm32_timers_dma_burst_read'
> > 
> > We don't need the '|| COMPILE_TEST' here, since stm32_timers itself
> > can be built with CONFIG_COMPILE_TEST on all architectures, so we do
> > get the coverage through allmodconfig and randconfig builds even
> > when we make it a hard dependency.
> > 
> > Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/pwm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I think Lee already picked up a patch by Fabrice that fixes this by
> adding a dummy implementation, see:
> 
> 	http://patchwork.ozlabs.org/patch/916435/
> 
> I prefer your solution, though, because the dummy is pretty redundant if
> we can just make this a hard-dependency and still get the same coverage.

The two patches aren't mutually exclusive. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
