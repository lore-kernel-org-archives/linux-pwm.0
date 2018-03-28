From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v2 0/8] Add support for PWM input capture on STM32
Date: Wed, 28 Mar 2018 11:03:09 +0100
Message-ID: <20180328100309.yig4d3bmml6jvodz@dell>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
 <20180327225101.GJ28163@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327225101.GJ28163@mithrandir>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, alexandre.torgue@st.com, benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 28 Mar 2018, Thierry Reding wrote:

> On Wed, Feb 14, 2018 at 11:04:31AM +0100, Fabrice Gasnier wrote:
> > This series adds support for capture to stm32-pwm driver.
> > Capture is based on DMAs.
> > - First two patches are precursor patches
> > - Subsequent two patches add support for requesting DMAs to MFD core
> > - Next three patches add support for capture to stm32-pwm driver
> > - This has been tested on stm32429i-eval board.
> > 
> > ---
> > Resend v2:
> > - Add collected Acks
> > 
> > Changes in v2:
> > - Abstract DMA handling from child driver: move it to MFD core
> > - Rework pwm capture routines to adopt this change
> > - Comment on optional dma support, beautify DMAs probe
> > 
> > Fabrice Gasnier (8):
> >   pwm: stm32: fix, remove unused struct device
> >   pwm: stm32: protect common prescaler for all channels
> >   dt-bindings: mfd: stm32-timers: add support for dmas
> >   mfd: stm32-timers: add support for dmas
> >   pwm: stm32: add capture support
> >   pwm: stm32: improve capture by tuning counter prescaler
> >   pwm: stm32: use input prescaler to improve period capture
> >   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
> > 
> >  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
> >  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
> >  drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
> >  drivers/pwm/pwm-stm32.c                            | 276 ++++++++++++++++++++-
> >  include/linux/mfd/stm32-timers.h                   |  39 +++
> >  5 files changed, 547 insertions(+), 6 deletions(-)
> 
> I can't apply patches 1-2 and 5-6 since they depend on patches 3-4 for
> which I'd need an Acked-by: from Lee if I'm to pick them up. Same goes
> for patch 7.
> 
> By the looks of it there are minor conflicts with the MFD tree, but no
> major ones. Perhaps it'd be better for Lee to pick up 3-4 for v4.17-rc1
> and ack patch 7, then I can take the rest after v4.17-rc1?

Sounds like a faff.

Why don't I just pick them all up (except the ARM patch)?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
