From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] pwm: lpss: clean up series
Date: Wed, 14 Dec 2016 18:41:24 +0200
Message-ID: <1481733684.9552.3.camel@linux.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48550 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756082AbcLNQlp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 14 Dec 2016 11:41:45 -0500
In-Reply-To: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Mon, 2016-10-24 at 17:43 +0300, Andy Shevchenko wrote:
> There are clean ups and switch to new atomic API (would be considered
> as an
> improvement).
> 
> The series tested on various Intel platforms, such as Edison and
> Minnowboard
> MAX.

It's already two months and no single comment, no movement somewhere.

What should we do to get this pushed?


> 
> And the part I like most is -2 lines statistics!
> 
> Andy Shevchenko (3):
>   pwm: lpss: Avoid potential overflow of base_unit
>   pwm: lpss: Allow duty cycle to be 0
>   pwm: lpss: Switch to new atomic API
> 
> Mika Westerberg (1):
>   pwm: lpss: Do not export board infos for different PWM types
> 
>  drivers/pwm/pwm-lpss-pci.c      |  20 +++----
>  drivers/pwm/pwm-lpss-platform.c |  10 ++--
>  drivers/pwm/pwm-lpss.c          | 120 +++++++++++++++++++++--------
> -----------
>  drivers/pwm/pwm-lpss.h          |  14 ++---
>  4 files changed, 81 insertions(+), 83 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
