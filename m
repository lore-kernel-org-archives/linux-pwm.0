From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/2] ARM: SAMSUNG: remove gpio flags in dev-backlight
Date: Tue, 06 May 2014 13:59:05 +0900
Message-ID: <0fa001cf68e7$e7c4c440$b74e4cc0$@samsung.com>
References: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
 <1393480414-19473-2-git-send-email-acourbot@nvidia.com>
 <CAAVeFu+XUzZ7ozMOcp6A-gZJ9o8DZFrdh1j4LvCQtoTcu=PP1g@mail.gmail.com>
 <000701cf54a2$7c1379c0$743a6d40$%han@samsung.com>
 <CAAVeFuKJnSk2XSsMZZKMfyabzJ5CYdqWdE91H5uHiYFC1r6HxA@mail.gmail.com>
 <CAAVeFuKeT9+m_yFc8ihfc_p5W--dCm0-eO+ccjv99WOwurAirQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13691 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaEFE7H (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 May 2014 00:59:07 -0400
In-reply-to: <CAAVeFuKeT9+m_yFc8ihfc_p5W--dCm0-eO+ccjv99WOwurAirQ@mail.gmail.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Alexandre Courbot' <gnurou@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>, 'Ben Dooks' <ben-linux@fluff.org>, 'Thierry Reding' <thierry.reding@gmail.com>
Cc: 'Alexandre Courbot' <acourbot@nvidia.com>, 'Bryan Wu' <cooloney@gmail.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>

Alexandre Courbot wrote:
> 
> On Thu, Apr 10, 2014 at 11:14 PM, Alexandre Courbot <gnurou@gmail.com>
> wrote:
> > On Thu, Apr 10, 2014 at 6:51 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> >> On Thursday, April 10, 2014 1:17 PM, Alexandre Courbot wrote:
> >>>
> >>> Ping, can I have the Samsung folks review and ,aybe even merge this
> >>> patch? enable_gpio_flags is never used in any code, is replaced by
> >>> gpiod, and we would like to remove it altogether from pwm_bl. Thanks!
> >>
> >> OK, I see. It looks good.
> >>
> >> As far as I know, 'enable_gpio_flags' has not been being used
> >> for Samsung platform. So, there will be no side effect,
> >> if 'enable_gpio_flags' is removed from 'arch/arm/plat-samsung'
> >> directory.
> >>
> >> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
> >
> > Great, thanks. Ben, Kukjin, could we have your Acked-by?
> >
> > Thierry, if the Samsung maintainers are ok with it, and 2/2 of this
> > series is also ok for you (you merged the same for simple-panel
> > already), can you take both into your tree?
> 
> Last call - could we have a Acked-by from Ben or Kukjin and merge this
> through Thierry's tree? Otherwise I will just have to drop this
> series, which would be sad.

Very sorry for late response. I missed... :(

Looks good to me, so please go ahead with my ack.

Thanks,
Kukjin

