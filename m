From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: Allow for dynamic pwm period
 updates
Date: Wed, 26 Feb 2020 09:57:46 -0800
Message-ID: <20200226175746.GS37466@atomide.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:57804 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBZR5u (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Feb 2020 12:57:50 -0500
Content-Disposition: inline
In-Reply-To: <20200224052135.17278-1-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

* Lokesh Vutla <lokeshvutla@ti.com> [200224 05:23]:
> This series fixes minor issues in config callback and allows for on the
> fly updates for pwm period and duty cycle. This is mainly intended to
> allow pwm omap dmtimer to be used to generate a 1PPS signal that can be
> syncronized to PTP clock in CPTS module in AM335x and AM57xx SoCs.
> 
> Series tested after applying the following series:
> - https://patchwork.kernel.org/patch/11379875/
> - https://patchwork.kernel.org/project/linux-omap/list/?series=246183 
> 
> Full dependencies can be seen here:
> https://github.com/lokeshvutla/linux/tree/devel/pwm-1pps-generation
> 
> Lokesh Vutla (4):
>   pwm: omap-dmtimer: Drop unused header file
>   pwm: omap-dmtimer: Fix pwm enabling sequence
>   pwm: omap-dmtimer: Do not disable pwm before changing
>     period/duty_cycle
>   pwm: omap-dmtimer: Implement .apply callback

FYI, things seem to work for me after this set, but as it looks like
there will be v2 set of patches I want to test again with v2 out
before any Tested-by.

Thanks,

Tony
