From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: stm32-timers: add support for
 dmas
Date: Mon, 16 Apr 2018 13:23:32 +0100
Message-ID: <20180416122332.jkshovyzejd6koo6@dell>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-2-git-send-email-fabrice.gasnier@st.com>
 <20180416122306.qfp5rf7khexabydm@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180416122306.qfp5rf7khexabydm@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com, benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 16 Apr 2018, Lee Jones wrote:

> On Fri, 30 Mar 2018, Fabrice Gasnier wrote:
> 
> > Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
> > dma requests: up to 4 channels, update, compare and trigger.
> > DMAs may be used to transfer data from pwm capture for instance.
> > DMA support is made optional, PWM capture support is also an option.
> > This is much more wise system-wide to avoid shortage on DMA request
> > lines as there's significant amount of timer instances that can
> > request up to 7 channels.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > ---
> >  .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Actually:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
