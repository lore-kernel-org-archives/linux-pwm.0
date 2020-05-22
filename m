From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Fri, 22 May 2020 15:59:23 -0700
Message-ID: <20200522225923.GA2873@codeaurora.org>
References: <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
 <20200522111657.GA2163848@ulmo>
 <20200522113147.GU271301@dell>
 <20200522125028.GG2163848@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:18099 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731029AbgEVW71 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 18:59:27 -0400
Content-Disposition: inline
In-Reply-To: <20200522125028.GG2163848@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Thompson <daniel.thompson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>

On Fri, May 22, 2020 at 02:50:28PM +0200, Thierry Reding wrote:
> Looking at v14 I think there are no longer any discussions (looks like
> the last comment I thought was from v14 was actually on v13 and it seems
> to have been solved in v14 now) and there are Acked-bys for all the non-
> PWM patches, so there's nothing in the way of me applying this to the
> PWM tree. I can let it soak there for a few days and send out a stable
> branch if anyone needs it if there aren't any huge issues.
> 
> Does that sound like a plan?

There is one ongoing discussion on v14 [1]: Daniel just gave me some
comments on the clps711x.c patch that I will address in the next
patchset. The plan you outlined sounds good to me - just let me send out
v15 which you may then pick up.

[1] https://lore.kernel.org/lkml/20200521101934.j5ivjky4e6byveut@holly.lan/

Thank you.

Guru Das.
