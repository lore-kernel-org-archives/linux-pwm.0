From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Fri, 19 Aug 2016 09:35:57 +0100
Message-ID: <20160819083557.GK4254@dell>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-18-lee.jones@linaro.org>
 <20160818192002.GA26225@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37809 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbcHSIe3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Aug 2016 04:34:29 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so29837336wmg.0
        for <linux-pwm@vger.kernel.org>; Fri, 19 Aug 2016 01:34:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160818192002.GA26225@rob-hp-laptop>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, 18 Aug 2016, Rob Herring wrote:

> On Tue, Aug 16, 2016 at 10:35:08AM +0100, Lee Jones wrote:
> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > be more inline with the naming conventions of the subsystem.  Where
> > we used to treat each line as a channel, the PWM convention is to
> > describe them as devices.
> 
> This is out of date now. Otherwise, the binding looks fine.

Yes, you are right.

Perhaps if this is okay with Thierry, he can remove these few lines.
If not, I don't mind re-sending on request.

I'll leave it until I hear otherwise.

> > The second documentation adaption entails adding support for PWM
> > capture devices.  A new clock is required as well as an IRQ line.
> > We're also adding a new property similar to the one described
> > above, but for capture channels.  Typically, there will be less
> > capture channels than PWM-out, since all channels have the latter
> > capability, but only some have capture support.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-st.txt | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
