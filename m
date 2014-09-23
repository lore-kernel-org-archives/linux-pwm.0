From: Naidu Tellapati <naidu.tellapati@gmail.com>
Subject: Re: quick help on PDM DAC driver
Date: Tue, 23 Sep 2014 13:15:30 +0530
Message-ID: <CAC3mp007Gvyq7RJBu9ccy8EWPe-C17k0Dp9OSthrr0eBYwWPKw@mail.gmail.com>
References: <CAC3mp01MC3SaR8WmcDOXmGaB60eYfifx+YMT8xvxE2L=gZ093A@mail.gmail.com>
	<20140922112707.GR1470@ulmo>
	<CAC3mp01gADb-SPJhd9dYwKg2fQgmmeGDQ+xt8qYahRovNSpXMA@mail.gmail.com>
	<20140923072752.GK30514@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62722 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaIWHpb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Sep 2014 03:45:31 -0400
Received: by mail-ob0-f172.google.com with SMTP id uz6so2247238obc.31
        for <linux-pwm@vger.kernel.org>; Tue, 23 Sep 2014 00:45:30 -0700 (PDT)
In-Reply-To: <20140923072752.GK30514@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Hi Thierry,

Many thanks for your continued help. We really appreciate it. We use
Linux PWM Framework for our PWM driver. And probably add our PDM
driver to drivers/misc.

Thanks again.

Regards,
Naidu.




On Tue, Sep 23, 2014 at 12:57 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Sep 22, 2014 at 07:28:43PM +0530, Naidu Tellapati wrote:
>> Hi Thierry,
>>
>> Many thanks for your continued help in this regard.
>>
>> Each bit in my 12-bit input value to the PDM block does not in anyway
>> corresponds to fixed interval. My hardware PDM block works with the
>> following simple logic
>>
>> counter [12:0] = counter [11:0] + pluse_in [11:0]     /* pulse_in is a
>> 12-bit input value to PDM block */
>> pdm_out = counter [12]
>>
>> The above logic runs for every pdm_clk cycle.
>
> I don't see how this could reasonably fake a PWM. The best you can
> probably get is a 0%, 50% and 100% duty-cycles.
>
>> And hence I am of the opinion that I need to have a Linux PDM
>> Framework which is similar to PWM Framework and which provides
>> pulse_in as device attribute to the Linux User Space.
>
> Given the peculiarity of the device I don't think adding a framework is
> necessary. But you could perhaps add a driver to drivers/misc that
> exposes the pulse_in parameter in sysfs.
>
> Thierry
