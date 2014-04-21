From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 1/2] ARM: SAMSUNG: remove gpio flags in dev-backlight
Date: Mon, 21 Apr 2014 15:07:50 +0900
Message-ID: <CAAVeFuKeT9+m_yFc8ihfc_p5W--dCm0-eO+ccjv99WOwurAirQ@mail.gmail.com>
References: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
 <1393480414-19473-2-git-send-email-acourbot@nvidia.com> <CAAVeFu+XUzZ7ozMOcp6A-gZJ9o8DZFrdh1j4LvCQtoTcu=PP1g@mail.gmail.com>
 <000701cf54a2$7c1379c0$743a6d40$%han@samsung.com> <CAAVeFuKJnSk2XSsMZZKMfyabzJ5CYdqWdE91H5uHiYFC1r6HxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:45639 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbaDUGIL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Apr 2014 02:08:11 -0400
In-Reply-To: <CAAVeFuKJnSk2XSsMZZKMfyabzJ5CYdqWdE91H5uHiYFC1r6HxA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Bryan Wu <cooloney@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Apr 10, 2014 at 11:14 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Thu, Apr 10, 2014 at 6:51 PM, Jingoo Han <jg1.han@samsung.com> wrote:
>> On Thursday, April 10, 2014 1:17 PM, Alexandre Courbot wrote:
>>>
>>> Ping, can I have the Samsung folks review and ,aybe even merge this
>>> patch? enable_gpio_flags is never used in any code, is replaced by
>>> gpiod, and we would like to remove it altogether from pwm_bl. Thanks!
>>
>> OK, I see. It looks good.
>>
>> As far as I know, 'enable_gpio_flags' has not been being used
>> for Samsung platform. So, there will be no side effect,
>> if 'enable_gpio_flags' is removed from 'arch/arm/plat-samsung'
>> directory.
>>
>> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
>
> Great, thanks. Ben, Kukjin, could we have your Acked-by?
>
> Thierry, if the Samsung maintainers are ok with it, and 2/2 of this
> series is also ok for you (you merged the same for simple-panel
> already), can you take both into your tree?

Last call - could we have a Acked-by from Ben or Kukjin and merge this
through Thierry's tree? Otherwise I will just have to drop this
series, which would be sad.
