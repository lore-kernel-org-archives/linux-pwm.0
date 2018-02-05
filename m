From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: mfd: stm32-timers: add support for
 dmas
Date: Mon, 5 Feb 2018 00:07:20 -0600
Message-ID: <20180205060720.v3sfw44orngsyltq@rob-hp-laptop>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
 <1516979499-3665-4-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37358 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeBEGHW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Feb 2018 01:07:22 -0500
Content-Disposition: inline
In-Reply-To: <1516979499-3665-4-git-send-email-fabrice.gasnier@st.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, thierry.reding@gmail.com, alexandre.torgue@st.com, benjamin.gaignard@linaro.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Fri, Jan 26, 2018 at 04:11:34PM +0100, Fabrice Gasnier wrote:
> Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
> dma requests: up to 4 channels, update, compare and trigger.
> DMAs may be used to transfer data from pwm capture for instance.
> DMA support is made optional, PWM capture support is also an option.
> This is much more wise system-wide to avoid shortage on DMA request
> lines as there's significant amount of timer instances that can
> request up to 7 channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
