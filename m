From: Shobhit Kumar <kumar@shobhit.info>
Subject: Re: [Intel-gfx] [PATCH 6/8] pwm: crc: Add Crystalcove (CRC) PWM driver
Date: Thu, 7 May 2015 12:43:44 +0530
Message-ID: <CAAbrOmcLynLOfphBbCHYBwc7uK=OKhXxRCYHNAx3X=Pi8S1_9Q@mail.gmail.com>
References: <1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
	<1430818716-27287-1-git-send-email-shobhit.kumar@intel.com>
	<1430898058.3843.30.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36348 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbEGHNp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 7 May 2015 03:13:45 -0400
Received: by qgeb100 with SMTP id b100so16660569qge.3
        for <linux-pwm@vger.kernel.org>; Thu, 07 May 2015 00:13:44 -0700 (PDT)
In-Reply-To: <1430898058.3843.30.camel@x220>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

On Wed, May 6, 2015 at 1:10 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Tue, 2015-05-05 at 15:08 +0530, Shobhit Kumar wrote:
>> The Crystalcove PMIC controls PWM signals and this driver exports that
>> capability as a PWM chip driver. This is platform device implementtaion
>> of the drivers/mfd cell device for CRC PMIC
>>
>> v2: Use the existing config callback with duty_ns and period_ns(Thierry)
>>
>> v3: Correct the subject line (Lee jones)
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
>
> The same comments can be made as for v2, see
> http://lkml.kernel.org/r/1430428322.2187.24.camel@x220 . Maybe you
> didn't receive that message.
>
> It could also be that you think my comments were invalid, or too vague,
> or whatever. Please say so, because then I don't have to bother you
> again when you send out v4.
>

Not at all, I just missed your comments and realise my mistake later
after sending next update. Somehow the mailing list filters that I
have setup are not working correctly. I will look into your comments.

Regards
Shobhit
