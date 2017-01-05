From: Ilkka Koskinen <ilkka.koskinen@intel.com>
Subject: Re: [PATCH v2 0/4] pwm: lpss: clean up series
Date: Thu, 5 Jan 2017 00:09:19 -0800
Message-ID: <20170105080919.GA45669@kammari>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:12134 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031437AbdAEIJ4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 5 Jan 2017 03:09:56 -0500
Content-Disposition: inline
In-Reply-To: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jan 02, 2017 at 11:16:43AM +0200, Andy Shevchenko wrote:
> There are clean ups and switch to new atomic API (would be considered as an
> improvement).
> 
> The series tested on various Intel platforms, such as Edison and Minnowboard
> MAX.
> 
> And the part I like most is -2 lines statistics!
> 
> Thierry, what should we do to get this series in? It was already more than 2
> months of waiting for response from you. Two pings went to black hole.
> So, Cc'ing to Linus directly this time, sorry.
> 
> Since v1:
> - rebase on top of v4.10-rc2
> - fix typo in commit message of patch 1
> - add Mika's tag
> 
> Andy Shevchenko (3):
>   pwm: lpss: Avoid potential overflow of base_unit
>   pwm: lpss: Allow duty cycle to be 0
>   pwm: lpss: Switch to new atomic API
> 
> Mika Westerberg (1):
>   pwm: lpss: Do not export board infos for different PWM types
> 
>  drivers/pwm/pwm-lpss-pci.c      |  20 +++----
>  drivers/pwm/pwm-lpss-platform.c |  10 ++--
>  drivers/pwm/pwm-lpss.c          | 120 +++++++++++++++++++++-------------------
>  drivers/pwm/pwm-lpss.h          |  14 ++---
>  4 files changed, 81 insertions(+), 83 deletions(-)
> 
> -- 
> 2.11.0
> 

Tested-by: Ilkka Koskinen <ilkka.koskinen@intel.com>

Cheers, Ilkka
