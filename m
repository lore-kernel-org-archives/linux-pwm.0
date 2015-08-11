From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v2 4/5] ARM: berlin: add a PWM node on the BG2
Date: Tue, 11 Aug 2015 10:46:50 +0800
Message-ID: <20150811104650.0e19ba41@xhacker>
References: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
	<1438248201-29222-5-git-send-email-antoine.tenart@free-electrons.com>
	<55C900D0.9060606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61589 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932991AbbHKCur (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Aug 2015 22:50:47 -0400
In-Reply-To: <55C900D0.9060606@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, thierry.reding@gmail.com, zmxu@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Dear Sebastian,

On Mon, 10 Aug 2015 21:51:44 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 30.07.2015 11:23, Antoine Tenart wrote:
> > This patch adds a PWM node in the Berlin BG2 device tree, using the
> > newly added Berlin PWM driver.
> >
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >   arch/arm/boot/dts/berlin2.dtsi | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> > index ef811de09908..e17bd5faed27 100644
> > --- a/arch/arm/boot/dts/berlin2.dtsi
> > +++ b/arch/arm/boot/dts/berlin2.dtsi
> > @@ -512,5 +512,11 @@
> >   				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> >   			};
> >   		};
> > +
> > +		pwm: pwm@f20000 {
> > +			compatible = "marvell,berlin-pwm";
> > +			reg = <0xf20000 0x40>;
> > +			#pwm-cells = <3>;
> > +		};
> 
> I only checked berlin2.dtsi:
> The top most line with <GIC_SPI 15 ...> belongs to a sub-node of
> apb@fc0000 - which means that the pwm node isn't sorted in by
> address. Please sort the nodes by address in all three DT patches.
> 
> BTW, is there any IRQ from the PWM IP routed to any intc upstream?
> A quick look into some BSP code does not reveal any hints maybe
> one of the Marvell guys can comment on it.

There's no interrupt for the PWM in all berlin SoCs ;)

Thanks,
Jisheng
