From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] pwm: lpss: clean up series
Date: Mon, 14 Nov 2016 12:32:54 +0200
Message-ID: <1479119574.5295.143.camel@linux.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24078 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbcKNKc5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 14 Nov 2016 05:32:57 -0500
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
> 
> And the part I like most is -2 lines statistics!

Thierry, is there any chance to get it merged?

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
